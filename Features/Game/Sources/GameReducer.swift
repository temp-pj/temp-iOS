import ClientGame
import ComposableArchitecture
import Foundation
import Models

@Reducer
struct GameReducer {
    
    enum ServerConnectionState: String {
        case disconnected
        case connecting
        case connected
    }
    
    @ObservableState
    struct State: Equatable {
        var roundState: RoundState = .idle
        var roundData: RoundData?
        var roundResult: RoundResult?
        var connectionState: ServerConnectionState = .disconnected
        var roomID: UUID
        
    }
    
    enum Action {
        case onAppear
        case preloadSong(URL)
        case roundStart(RoundData)
        case submitAnswer(Submission)
        case answerWrong
        case roundResult(RoundResult)
        case connectSucceed
        case disconnected
        case penaltyFinished
        case nextRound
        case onDisappear
    }
    
    @Dependency(\.continuousClock) var clock
    @Dependency(\.gameClient) var gameClient
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                case .onAppear:
                    let roomID = state.roomID
                    state.connectionState = .connecting
                    
                    return .run { send in
                        try await gameClient.connect(roomID)
                        await send(.connectSucceed)
                        
                        for await event in gameClient.gameEvents() {
                            switch event {
                                case .preloadSong(let url):
                                    await send(.preloadSong(url))
                                    
                                case .roundStart(let data):
                                    await send(.roundStart(data))
                                    
                                case .roundResult(let result):
                                    await send(.roundResult(result))
                                    
                                case .answerWrong:
                                    await send(.answerWrong)
                            }
                        }
                        
                        await send(.disconnected)
                    }
                    
                case .connectSucceed:
                    state.connectionState = .connected
                    return .none
                    
                case .preloadSong(let url):
                    state.roundState = .loading(url)
                    return .none
                
                case .roundStart(let data):
                    state.roundData = data
                    state.roundState = .playing(.enabled)
                    return .none
                    
                case .submitAnswer(let submission):
                    state.roundState = .playing(.submitting)
                    
                    return .run { send in
                        try await gameClient.submitAnswer(submission)
                        
                    }
                    
                case .answerWrong:
                    state.roundState = .playing(.penalized)
                    
                    return .run { send in
                        try await clock.sleep(for: .milliseconds(500))
                        await send(.penaltyFinished)
                    }
                    
                case .penaltyFinished:
                    state.roundState = .playing(.enabled)
                    
                    return .none
                    
                case .roundResult(let result):
                    state.roundState = .result
                    state.roundResult = result
                    
                    return .none
                    
                case .nextRound:
                    if let data = state.roundData, data.isFinal {
                        state.roundState = .finished
                    } else {
                        state.roundState = .idle
                    }
                    
                    return .none
                    
                case .disconnected:
                    state.connectionState = .disconnected
                    return .none
                    
                case .onDisappear:
                    return .run { send in
                        try await gameClient.disconnect()
                    }
            }
        }
    }
}

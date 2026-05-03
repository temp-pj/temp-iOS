import ComposableArchitecture
import Foundation
import Models

@Reducer
struct GameReducer {
    @ObservableState
    struct State: Equatable {
        var roundState: RoundState = .idle
        var roundData: RoundData?
        var roundResult: RoundResult?
        
    }
    
    enum Action {
        case preloadSong(URL)
        case roundStart(RoundData)
        case submitAnswer(Submission)
        case answerWrong
        case roundResult(RoundResult)
        case penaltyFinished
        case nextRound
    }
    
    @Dependency(\.continuousClock) var clock
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                case .preloadSong(let url):
                    state.roundState = .loading(url)
                    return .none
                
                case .roundStart(let data):
                    state.roundData = data
                    state.roundState = .playing(.enabled)
                    return .none
                    
                case .submitAnswer(let submission):
                    state.roundState = .playing(.submitting)
                    
                    return .none
                    
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
                    
                default: return .none
            }
        }
    }
}

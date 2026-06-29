import ComposableArchitecture
import Foundation
import Models

@Reducer
public struct GameReducer {
    public typealias Letter = String
    
    public init() { }
    
    @ObservableState
    public struct State: Equatable {
        public var selectedLetters: [Letter] = []
        public var roundState: RoundState = .idle
        public var inputState: InputState = .enabled
        public var roundData: RoundData?
        public var roundResult: RoundResult?
        public var remainingTime = 0
    }
    
    public enum Action {
        case selectLetter(Int)
        case submit(String)
        case penaltyFinished
        
        case delegate(Delegate)
        case serverEvent(GameEvent)
        
        public enum Delegate {
            case playMusic
            case stopMusic
            case submitAnswer(String)
        }
    }
    
    enum CancelID {
        case penaltyTimer
    }
    
    @Dependency(\.continuousClock) var clock
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                case .selectLetter(let index):
                    guard state.inputState == .enabled else { return .none }
                    guard let roundData = state.roundData, index >= 0, index < roundData.letterCards.count,
                            state.selectedLetters.count < roundData.answerLength else { return .none }
                    let letter = roundData.letterCards[index]
                    state.selectedLetters.append(letter)
                    
                    if state.selectedLetters.count == roundData.answerLength {
                        return .send(.submit(state.selectedLetters.joined()))
                    }
                    
                    return .none
                    
                case .submit(let answer):
                    guard state.inputState == .enabled else { return .none }
                    state.inputState = .submitting
                    return .send(.delegate(.submitAnswer(answer)))
                    
                case .penaltyFinished:
                    guard state.inputState == .penalized else { return .none }
                    state.selectedLetters.removeAll(keepingCapacity: true)
                    state.inputState = .enabled
                    return .none
                    
                case .serverEvent(let event):
                    switch event {
                        case .roundStarted(let data):
                            state.selectedLetters = []
                            state.roundResult = nil
                            state.remainingTime = 0
                            state.roundData = data
                            state.roundState = .playing
                            state.inputState = .enabled
                            return .send(.delegate(.playMusic))
                            
                        case .wrongAnswer:
                            state.inputState = .penalized
                            
                            return .run { send in
                                try await clock.sleep(for: .milliseconds(500))
                                await send(.penaltyFinished)
                            }
                            .cancellable(id: CancelID.penaltyTimer, cancelInFlight: true)
                            
                        case .roundEnded(let result):
                            state.roundState = .result
                            state.roundResult = result
                            
                            return .send(.delegate(.stopMusic))
                            
                        
                        case .countDown(let remaining):
                            state.remainingTime = remaining
                            
                            return .none
                    }
                    
                case .delegate: return .none
            }
        }
    }
}

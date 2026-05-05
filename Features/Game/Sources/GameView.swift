import ComposableArchitecture
import ClientGame
import Models
import SwiftUI

struct GameView: View {
    @Bindable var store: StoreOf<GameReducer>
    
    var body: some View {
        VStack {
            Text("RoomID: \(store.roomID.uuidString)")
            Text("Round: \(String(describing: store.roundState))")
            Text("Connection: \(String(describing: store.connectionState))")
            
            if let roundData = store.roundData {
                HStack {
                    ForEach(Array(roundData.wordCards.enumerated()), id: \.offset) { _, word in
                        Text(word)
                            .bold()
                    }
                }
            }
            
            Button("Submit") {
                store.send(.submitAnswer(Submission(cards: ["매", "일", "듣", "는"], submissionTime: 36000)))
            }
            
            Button("Next Round") {
                store.send(.nextRound)
            }
            
        }
    }
}

#Preview("Idle") {
    GameView(store: Store(initialState: GameReducer.State(roomID: UUID()),
                          reducer: { GameReducer() }))
}

#Preview("Playing") {
    GameView(store: Store(initialState: GameReducer.State(
        roundState: .playing(.enabled),
        roundData: RoundData(roundNumber: 5, totalRounds: 22, wordCards: ["매", "일", "듣", "는"], timeLimit: 300),
        connectionState: .connected,
        roomID: UUID(1234567890)),
                          reducer: { GameReducer() }))
}

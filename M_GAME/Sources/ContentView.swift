import ComposableArchitecture
import FeatureRoom
import SwiftUI

struct ContentView: View {
    let store: StoreOf<AppFeature>
    @State private var roomID = ""
    
    var body: some View {
        VStack {
            if let roomStore = store.scope(state: \.room, action: \.room) {
                RoomView(store: roomStore)
            } else {
                
                TextField("방 아이디", text: $roomID)
                Button("방 입장") {
                    store.send(.joinRoomTapped(roomID))
                }
            }
        }
        .padding()
        .onAppear { store.send(.onAppear) }
    }
}

#Preview {
    ContentView(store: Store(initialState: AppFeature.State(),
                             reducer: { AppFeature() },
                             withDependencies: { $0.authClient = .live })
    )
}

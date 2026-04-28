import ComposableArchitecture
import SwiftUI

struct ContentView: View {
    let store: StoreOf<AppFeature>
    
    var body: some View {
        Text("Hello, World!")
            .padding()
    }
}

#Preview {
    ContentView(store: Store(initialState: AppFeature.State(),
                             reducer: { AppFeature() },
                             withDependencies: { $0.authClient = .mockSuccess })
    )
}

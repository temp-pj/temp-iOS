import ClientAuthLive
import ComposableArchitecture
import SwiftUI

@main
struct MGAMEApp: App {
    let store = Store(initialState: AppFeature.State()) {
        AppFeature()
    } withDependencies: {
        $0.authClient = .live
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(store: store)
        }
    }
}

import ClientAuthLive
import ClientMusicLive
import ClientRoomLive
import ComposableArchitecture
import SwiftUI

@main
struct MGAMEApp: App {
    let store = Store(initialState: AppFeature.State()) {
        AppFeature()
    } withDependencies: {
        $0.authClient = .live
        $0.musicClient = .live
        $0.roomClient = .live
        
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(store: store)
        }
    }
}

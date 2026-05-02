import ClientAudioLive
import ClientAuthLive
import ClientGameLive
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
        $0.gameClient = .live
        $0.audioClient = .live
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(store: store)
        }
    }
}

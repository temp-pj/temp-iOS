import ClientAudioLive
import ClientAuthLive
import ClientRoomSessionLive
import ClientMusicEntitlementLive
import ClientRoomLive
import ClientWebSocketLive
import ComposableArchitecture
import FeatureRoom
import Foundation
import SwiftUI

@main
struct MGAMEApp: App {
    let store = Store(initialState: AppFeature.State()) {
        AppFeature()
    } withDependencies: {
        $0.authClient = .live
        $0.musicEntitlementClient = .live
        $0.roomClient = .live
        $0.roomSessionClient = .live
        $0.audioClient = .live
        $0.webSocketClient = .live
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(store: store)
        }
    }
}

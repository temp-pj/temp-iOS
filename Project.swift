import ProjectDescription

let project = Project(
    name: "M_GAME",
    targets: [
        .target(name: "Models",
                destinations: .iOS,
                product: .framework,
                bundleId: "io.tuist.MGAME.Models",
                sources: ["Models/Sources/**"]
               ),
        
            .target(name: "ClientAuth",
                    destinations: .iOS,
                    product: .framework,
                    bundleId: "io.tuist.MGAME.ClientAuth",
                    sources: ["Clients/AuthClient/Interface/Sources/**"],
                    dependencies: [
                        .target(name: "Models"),
                        .external(name: "ComposableArchitecture")
                    ]
                   ),
        
            .target(name: "ClientAuthLive",
                    destinations: .iOS,
                    product: .framework,
                    bundleId: "io.tuist.MGAME.ClientAuthLive",
                    sources: ["Clients/AuthClient/Live/Sources/**"],
                    dependencies: [
                        .target(name: "ClientAuth"),
                        .target(name: "Models"),
                        .external(name: "ComposableArchitecture")
                    ]
                   ),
        
            .target(name: "ClientAuthTest",
                    destinations: .iOS,
                    product: .framework,
                    bundleId: "io.tuist.MGAME.ClientAuthTest",
                    sources: ["Clients/AuthClient/Test/Sources/**"],
                    dependencies: [
                        .target(name: "ClientAuth"),
                        .target(name: "Models"),
                        .external(name: "ComposableArchitecture")
                    ]
                   ),
        
            .target(
                name: "ClientRoom",
                destinations: .iOS,
                product: .framework,
                bundleId: "io.tuist.MGAME.ClientRoom",
                sources: ["Clients/RoomClient/Interface/Sources/**"],
                dependencies: [
                    .target(name: "Models"),
                    .external(name: "ComposableArchitecture")
                ]
            ),
        
            .target(name: "ClientRoomLive",
                    destinations: .iOS,
                    product: .framework,
                    bundleId: "io.tuist.MGAME.ClientRoomLive",
                    sources: ["Clients/RoomClient/Live/Sources/**"],
                    dependencies: [
                        .target(name: "ClientRoom"),
                        .target(name: "Models"),
                        .external(name: "ComposableArchitecture")
                    ]
                   ),
        
            .target(
                name: "ClientRoomTest",
                destinations: .iOS,
                product: .framework,
                bundleId: "io.tuist.MGAME.ClientRoomTest",
                sources: ["Clients/RoomClient/Test/Sources/**"],
                dependencies: [
                    .target(name: "ClientRoom"),
                    .target(name: "Models"),
                    .external(name: "ComposableArchitecture")
                ]
            ),
        
            .target(
                name: "ClientGame",
                destinations: .iOS,
                product: .framework,
                bundleId: "io.tuist.MGAME.ClientGame",
                sources: ["Clients/GameClient/Interface/Sources/**"],
                dependencies: [
                    .target(name: "Models"),
                    .external(name: "ComposableArchitecture")
                ]
            ),
        
            .target(name: "ClientGameLive",
                    destinations: .iOS,
                    product: .framework,
                    bundleId: "io.tuist.MGAME.ClientGameLive",
                    sources: ["Clients/GameClient/Live/Sources/**"],
                    dependencies: [
                        .target(name: "Models"),
                        .target(name: "ClientGame"),
                        .target(name: "ClientWebSocket"),
                        .external(name: "ComposableArchitecture")
                    ]
                   ),
        
            .target(name: "ClientGameTest",
                    destinations: .iOS,
                    product: .framework,
                    bundleId: "io.tuist.MGAME.ClientGameTest",
                    sources: ["Clients/GameClient/Test/Sources/**"],
                    dependencies: [
                        .target(name: "Models"),
                        .target(name: "ClientGame"),
                        .external(name: "ComposableArchitecture")
                    ]
                   ),
        
            .target(name: "ClientWebSocket",
                    destinations: .iOS,
                    product: .framework,
                    bundleId: "io.tuist.MGAME.ClientWebSocket",
                    sources: ["Clients/WebSocketClient/Interface/Sources/**"],
                    dependencies: [
                        .target(name: "Models"),
                        .external(name: "ComposableArchitecture")
                    ]
                   ),
        
        
            .target(name: "ClientWebSocketLive",
                    destinations: .iOS,
                    product: .framework,
                    bundleId: "io.tuist.MGAME.ClientWebSocketLive",
                    sources: ["Clients/WebSocketClient/Live/Sources/**"],
                    dependencies: [
                        .target(name: "Models"),
                        .target(name: "ClientWebSocket"),
                        .external(name: "ComposableArchitecture")
                    ]
                   ),
        
            .target(name: "ClientWebSocketTest",
                    destinations: .iOS,
                    product: .framework,
                    bundleId: "io.tuist.MGAME.ClientWebSocketTest",
                    sources: ["Clients/WebSocketClient/Test/Sources/**"],
                    dependencies: [
                        .target(name: "Models"),
                        .target(name: "ClientWebSocket"),
                        .external(name: "ComposableArchitecture")
                    ]
                   ),
        
        
        
            .target(
                name: "ClientMusic",
                destinations: .iOS,
                product: .framework,
                bundleId: "io.tuist.MGAME.ClientMusic",
                sources: ["Clients/MusicClient/Interface/Sources/**"],
                dependencies: [
                    .target(name: "Models"),
                    .external(name: "ComposableArchitecture")
                ]
            ),
        
            .target(name: "ClientMusicLive",
                    destinations: .iOS,
                    product: .framework,
                    bundleId: "io.tuist.MGAME.ClientMusicLive",
                    sources: ["Clients/MusicClient/Live/Sources/**"],
                    dependencies: [
                        .target(name: "Models"),
                        .target(name: "ClientMusic"),
                        .external(name: "ComposableArchitecture")
                    ]),
        
            .target(name: "ClientMusicTest",
                    destinations: .iOS,
                    product: .framework,
                    bundleId: "io.tuist.MGAME.ClientMusicTest",
                    sources: ["Clients/MusicClient/Test/Sources/**"],
                    dependencies: [
                        .target(name: "Models"),
                        .target(name: "ClientMusic"),
                        .external(name: "ComposableArchitecture")
                    ]
                   ),
        
            .target(
                name: "ClientAudio",
                destinations: .iOS,
                product: .framework,
                bundleId: "io.tuist.MGAME.ClientAudio",
                sources: ["Clients/AudioClient/Interface/Sources/**"],
                dependencies: [
                    .target(name: "Models"),
                    .external(name: "ComposableArchitecture")
                ]
            ),
        
            .target(
                name: "ClientAudioLive",
                destinations: .iOS,
                product: .framework,
                bundleId: "io.tuist.MGAME.ClientAudioLive",
                sources: ["Clients/AudioClient/Live/Sources/**"],
                dependencies: [
                    .target(name: "Models"),
                    .target(name: "ClientAudio"),
                    .external(name: "ComposableArchitecture")
                ]
            ),
        
            .target(
                name: "ClientAudioTest",
                destinations: .iOS,
                product: .framework,
                bundleId: "io.tuist.MGAME.ClientAudioTest",
                sources: ["Clients/AudioClient/Test/Sources/**"],
                dependencies: [
                    .target(name: "Models"),
                    .target(name: "ClientAudio"),
                    .external(name: "ComposableArchitecture")
                ]
            ),
        
            .target(
                name: "FeatureLogin",
                destinations: .iOS,
                product: .framework,
                bundleId: "io.tuist.MGAME.FeatureLogin",
                sources: ["Features/Login/Sources/**"],
                dependencies: [
                    .target(name: "MDS"),
                    .target(name: "Models"),
                    .target(name: "ClientAuth"),
                    .external(name: "ComposableArchitecture")
                ]
            ),
        .target(
            name: "FeatureLobby",
            destinations: .iOS,
            product: .framework,
            bundleId: "io.tuist.MGAME.FeatureLobby",
            sources: ["Features/Lobby/Sources/**"],
            dependencies: [
                .target(name: "MDS"),
                .target(name: "Models"),
                .target(name: "ClientAuth"),
                .target(name: "ClientRoom"),
                .external(name: "ComposableArchitecture")
            ]
        ),
        
            .target(
                name: "FeatureGame",
                destinations: .iOS,
                product: .framework,
                bundleId: "io.tuist.MGAME.FeatureGame",
                sources: ["Features/Game/Sources/**"],
                dependencies: [
                    .target(name: "MDS"),
                    .target(name: "Models"),
                    .target(name: "ClientGame"),
                    .target(name: "ClientMusic"),
                    .target(name: "ClientAudio"),
                    .external(name: "ComposableArchitecture")
                ]
            ),
        
            .target(name: "FeatureGameTest",
                    destinations: .iOS,
                    product: .unitTests,
                    bundleId: "io.tuist.MGAME.FeatureGameTest",
                    sources: ["Features/Game/Tests/**"],
                    dependencies: [
                        .target(name: "FeatureGame"),
                        .target(name: "ClientGameTest"),
                        .target(name: "ClientAudioTest"),
                        .target(name: "ClientMusicTest")
                    ]
                   ),
        
            .target(name: "MDS",
                    destinations: .iOS,
                    product: .framework,
                    bundleId: "io.tuist.MGAME.MDS",
                    sources: ["Shared/MDS/Sources/**"],
                    resources: ["Shared/MDS/Resources/**"]
                   ),
        
            .target(
                name: "M_GAME",
                destinations: .iOS,
                product: .app,
                bundleId: "io.tuist.M-GAME",
                infoPlist: .extendingDefault(
                    with: [
                        "UILaunchScreen": [
                            "UIColorName": "",
                            "UIImageName": "",
                        ],
                    ]
                ),
                sources: ["M_GAME/Sources/**"],
                resources: ["M_GAME/Resources/**"],
                dependencies: [
                    .target(name: "FeatureLogin"),
                    .target(name: "FeatureLobby"),
                    .target(name: "FeatureGame"),
                    .target(name: "ClientAudioLive"),
                    .target(name: "ClientAuthLive"),
                    .target(name: "ClientRoomLive"),
                    .target(name: "ClientMusicLive"),
                    .target(name: "ClientGameLive"),
                    .external(name: "ComposableArchitecture")
                ]
            ),
    ]
)

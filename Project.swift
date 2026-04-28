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
                sources: ["Clients/RoomClient/Sources/**"],
                dependencies: [.target(name: "Models"), .external(name: "ComposableArchitecture")]
            ),
        
            .target(
                name: "ClientWebSocket",
                destinations: .iOS,
                product: .framework,
                bundleId: "io.tuist.MGAME.ClientWebSocket",
                sources: ["Clients/WebSocketClient/Sources/**"],
                dependencies: [.target(name: "Models"), .external(name: "ComposableArchitecture")]
            ),
        
            .target(
                name: "ClientMusic",
                destinations: .iOS,
                product: .framework,
                bundleId: "io.tuist.MGAME.ClientMusic",
                sources: ["Clients/MusicClient/Sources/**"],
                dependencies: [.target(name: "Models"), .external(name: "ComposableArchitecture")]
            ),
        
            .target(
                name: "ClientAudio",
                destinations: .iOS,
                product: .framework,
                bundleId: "io.tuist.MGAME.ClientAudio",
                sources: ["Clients/AudioClient/Sources/**"],
                dependencies: []
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
                .target(name: "ClientWebSocket"),
                .target(name: "ClientMusic"),
                .target(name: "ClientAudio"),
                .external(name: "ComposableArchitecture")
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
                .target(name: "ClientAuthLive"),
                .target(name: "ClientAuthTest"),
                .external(name: "ComposableArchitecture")
            ]
        ),
    ]
)

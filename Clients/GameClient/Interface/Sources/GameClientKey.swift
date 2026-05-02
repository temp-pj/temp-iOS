//
//  GameClientKey.swift
//  ClientGame
//
//  Created by 송지혁 on 5/2/26.
//

import Dependencies

extension GameClient: DependencyKey {
    static public var liveValue: GameClient = GameClient(connect: unimplemented("GameClient.connect"),
                                                         submitAnswer: unimplemented("GameClient.submitAnswer"),
                                                         gameEvents: unimplemented("GameClient.gameEvents"),
                                                         disconnect: unimplemented("GameClient.disconnect"))
}

extension DependencyValues {
    public var gameClient: GameClient {
        get { self[GameClient.self] }
        set { self[GameClient.self] = newValue }
    }
}

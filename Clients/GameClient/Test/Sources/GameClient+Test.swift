//
//  WebSocketClient+Test.swift
//  ClientGameTest
//
//  Created by 송지혁 on 5/2/26.
//

import ClientGame
import Models

public extension GameClient {
    static let mockSuccess = GameClient { _ in
        
    } submitAnswer: { _ in
        
    } gameEvents: {
        AsyncStream<GameEvent> { $0.finish() }
    } disconnect: {
        
    }
}

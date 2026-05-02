//
//  WebSocketClient+Live.swift
//  ClientGameLive
//
//  Created by 송지혁 on 5/2/26.
//

import ClientGame

public extension GameClient {
    static let live = GameClient { _ in
        fatalError("game connect live implementation is not implemented yet")
    } submitAnswer: { _ in
        fatalError("game submit answer live implementation is not implemented yet")
    } gameEvents: {
        fatalError("game events live implementation is not implemented yet")
    } disconnect: {
        fatalError("game disconnect live implementation is not implemented yet")
    }

}

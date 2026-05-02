//
//  WebSocketClient+Live.swift
//  ClientWebSocket
//
//  Created by 송지혁 on 5/2/26.
//

import ClientWebSocket

public extension WebSocketClient {
    static let live: WebSocketClient = WebSocketClient { _ in
        fatalError("websocket connect live implementation is not implemented yet")
    } send: { _ in
        fatalError("websocket send live implementation is not implemented yet")
    } receive: {
        fatalError("websocket receive live implementation is not implemented yet")
    } disconnect: {
        fatalError("websocket disconnect live implementation is not implemented yet")
    }
}

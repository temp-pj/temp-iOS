//
//  WebSocketClientKey.swift
//  ClientWebSocket
//
//  Created by 송지혁 on 5/2/26.
//

import Dependencies

extension WebSocketClient: DependencyKey {
    static public var liveValue = WebSocketClient(connect: unimplemented("WebSocketClient.connect"),
                                                  send: unimplemented("WebSocketClient.send"),
                                                  receive: unimplemented("WebSocketClient.receive"),
                                                  disconnect: unimplemented("WebSocketClient.disconnect"))
}

extension DependencyValues {
    public var webSocketClient: WebSocketClient {
        get { self[WebSocketClient.self] }
        set { self[WebSocketClient.self] = newValue }
    }
}

//
//  WebSocketClient+Test.swift
//  ClientWebSocket
//
//  Created by 송지혁 on 5/2/26.
//

import ClientWebSocket
import Models

public extension WebSocketClient {
    static let mockSuccess = WebSocketClient { _ in
        
    } send: { _ in
        
    } receive: {
        AsyncStream<String> { $0.finish() }
    } disconnect: {
        
    }
}

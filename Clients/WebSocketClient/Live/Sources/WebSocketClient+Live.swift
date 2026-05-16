//
//  WebSocketClient+Live.swift
//  ClientWebSocket
//
//  Created by 송지혁 on 5/2/26.
//

import ClientWebSocket
import Foundation

public extension WebSocketClient {
    static var live: WebSocketClient {
        let connection = WebSocketConnection()
        
        return WebSocketClient { url in
            await connection.connect(url: url)
        } send: { message in
            try await connection.send(text: message)
        } receive: {
            await connection.receive()
        } disconnect: {
            await connection.disconnect()
        }
    }
}

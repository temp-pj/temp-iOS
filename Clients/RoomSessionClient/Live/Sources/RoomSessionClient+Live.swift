//
//  WebSocketClient+Live.swift
//  ClientGameLive
//
//  Created by 송지혁 on 5/2/26.
//

import ClientRoomSession
import ClientWebSocket
import Dependencies
import Foundation
import Models

enum RoomSessionError: Error {
    case invalidURL
    case encodingFailed
}

public extension RoomSessionClient {
    static var live: RoomSessionClient {
        @Dependency(\.webSocketClient) var webSocketClient
        
        return RoomSessionClient { roomID in
            guard let url = URL(string: "wss://\(roomID)") else { throw RoomSessionError.invalidURL  }
            try await webSocketClient.connect(url)
        } send: { request in
            let message = WebSocketMessage.from(request)
            let data = try JSONEncoder().encode(message)
            guard let jsonString = String(data: data, encoding: .utf8) else { throw RoomSessionError.encodingFailed }
            try await webSocketClient.send(jsonString)
            
        } roomEvents: {
            AsyncStream<RoomEvent> { continuation in
                Task {
                    for await event in await webSocketClient.receive() {
                        switch event {
                            case .connected:
                                continuation.yield(.serverConnectionChanged(.connected))
                            case .disconnected(let reason):
                                switch reason {
                                    case .normal:
                                        continuation.yield(.serverConnectionChanged(.disconnected(.normal)))
                                    case .networkError:
                                        continuation.yield(.serverConnectionChanged(.disconnected(.networkError)))
                                }
                                
                            case .message(let rawString):
                                if let data = rawString.data(using: .utf8) {
                                    do {
                                        let message = try JSONDecoder().decode(WebSocketMessage.self, from: data)
                                        let event = try message.toRoomEvent()
                                        continuation.yield(event)
                                    } catch { continue }
                                    
                                }
                        }
                        
                    }
                    
                    continuation.finish()
                }
            }
        } disconnect: {
            try await webSocketClient.disconnect()
        }
    }
}
    

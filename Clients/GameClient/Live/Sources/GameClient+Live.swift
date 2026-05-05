//
//  WebSocketClient+Live.swift
//  ClientGameLive
//
//  Created by 송지혁 on 5/2/26.
//

import ClientGame
import ClientWebSocket
import Dependencies
import Foundation
import Models

enum GameClientError: Error {
    case invalidURL
    case encodingFailed
}

public extension GameClient {
    static var live: GameClient {
        @Dependency(\.webSocketClient) var webSocketClient
        
        return GameClient { roomID in
            guard let url = URL(string: "wss://\(roomID)") else { throw GameClientError.invalidURL  }
            try await webSocketClient.connect(url)
        } submitAnswer: { submission in
            let data = try JSONEncoder().encode(submission)
            guard let jsonString = String(data: data, encoding: .utf8) else { throw GameClientError.encodingFailed }
            
            try await webSocketClient.send(jsonString)
        } gameEvents: {
            AsyncStream<GameEvent> { continuation in
                Task {
                    for await rawString in await webSocketClient.receive() {
                        if let data = rawString.data(using: .utf8),
                           let event = try? JSONDecoder().decode(GameEvent.self, from: data) {
                            continuation.yield(event)
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
    

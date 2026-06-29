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
            let host = ServerConfig.host
            
            let urlString: String
            if let roomID {
                urlString = "ws://\(host)/ws?room=\(roomID.uuidString.lowercased())"
            } else {
                urlString = "ws://\(host)/ws"
            }
            
            guard let url = URL(string: urlString) else { throw RoomSessionError.invalidURL }
            try await webSocketClient.connect(url)
        } send: { request in
            let data = try RoomMessageCodec.encode(request)
            guard let jsonString = String(data: data, encoding: .utf8) else { throw RoomSessionError.encodingFailed }
            try await webSocketClient.send(jsonString)
            
        } roomEvents: {
            AsyncStream<RoomEvent> { continuation in
                Task {
                    for await event in await webSocketClient.receive() {
                        switch event {
                            case .connected:
                                continuation.yield(.serverConnectionChanged(.connecting))
                            case .disconnected(let reason):
                                switch reason {
                                    case .normal:
                                        continuation.yield(.serverConnectionChanged(.disconnected(.normal)))
                                    case .networkError:
                                        continuation.yield(.serverConnectionChanged(.disconnected(.networkError)))
                                }
                                
                            case .message(let rawString):
                                print("수신된 websocket 메시지: \(rawString)")
                                if let data = rawString.data(using: .utf8) {
                                    do {
                                        let type = try JSONDecoder().decode(TypePeek.self, from: data).type
                                        
                                        guard let event = try RoomMessageCodec.decode(data, type: type)
                                                ?? SessionMessageCodec.decode(data, type: type) else { continue }
                                        
                                        continuation.yield(event)
                                    } catch {
                                        print("decode 실패: \(error) / 원문: \(rawString)")
                                        continue
                                    }
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
    

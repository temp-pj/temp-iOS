//
//  SessionMessageCodec.swift
//  Models
//
//  Created by 송지혁 on 6/22/26.
//

import Foundation
import Models

enum SessionMessageCodecError: Error {
    case unknownType(String)
}

public enum SessionMessageCodec {
    static func decode(_ data: Data, type: String) throws -> RoomEvent? {
        
        switch type {
            case "WELCOME":
                let payload = try JSONDecoder().decode(WebSocketMessage<WelcomePayload>.self, from: data).payload
                
                let players = payload.players.map { Player(id: UUID(uuidString: $0)!) }
                
                let roomConnectionInfo = RoomConnectionInfo(myPlayerID: payload.playerID,
                                                            roomID: payload.roomID,
                                                            hostID: payload.hostID,
                                                            roomState: payload.roomState,
                                                            players: players,
                                                            maxPlayers: payload.maxPlayers)
                
                return .serverConnectionChanged(.connected(roomConnectionInfo))
                
            default: return nil
        }
    }
}

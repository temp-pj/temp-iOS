//
//  Message.swift
//  Models
//
//  Created by 송지혁 on 5/12/26.
//

import Foundation

enum GameMessage {
    case playerJoined(PlayerJoinedPayload)
    case playerLeft(PlayerLeftPayload)
}

extension GameMessage: Decodable {
    enum CodingKeys: String, CodingKey {
        case type = "Type"
        case payload = "Payload"
        case timestamp = "Timestamp"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)
        
        switch type {
            case "PLAYER_JOINED":
                let payload = try container.decode(PlayerJoinedPayload.self, forKey: .payload)
                self = .playerJoined(payload)
                
            case "PLAYER_LEFT":
                let payload = try container.decode(PlayerLeftPayload.self, forKey: .payload)
                self = .playerLeft(payload)
                
            default:
                self = .unknown
        }
    }
}

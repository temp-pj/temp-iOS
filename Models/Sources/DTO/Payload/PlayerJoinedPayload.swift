//
//  PlayerJoinedPayload.swift
//  M_GAME
//
//  Created by 송지혁 on 5/12/26.
//

struct PlayerJoinedPayload: Codable {
    let playerId: String
    
    enum CodingKeys: String, CodingKey {
        case playerId = "PlayerID"
    }
}

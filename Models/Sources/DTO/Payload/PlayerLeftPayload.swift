//
//  PlayerLeftPayload.swift
//  M_GAME
//
//  Created by 송지혁 on 5/12/26.
//


struct PlayerLeftPayload: Codable {
    let playerId: String
    
    enum CodingKeys: String, CodingKey {
        case playerId = "PlayerID"
    }
}

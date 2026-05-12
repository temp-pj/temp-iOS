//
//  PlayerJoinedPayload.swift
//  M_GAME
//
//  Created by 송지혁 on 5/12/26.
//

public struct PlayerJoinedPayload: Codable {
    public let playerId: String
    
    enum CodingKeys: String, CodingKey {
        case playerId = "PlayerID"
    }
}

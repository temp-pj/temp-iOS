//
//  PlayerLeftPayload.swift
//  M_GAME
//
//  Created by 송지혁 on 5/12/26.
//

public struct PlayerLeftPayload: Codable {
    public let playerId: String
    
    enum CodingKeys: String, CodingKey {
        case playerId = "PlayerID"
    }
}

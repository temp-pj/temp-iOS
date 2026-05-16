//
//  KickPlayerPayload.swift
//  Models
//
//  Created by 송지혁 on 5/14/26.
//

import Foundation

public struct KickPlayerPayload: Codable {
    let playerId: UUID
    
    enum CodingKeys: String, CodingKey {
        case playerId = "player_id"
    }
}

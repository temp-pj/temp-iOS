//
//  Player.swift
//  Models
//
//  Created by 송지혁 on 5/13/26.
//

import Foundation

public struct Player: Codable, Equatable {
    public let id: UUID
    
    public init(id: UUID) {
        self.id = id
    }
    
}

//
//  RoomRequest.swift
//  Models
//
//  Created by 송지혁 on 5/13/26.
//

import Foundation

public typealias PlayerID = UUID

public enum RoomRequest: Equatable {
    case startGame
    case kickPlayer(PlayerID)
    case game(GameRequest)
}

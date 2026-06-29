//
//  RoomRequest.swift
//  Models
//
//  Created by 송지혁 on 5/13/26.
//

import Foundation

public typealias PlayerID = String

public enum RoomRequest: Equatable {
    case startGame(category: Category, trackCount: Int, timeLimit: Int)
    case readyToPlay(Int)
    case kickPlayer(PlayerID)
    case game(GameRequest)
}

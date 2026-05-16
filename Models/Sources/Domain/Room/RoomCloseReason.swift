//
//  RoomCloseReason.swift
//  Models
//
//  Created by 송지혁 on 5/13/26.
//

public enum RoomCloseReason: Codable, Equatable {
    case serverShutdown
    case timeout
}

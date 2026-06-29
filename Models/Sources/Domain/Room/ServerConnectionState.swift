//
//  ServerConnectionState.swift
//  Models
//
//  Created by 송지혁 on 5/13/26.
//

public enum ServerConnectionState: Equatable {
    case connecting
    case connected(RoomConnectionInfo)
    case reconnecting
    case disconnected(DisconnectReason)
}

public enum DisconnectReason: Codable, Equatable {
    case normal
    case networkError
    case kicked
}

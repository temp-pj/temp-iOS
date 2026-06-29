//
//  WelcomePayload.swift
//  Models
//
//  Created by 송지혁 on 6/22/26.
//

public struct WelcomePayload: Codable {
    public let hostID: String
    public let roomID: String
    public let playerID: String
    public let players: [String]
    public let roomState: String
    public let maxPlayers: Int
}

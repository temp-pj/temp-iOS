//
//  GameOverPayload.swift
//  Models
//
//  Created by 송지혁 on 6/4/26.
//

public struct GameOverPayload: Codable {
    public let winner: String
    public let scores: [String: Int]
}

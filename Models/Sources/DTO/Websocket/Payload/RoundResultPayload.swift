//
//  RoundResultPayload.swift
//  Models
//
//  Created by 송지혁 on 6/4/26.
//

public struct RoundResultPayload: Codable {
    public let winner: String
    public let correctAnswer: String
    public let scores: [String: Int]
}

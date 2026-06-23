//
//  GameResult.swift
//  Models
//
//  Created by 송지혁 on 5/13/26.
//

public struct GameResult: Equatable, Sendable, Decodable {
    public let winner: String
    public let scores: [String: Int]
    
    public init(winner: String, scores: [String: Int]) {
        self.winner = winner
        self.scores = scores
    }
}

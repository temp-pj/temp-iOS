//
//  RoundResult.swift
//  Models
//
//  Created by 송지혁 on 5/3/26.
//

import Foundation

public struct RoundResult: Equatable, Sendable, Codable {
    public let winnerId: String?
    public let correctAnswer: String
    public let scores: [String: Int]
    
    public init(winnerId: String?, correctAnswer: String, scores: [String: Int]) {
        self.winnerId = winnerId
        self.correctAnswer = correctAnswer
        self.scores = scores
    }
}

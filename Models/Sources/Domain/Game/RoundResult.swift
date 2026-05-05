//
//  RoundResult.swift
//  Models
//
//  Created by 송지혁 on 5/3/26.
//

import Foundation

public struct RoundResult: Equatable, Sendable, Decodable {
    public let winnerId: UUID?
    public let correctAnswer: String
    public let scores: [UUID: Int]
    
    public init(winnerId: UUID?, correctAnswer: String, scores: [UUID : Int]) {
        self.winnerId = winnerId
        self.correctAnswer = correctAnswer
        self.scores = scores
    }
}

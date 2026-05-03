//
//  RoundResult.swift
//  Models
//
//  Created by 송지혁 on 5/3/26.
//

import Foundation

public struct RoundResult: Equatable {
    let winnerId: UUID?
    let correctAnswer: String
    let scores: [UUID: Int]
    
    public init(winnerId: UUID?, correctAnswer: String, scores: [UUID : Int]) {
        self.winnerId = winnerId
        self.correctAnswer = correctAnswer
        self.scores = scores
    }
}

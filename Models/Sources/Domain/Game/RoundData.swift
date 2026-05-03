//
//  RoundData.swift
//  Models
//
//  Created by 송지혁 on 5/3/26.
//

import Foundation

public struct RoundData: Equatable {
    public let roundNumber: Int
    public let totalRounds: Int
    public let wordCards: [String]
    public let timeLimit: TimeInterval
    
    public var isFinal: Bool { roundNumber == totalRounds }
    
    public init(roundNumber: Int, totalRounds: Int, wordCards: [String], timeLimit: TimeInterval) {
        self.roundNumber = roundNumber
        self.totalRounds = totalRounds
        self.wordCards = wordCards
        self.timeLimit = timeLimit
    }
}

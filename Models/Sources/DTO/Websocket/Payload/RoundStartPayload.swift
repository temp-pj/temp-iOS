//
//  RoundStartPayload.swift
//  Models
//
//  Created by 송지혁 on 6/4/26.
//

import Foundation

public struct RoundStartPayload: Codable {
    public let roundNumber: Int
    public let totalRounds: Int
    public let answerLength: Int
    public let letterCards: [String]
    
    public init(roundNumber: Int, totalRounds: Int, letterCards: [String], answerLength: Int) {
        self.roundNumber = roundNumber
        self.totalRounds = totalRounds
        self.answerLength = answerLength
        self.letterCards = letterCards
    }
}

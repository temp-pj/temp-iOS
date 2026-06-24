//
//  RoomTestMocks.swift
//  FeatureRoom
//
//  Created by 송지혁 on 5/15/26.
//

import Foundation
import Models

extension RoundData {
    static func mock(roundNumber: Int, totalRounds: Int, wordCards: [String], answerLength: Int, timeLimit: TimeInterval) -> RoundData {
        return RoundData(roundNumber: roundNumber,
                         totalRounds: totalRounds,
                         letterCards: wordCards,
                         answerLength: answerLength)
    }
}

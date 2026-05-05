//
//  Submission.swift
//  Models
//
//  Created by 송지혁 on 5/3/26.
//

import Foundation

public struct Submission: Equatable, Encodable {
    let cards: [String]
    let submissionTime: TimeInterval
    
    public init(cards: [String], submissionTime: TimeInterval) {
        self.cards = cards
        self.submissionTime = submissionTime
    }
}

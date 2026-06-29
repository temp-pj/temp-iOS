//
//  GameEvent.swift
//  Models
//
//  Created by 송지혁 on 5/2/26.
//

import Foundation

public enum GameEvent: Equatable, Sendable {
    case roundStarted(RoundData)
    case countDown(Int)
    case wrongAnswer(playerID: String, wrongAnswer: String)
    case roundEnded(RoundResult)
}

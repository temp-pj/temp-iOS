//
//  GameEvent.swift
//  Models
//
//  Created by 송지혁 on 5/2/26.
//

import Foundation

public enum GameEvent: Equatable, Sendable {
    case preloadSong(URL)
    case nextRound
    case roundStarted(RoundData)
    case wrongAnswer
    case roundEnded(RoundResult)
}

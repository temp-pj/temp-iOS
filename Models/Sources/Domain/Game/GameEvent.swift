//
//  GameEvent.swift
//  Models
//
//  Created by 송지혁 on 5/2/26.
//

import Foundation

public enum GameEvent: Equatable, Sendable, Decodable {
    case preloadSong(URL)
    case roundStart(RoundData)
    case answerWrong
    case roundResult(RoundResult)
}

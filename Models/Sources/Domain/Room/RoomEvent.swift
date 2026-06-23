//
//  RoomEvent.swift
//  FeatureRoom
//
//  Created by 송지혁 on 5/13/26.
//

import Foundation

public enum RoomEvent: Equatable {
    case playerJoined(Player)
    case playerLeft(Player)
    case hostChanged(Player)
    case kicked
    case serverConnectionChanged(ServerConnectionState)
    case gameStarted
    case gameFinished(GameResult)
    case preloadSong(isrc: String, startTime: Int, roundNumber: Int)
    case game(GameEvent)
}

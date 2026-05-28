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
    case serverConnectionChanged(ServerConnectionState)
    case roomClosed(RoomCloseReason)
    case gameStarted
    case gameFinished(GameResult)
    case preloadSong(PreloadSong)
    case game(GameEvent)
}

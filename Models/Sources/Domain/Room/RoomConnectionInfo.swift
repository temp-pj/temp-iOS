//
//  RoomConnectionInfo.swift
//  Models
//
//  Created by 송지혁 on 6/22/26.
//

public struct RoomConnectionInfo: Equatable {
    public let myPlayerID: String
    public let roomID: String
    public let hostID: String
    public let roomState: String
    public let players: [Player]
    public let maxPlayers: Int
    
    public init(myPlayerID: String, roomID: String, hostID: String, roomState: String, players: [Player], maxPlayers: Int) {
        self.myPlayerID = myPlayerID
        self.roomID = roomID
        self.hostID = hostID
        self.roomState = roomState
        self.players = players
        self.maxPlayers = maxPlayers
    }
}

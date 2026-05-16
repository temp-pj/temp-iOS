//
//  GameClientKey.swift
//  ClientGame
//
//  Created by 송지혁 on 5/2/26.
//

import Dependencies

extension RoomSessionClient: DependencyKey {
    static public var liveValue: RoomSessionClient = RoomSessionClient(connect: unimplemented("GameClient.connect"),
                                                         send: unimplemented("GameClient.send"),
                                                         roomEvents: unimplemented("GameClient.gameEvents"),
                                                         disconnect: unimplemented("GameClient.disconnect"))
}

extension DependencyValues {
    public var roomSessionClient: RoomSessionClient {
        get { self[RoomSessionClient.self] }
        set { self[RoomSessionClient.self] = newValue }
    }
}

//
//  RoomClientKey.swift
//  ClientRoom
//
//  Created by 송지혁 on 4/30/26.
//

import Dependencies

extension RoomClient: DependencyKey {
    public static let liveValue = RoomClient(
        createRoom: unimplemented("RoomClient.create"),
        fetchRoom: unimplemented("RoomClient.fetch"),
        updateRoom: unimplemented("RoomClient.update"),
        closeRoom: unimplemented("RoomClient.close")
    )
    
    public static let testValue = RoomClient(
        createRoom: unimplemented("RoomClient.create"),
        fetchRoom: unimplemented("RoomClient.fetch"),
        updateRoom: unimplemented("RoomClient.update"),
        closeRoom: unimplemented("RoomClient.close")
    )
}

extension DependencyValues {
    public var roomClient: RoomClient {
        get { self[RoomClient.self] }
        set { self[RoomClient.self] = newValue }
    }
}

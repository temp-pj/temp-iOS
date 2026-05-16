//
//  WebSocketClient+Test.swift
//  ClientGameTest
//
//  Created by 송지혁 on 5/2/26.
//

import ClientRoomSession
import ConcurrencyExtras
import Foundation
import Models

public extension RoomSessionClient {
    static func mock(
    connect: @escaping @Sendable (UUID) async throws -> Void = { _ in },
    send: @escaping @Sendable (RoomRequest) async throws -> Void = { _ in },
    roomEvents: @escaping @Sendable () -> AsyncStream<RoomEvent> = { .finished },
    disconnect: @escaping @Sendable () async throws -> Void = { }
    ) -> Self {
        Self(connect: connect, send: send, roomEvents: roomEvents, disconnect: disconnect)
    }
}

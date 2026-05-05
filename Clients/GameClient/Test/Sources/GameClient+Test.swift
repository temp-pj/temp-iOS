//
//  WebSocketClient+Test.swift
//  ClientGameTest
//
//  Created by 송지혁 on 5/2/26.
//

import ClientGame
import ConcurrencyExtras
import Foundation
import Models

public extension GameClient {
    static func mock(
    connect: @escaping @Sendable (UUID) async throws -> Void = { _ in },
    onSubmitAnswer: @escaping @Sendable (Submission) async throws -> Void = { _ in },
    events: @escaping @Sendable () -> AsyncStream<GameEvent> = { .finished },
    onDisconnect: @escaping @Sendable () async throws -> Void = { }
    ) -> Self {
        Self(connect: connect, submitAnswer: onSubmitAnswer, gameEvents: events, disconnect: onDisconnect)
    }
}

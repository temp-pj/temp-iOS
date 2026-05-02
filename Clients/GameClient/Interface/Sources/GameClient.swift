import Foundation
import Models

public struct GameClient: Sendable {
    public var connect: @Sendable (UUID) async throws -> Void
    public var submitAnswer: @Sendable (String) async throws -> Void
    public var gameEvents: @Sendable () -> AsyncStream<GameEvent>
    public var disconnect: @Sendable () async throws -> Void
    
    public init(connect: @Sendable @escaping (UUID) async throws -> Void,
                submitAnswer: @Sendable @escaping (String) async throws -> Void,
                gameEvents: @Sendable @escaping () -> AsyncStream<GameEvent>,
                disconnect: @Sendable @escaping () async throws -> Void) {
        self.connect = connect
        self.submitAnswer = submitAnswer
        self.gameEvents = gameEvents
        self.disconnect = disconnect
    }
}

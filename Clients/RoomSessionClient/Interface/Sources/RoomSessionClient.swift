import Foundation
import Models

public struct RoomSessionClient: Sendable {
    public var connect: @Sendable (UUID) async throws -> Void
    public var send: @Sendable (RoomRequest) async throws -> Void
    public var roomEvents: @Sendable () -> AsyncStream<RoomEvent>
    public var disconnect: @Sendable () async throws -> Void
    
    public init(connect: @Sendable @escaping (UUID) async throws -> Void,
                send: @Sendable @escaping (RoomRequest) async throws -> Void,
                roomEvents: @Sendable @escaping () -> AsyncStream<RoomEvent>,
                disconnect: @Sendable @escaping () async throws -> Void) {
        self.connect = connect
        self.send = send
        self.roomEvents = roomEvents
        self.disconnect = disconnect
    }
}

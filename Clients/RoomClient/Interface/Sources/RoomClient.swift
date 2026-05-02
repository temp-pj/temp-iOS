import Foundation
import Models

public struct RoomClient: Sendable {
    public var createRoom: @Sendable (CreateRoomRequest) async throws -> Room
    public var fetchRoom: @Sendable (UUID) async throws -> Room
    public var updateRoom: @Sendable (UUID, UpdateRoomRequest) async throws -> Room
    public var closeRoom: @Sendable (UUID) async throws -> Void
    
    public init(
        createRoom: @escaping @Sendable (CreateRoomRequest) async throws -> Room,
        fetchRoom: @escaping @Sendable (UUID) async throws -> Room,
        updateRoom: @escaping @Sendable (UUID, UpdateRoomRequest) async throws -> Room,
        closeRoom: @escaping @Sendable (UUID) async throws -> Void) {
            
        self.createRoom = createRoom
        self.fetchRoom = fetchRoom
        self.updateRoom = updateRoom
        self.closeRoom = closeRoom
    }
}

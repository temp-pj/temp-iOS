import ClientRoom

public extension RoomClient {
    static let live = RoomClient { _ in
        fatalError("room live implementation is not implemented yet")
    } fetchRoom: { _ in
        fatalError("room live implementation is not implemented yet")
    } updateRoom: { _, _ in
        fatalError("room live implementation is not implemented yet")
    } closeRoom: { _ in
        fatalError("room live implementation is not implemented yet")
    }
}


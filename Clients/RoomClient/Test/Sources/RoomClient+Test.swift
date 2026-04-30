import ClientRoom
import Models

public extension RoomClient {
    static let mockSuccess = RoomClient { _ in
        Room()
    } fetchRoom: { _ in
        Room()
    } updateRoom: { _, _ in
        Room()
    } closeRoom: { _ in }
}

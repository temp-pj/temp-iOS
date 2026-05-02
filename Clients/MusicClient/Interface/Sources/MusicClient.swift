import Models

public struct MusicClient: Sendable {
    public var fetchSongs: @Sendable (SongRequest) async throws -> [Song]
    
    public init(fetchSongs: @escaping @Sendable (SongRequest) async throws -> [Song]) {
        self.fetchSongs = fetchSongs
    }
}

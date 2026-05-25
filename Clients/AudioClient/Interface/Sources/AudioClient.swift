import Foundation
import Models

public struct AudioClient: Sendable {
    public var preload: @Sendable (String, TimeInterval, TimeInterval) async throws -> Void
    public var play: @Sendable () async throws -> Void
    public var stop: @Sendable () async throws -> Void
    public var playbackState: @Sendable () -> AsyncStream<PlaybackState>
    
    public init(preload: @Sendable @escaping (String, TimeInterval, TimeInterval) async throws -> Void,
                play: @Sendable @escaping () async throws -> Void,
                stop: @Sendable @escaping () async throws -> Void,
                playbackState: @Sendable @escaping () -> AsyncStream<PlaybackState>
    ) {
        self.preload = preload
        self.play = play
        self.stop = stop
        self.playbackState = playbackState
    }
}

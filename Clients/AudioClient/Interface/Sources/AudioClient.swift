import Foundation

public struct AudioClient: Sendable {
    public var preload: @Sendable (URL) async throws -> Void
    public var play: @Sendable () async throws -> Void
    public var stop: @Sendable () async throws -> Void
    
    public init(preload: @Sendable @escaping (URL) async throws -> Void,
                play: @Sendable @escaping () async throws -> Void,
                stop: @Sendable @escaping () async throws -> Void) {
        self.preload = preload
        self.play = play
        self.stop = stop
    }
}

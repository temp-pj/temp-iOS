//
//  AudioClient+Test.swift
//  ClientAudio
//
//  Created by 송지혁 on 5/2/26.
//

import ClientAudio
import Foundation
import Models

public extension AudioClient {
    static func mock(preload: @Sendable @escaping (String, TimeInterval, TimeInterval) async throws -> Void,
                     play: @Sendable @escaping () async throws -> Void,
                     stop: @Sendable @escaping () -> Void,
                     playbackState: @Sendable @escaping () -> AsyncStream<PlaybackState>
    ) -> Self {
        return Self(preload: preload, play: play, stop: stop, playbackState: playbackState)
    }
}


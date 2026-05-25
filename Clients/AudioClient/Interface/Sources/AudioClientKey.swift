//
//  AudioClientKey.swift
//  ClientAudio
//
//  Created by 송지혁 on 5/2/26.
//

import Dependencies

extension AudioClient: DependencyKey {
    public static let liveValue = AudioClient(preload: unimplemented("AudioClient.preload"),
                                              play: unimplemented("AudioClient.play"),
                                              stop: unimplemented("AudioClient.stop"),
                                              playbackState: unimplemented("AudioClient.playbackState"))
}

extension DependencyValues {
    public var audioClient: AudioClient {
        get { self[AudioClient.self] }
        set { self[AudioClient.self] = newValue }
    }
}


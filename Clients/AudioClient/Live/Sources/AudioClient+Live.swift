//
//  AudioClient+Live.swift
//  ClientAudio
//
//  Created by 송지혁 on 5/2/26.
//

import ClientAudio

public extension AudioClient {
    static let live = AudioClient { _ in
        fatalError("preload live implementation is not implemented yet")
    } play: {
        fatalError("play live implementation is not implemented yet")
    } stop: {
        fatalError("stop live implementation is not implemented yet")
    }

}

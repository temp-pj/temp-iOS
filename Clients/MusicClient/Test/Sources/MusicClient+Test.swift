//
//  MusicClientTest.swift
//  ClientMusicTest
//
//  Created by 송지혁 on 5/2/26.
//

import ClientMusic
import Models

public extension MusicClient {
    static let mockSuccess = MusicClient { _ in
        [Song()]
    }
}

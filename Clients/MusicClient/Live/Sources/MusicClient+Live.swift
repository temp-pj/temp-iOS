//
//  MusicClient+Live.swift
//  ClientMusicLive
//
//  Created by 송지혁 on 5/2/26.
//

import ClientMusic

public extension MusicClient {
    static let live = MusicClient { _ in
        fatalError("fetch live implementation is not implemented yet")
    }
}


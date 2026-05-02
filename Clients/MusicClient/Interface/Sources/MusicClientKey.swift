//
//  MusicClientKey.swift
//  ClientMusic
//
//  Created by 송지혁 on 5/2/26.
//

import Dependencies

extension MusicClient: DependencyKey {
    public static let liveValue: MusicClient = MusicClient(fetchSongs: unimplemented("MusicClient.fetchSongs"))
}

extension DependencyValues {
    public var musicClient: MusicClient {
        get { self[MusicClient.self] }
        set { self[MusicClient.self] = newValue }
    }
}

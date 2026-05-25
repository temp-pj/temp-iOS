//
//  MusicClient+Live.swift
//  ClientMusicLive
//
//  Created by 송지혁 on 5/2/26.
//

import ClientMusicEntitlement

public extension MusicEntitlementClient {
    static let live = MusicEntitlementClient { 
        fatalError("fetch live implementation is not implemented yet")
    } checkEntitlement: {
        fatalError("fetch live implementation is not implemented yet")
    }
}


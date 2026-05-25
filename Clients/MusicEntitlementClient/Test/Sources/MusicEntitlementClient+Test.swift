//
//  MusicClientTest.swift
//  ClientMusicTest
//
//  Created by 송지혁 on 5/2/26.
//

import ClientMusicEntitlement
import Models

public extension MusicEntitlementClient {
    static let mockSuccess = MusicEntitlementClient {
        return .authorized
    } checkEntitlement: {
        return true
    }
}

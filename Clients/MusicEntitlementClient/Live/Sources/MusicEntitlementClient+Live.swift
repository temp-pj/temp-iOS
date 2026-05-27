//
//  MusicEntitlementClient+Live.swift
//  ClientMusicLive
//
//  Created by 송지혁 on 5/2/26.
//

import ClientMusicEntitlement
import Dependencies
import MusicKit

public extension MusicEntitlementClient {
    static let live = MusicEntitlementClient { 
        return MusicAuthorization.currentStatus
    } requestAuthorization: {
        return await MusicAuthorization.request()
    } checkEntitlement: {
        let subscription = try? await MusicSubscription.current
        return subscription?.canPlayCatalogContent ?? false
    }
}

extension MusicEntitlementClient: @retroactive DependencyKey {
    public static let liveValue: MusicEntitlementClient = .live
}

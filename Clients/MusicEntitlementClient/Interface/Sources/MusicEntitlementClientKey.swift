//
//  MusicClientKey.swift
//  ClientMusic
//
//  Created by 송지혁 on 5/2/26.
//

import Dependencies

extension MusicEntitlementClient: DependencyKey {
    public static let liveValue: MusicEntitlementClient = MusicEntitlementClient(requestAuthorization: unimplemented("MusicEntitlementClient.requestAuthorization"),
                                                                                 checkEntitlement: unimplemented("MusicEntitlementClient.checkEntitlement"))
}

extension DependencyValues {
    public var musicEntitlementClient: MusicEntitlementClient {
        get { self[MusicEntitlementClient.self] }
        set { self[MusicEntitlementClient.self] = newValue }
    }
}

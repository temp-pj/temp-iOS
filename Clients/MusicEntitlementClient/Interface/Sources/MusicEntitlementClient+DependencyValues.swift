//
//  MusicEntitlementClient+DependencyValues.swift
//  ClientMusicEntitlement
//
//  Created by 송지혁 on 5/27/26.
//

import Dependencies

extension MusicEntitlementClient: TestDependencyKey {
    public static let testValue = Self(
        authorizationStatus: unimplemented("authorizationStatus"),
        requestAuthorization: unimplemented("requestAuthorization"),
        checkEntitlement: unimplemented("checkEntitlement")
    )
}

extension DependencyValues {
    public var musicEntitlementClient: MusicEntitlementClient {
        get { self[MusicEntitlementClient.self] }
        set { self[MusicEntitlementClient.self] = newValue }
    }
}

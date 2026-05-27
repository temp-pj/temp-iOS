//
//  MusicClientTest.swift
//  ClientMusicTest
//
//  Created by 송지혁 on 5/2/26.
//

import ClientMusicEntitlement
import Models

public extension MusicEntitlementClient {
    static let mockAuthorizedWithSubscription = Self(
        authorizationStatus: { .authorized },
        requestAuthorization: { .authorized },
        checkEntitlement: { true })
    
    static let mockAuthorizedNoSubscription = Self(
        authorizationStatus: { .authorized },
        requestAuthorization: { .authorized },
        checkEntitlement: { false })
    
    static let mockDenied = Self(
        authorizationStatus: { .denied },
        requestAuthorization: { .denied },
        checkEntitlement: { false })
}

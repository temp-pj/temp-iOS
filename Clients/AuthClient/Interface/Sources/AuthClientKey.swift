//
//  AuthClientKey.swift
//  ClientAuth
//
//  Created by 송지혁 on 4/27/26.
//

import ComposableArchitecture

private enum AuthClientKey: DependencyKey {
    static let liveValue = AuthClient(
        login: { _ in
            fatalError("AuthClient.liveValue is not configured")
        },
        logout: {
            fatalError("AuthClient.liveValue is not configured")
        }
    )
}


public extension DependencyValues {
    var authClient: AuthClient {
        get { self[AuthClientKey.self] }
        set { self[AuthClientKey.self] = newValue }
    }
}

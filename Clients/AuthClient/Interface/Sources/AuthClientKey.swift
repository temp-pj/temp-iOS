//
//  AuthClientKey.swift
//  ClientAuth
//
//  Created by 송지혁 on 4/27/26.
//

import Dependencies

extension AuthClient: DependencyKey {
    public static let liveValue = AuthClient(login: unimplemented("AuthClient.login"),
                                             logout: unimplemented("AuthClient.logout"))
    
    public static let testValue = AuthClient(login: unimplemented("AuthClient.login"),
                                             logout: unimplemented("AuthClient.logout"))

}

extension DependencyValues {
    public var authClient: AuthClient {
        get { self[AuthClient.self] }
        set { self[AuthClient.self] = newValue }
    }
}

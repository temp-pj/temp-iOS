//
//  AuthClient+Test.swift
//  ClientAuth
//
//  Created by 송지혁 on 4/27/26.
//

import ClientAuth
import Models

public extension AuthClient {
    static let mockSuccess = AuthClient { credentials in
        AuthSession()
    } logout: {
        
    }
    
}

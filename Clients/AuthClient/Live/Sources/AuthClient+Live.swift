//
//  AuthClient+Live.swift
//  ClientAuth
//
//  Created by 송지혁 on 4/27/26.
//
import ClientAuth

public extension AuthClient {
    static let live = AuthClient { credentials in
        fatalError("login live implementation is not implemented yet")
    } logout: {
        fatalError("logout live implementation is not implemented yet")
    }

}

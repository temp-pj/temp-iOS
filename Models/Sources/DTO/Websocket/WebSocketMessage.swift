//
//  WebSocketMessage.swift
//  Models
//
//  Created by 송지혁 on 5/12/26.
//

import Foundation

public enum WebSocketError: Error {
    case unknownType(String)
}

public struct WebSocketMessage<Payload: Codable>: Codable {
    public let type: String
    public let payload: Payload
    
    public init(type: String, payload: Payload) {
        self.type = type
        self.payload = payload
    }
}

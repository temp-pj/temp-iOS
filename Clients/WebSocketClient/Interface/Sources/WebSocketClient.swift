//
//  WebSocketClient.swift
//  ClientWebSocket
//
//  Created by 송지혁 on 5/2/26.
//

import Foundation

public struct WebSocketClient: Sendable {
    public var connect: @Sendable (URL) async throws -> Void
    public var send: @Sendable (String) async throws -> Void
    public var receive: @Sendable () async -> AsyncStream<String>
    public var disconnect: @Sendable () async throws -> Void
    
    public init(connect: @escaping @Sendable (URL) async throws -> Void,
                send: @escaping @Sendable (String) async throws -> Void,
                receive: @escaping @Sendable () async -> AsyncStream<String>,
                disconnect: @escaping @Sendable () async throws -> Void) {
        self.connect = connect
        self.send = send
        self.receive = receive
        self.disconnect = disconnect
    }
    
}

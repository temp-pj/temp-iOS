//
//  WebSocketClient+Live.swift
//  ClientWebSocket
//
//  Created by 송지혁 on 5/2/26.
//

import ClientWebSocket
import Foundation

public extension WebSocketClient {
    static var live: WebSocketClient {
        let connection = WebSocketConnection()
        let (stream, continuation) = AsyncStream<String>.makeStream()
        
        return WebSocketClient { url in
            await connection.connect(url: url, continuation: continuation)
        } send: { message in
            try await connection.send(text: message)
        } receive: {
            stream
        } disconnect: {
            await connection.disconnect()
        }
        
    }
}


private actor WebSocketConnection {
    private var task: URLSessionWebSocketTask?
    private var continuation: AsyncStream<String>.Continuation?
    private let session = URLSession(configuration: .default)
    
    
    func connect(url: URL, continuation: AsyncStream<String>.Continuation) {
        self.continuation = continuation
        task = session.webSocketTask(with: url)
        task?.resume()
        startListening()
    }
    
    func send(text: String) async throws {
        let message = URLSessionWebSocketTask.Message.string(text)
        try await task?.send(message)
    }
    
    func startListening() {
        guard let task, let continuation else { return }
        
        Task { [task, continuation] in
            while true {
                do {
                    let message = try await task.receive()
                    
                    switch message {
                        case .string(let text):
                            continuation.yield(text)
                            
                        case .data(let data):
                            continue
                            
                        default: break
                    }
                } catch {
                    continuation.finish()
                    return
                }
            }
        }
    }
    
    func disconnect() {
        task?.cancel(with: .goingAway, reason: nil)
        continuation?.finish()
        task = nil
    }
    
}

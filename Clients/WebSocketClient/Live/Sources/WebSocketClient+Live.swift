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
        
        return WebSocketClient { url in
            await connection.connect(url: url)
        } send: { message in
            try await connection.send(text: message)
        } receive: {
            await connection.receive()
        } disconnect: {
            await connection.disconnect()
        }
    }
}

enum WebSocketConnectionError: Error {
    case notConnected
}

private actor WebSocketConnection {
    private let session = URLSession(configuration: .default)
    private var task: URLSessionWebSocketTask?
    
    private var continuation: AsyncStream<String>.Continuation?
    private var stream: AsyncStream<String> = AsyncStream { $0.finish() }
    
    
    func connect(url: URL) {
        let (stream, continuation) = AsyncStream<String>.makeStream()
        self.stream = stream
        self.continuation = continuation
        
        task = session.webSocketTask(with: url)
        task?.resume()
        
        startListening()
    }
    
    func send(text: String) async throws {
        guard let task else { throw WebSocketConnectionError.notConnected }
        
        let message = URLSessionWebSocketTask.Message.string(text)
        try await task.send(message)
    }
    
    func receive() -> AsyncStream<String> { stream }
    
    private func startListening() {
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

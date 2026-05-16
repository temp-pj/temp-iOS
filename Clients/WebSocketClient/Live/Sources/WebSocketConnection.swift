//
//  WebSocketDelegate.swift
//  M_GAME
//
//  Created by 송지혁 on 5/16/26.
//

import ClientWebSocket
import Foundation

private final class WebSocketDelegate: NSObject, URLSessionWebSocketDelegate, Sendable {
    let onOpen: @Sendable () -> Void
    
    init(onOpen: @escaping @Sendable () -> Void) {
        self.onOpen = onOpen
    }
    
    func urlSession(_ session: URLSession,
                    webSocketTask: URLSessionWebSocketTask,
                    didOpenWithProtocol protocol: String?) {
        onOpen()
    }
}

public actor WebSocketConnection {
    private var session: URLSession?
    private var task: URLSessionWebSocketTask?
    
    private var continuation: AsyncStream<WebSocketEvent>.Continuation?
    private var stream: AsyncStream<WebSocketEvent> = AsyncStream { $0.finish() }
    
    func connect(url: URL) {
        disconnect()
        
        let (stream, continuation) = AsyncStream<WebSocketEvent>.makeStream()
        self.stream = stream
        self.continuation = continuation
        
        let delegate = WebSocketDelegate(
            onOpen: { continuation.yield(.connected) }
        )
        
        let session = URLSession(configuration: .default, delegate: delegate, delegateQueue: nil)
        self.session = session
        
        task = session.webSocketTask(with: url)
        task?.resume()
        
        startListening()
    }
    
    func send(text: String) async throws {
        guard let task else { throw WebSocketConnectionError.notConnected }
        
        let message = URLSessionWebSocketTask.Message.string(text)
        try await task.send(message)
    }
    
    func receive() -> AsyncStream<WebSocketEvent> { stream }
    
    private func startListening() {
        guard let task, let continuation else { return }
        
        Task { [task, continuation] in
            while true {
                do {
                    let message = try await task.receive()
                    
                    switch message {
                        case .string(let text):
                            continuation.yield(.message(text))
                            
                        case .data:
                            continue
                            
                        default: break
                    }
                } catch {
                    let reason: WebSocketEvent.CloseReason
                    if let urlError = error as? URLError, urlError.code == .cancelled {
                        reason = .normal
                    } else {
                        reason = .networkError
                    }
                    continuation.yield(.disconnected(reason))
                    continuation.finish()
                    return
                }
            }
        }
    }
    
    func disconnect() {
        task?.cancel(with: .goingAway, reason: nil)
        continuation?.yield(.disconnected(.normal))
        continuation?.finish()
        task = nil
    }
    
}

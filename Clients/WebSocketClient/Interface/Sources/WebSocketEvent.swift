//
//  WebSocketEvent.swift
//  M_GAME
//
//  Created by 송지혁 on 5/16/26.
//

public enum WebSocketEvent {
    case connected
    case disconnected(CloseReason)
    case message(String)
    
    public enum CloseReason {
        case normal
        case networkError
    }
}

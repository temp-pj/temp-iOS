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

public struct WebSocketMessage: Codable {
    let type: String
    let payload: Data
}

public extension WebSocketMessage {
    static func from(_ request: RoomRequest) -> WebSocketMessage {
        switch request {
            case .startGame:
                return WebSocketMessage(type: "START_GAME",
                                        payload: Data())
                
            case .kickPlayer(let playerId):
                let payload = KickPlayerPayload(playerId: playerId)
                let payloadData = try! JSONEncoder().encode(payload)
                return WebSocketMessage(type: "KICK_PLAYER", payload: payloadData)
                
            case .game(.submitAnswer(let answer)):
                let payload = SubmitAnswerPayload(answer: answer)
                let payloadData = try! JSONEncoder().encode(payload)
                return WebSocketMessage(type: "SUBMIT_ANSWER", payload: payloadData)
        }
    }
}

public extension WebSocketMessage {
    func toRoomEvent() throws -> RoomEvent {
        switch self.type {
            case "PLAYER_JOINED":
                let player = try JSONDecoder().decode(Player.self, from: self.payload)
                return .playerJoined(player)
                
            case "PLAYER_LEFT":
                let player = try JSONDecoder().decode(Player.self, from: self.payload)
                return .playerLeft(player)
                
            case "HOST_CHANGED":
                let player = try JSONDecoder().decode(Player.self, from: self.payload)
                return .playerLeft(player)
                
            case "ROOM_CLOSED":
                let reason = try JSONDecoder().decode(RoomCloseReason.self, from: self.payload)
                return .roomClosed(reason)
                
            case "ROUND_STARTED":
                let data = try JSONDecoder().decode(RoundData.self, from: self.payload)
                return .game(.roundStarted(data))
            
            case "WRONG_ANSWER":
                return .game(.wrongAnswer)
                
            case "ROUND_ENDED":
                let result = try JSONDecoder().decode(RoundResult.self, from: self.payload)
                return .game(.roundEnded(result))
                
            default: throw WebSocketError.unknownType(self.type)
        }
        
    }
}

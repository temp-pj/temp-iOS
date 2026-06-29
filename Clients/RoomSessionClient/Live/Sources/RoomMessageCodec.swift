//
//  RoomMessageCodec.swift
//  ClientRoomSessionLive
//
//  Created by 송지혁 on 6/19/26.
//

import Foundation
import Models

enum RoomMessageCodecError: Error {
    case unknownType(String)
}

public enum RoomMessageCodec {
    
    static func encode(_ request: RoomRequest) throws -> Data {
        switch request {
            case .game(let gameRequest):
                switch gameRequest {
                    case .submitAnswer(let answer):
                        let payload = SubmitAnswerPayload(answer: answer)
                        let message = WebSocketMessage<SubmitAnswerPayload>(type: "SUBMIT_ANSWER", payload: payload)
                        let data = try JSONEncoder().encode(message)
                        
                        return data
                        
                }
                
            case .kickPlayer(let id):
                let payload = KickPlayerPayload(targetPlayerID: id)
                let message = WebSocketMessage<KickPlayerPayload>(type: "KICK_PLAYER", payload: payload)
                let data = try JSONEncoder().encode(message)
                
                return data
                
            case .readyToPlay(let roundNumber):
                let payload = ReadyToPlayPayload(roundNumber: roundNumber)
                let message = WebSocketMessage<ReadyToPlayPayload>(type: "READY_TO_PLAY", payload: payload)
                let data = try JSONEncoder().encode(message)
                
                return data
                
            case let .startGame(category, trackCount, timeLimit):
                let payload = StartGamePayload(category: category, trackCount: trackCount, timeLimit: timeLimit)
                let message = WebSocketMessage<StartGamePayload>(type: "START_GAME", payload: payload)
                let data = try JSONEncoder().encode(message)
                
                return data
        }
    }
    
    // 메시지 타입 자체가 많아서 case가 많은거라 린트에서 우려하는 상황이랑 달라서 끔
    // swiftlint:disable:next cyclomatic_complexity
    static func decode(_ data: Data, type: String) throws -> RoomEvent? {
        switch type {
            case "PLAYER_JOINED":
                let payload = try JSONDecoder().decode(WebSocketMessage<PlayerJoinedPayload>.self, from: data).payload
                let player = Player(id: UUID(uuidString: payload.playerID)!)
                return .playerJoined(player)
                
            case "PLAYER_LEFT":
                let payload = try JSONDecoder().decode(WebSocketMessage<PlayerLeftPayload>.self, from: data).payload
                let player = Player(id: UUID(uuidString: payload.playerID)!)
                return .playerLeft(player)
                
            case "HOST_CHANGED":
                let payload = try JSONDecoder().decode(WebSocketMessage<HostChangedPayload>.self, from: data).payload
                let hostPlayer = Player(id: UUID(uuidString: payload.playerID)!)
                
                return .hostChanged(hostPlayer)
                
            case "ROUND_STARTED":
                let payload = try JSONDecoder().decode(WebSocketMessage<RoundStartPayload>.self, from: data).payload
                let roundData = RoundData(roundNumber: payload.roundNumber,
                                          totalRounds: payload.totalRounds,
                                          letterCards: payload.letterCards,
                                          answerLength: payload.answerLength)
                
                return .game(.roundStarted(roundData))
                
            case "PRELOAD_SONG":
                let payload = try JSONDecoder().decode(WebSocketMessage<PreloadSongPayload>.self, from: data).payload
                
                return .preloadSong(isrc: payload.isrc, startTime: payload.startTime, roundNumber: payload.roundNumber)
                
            case "COUNT_DOWN":
                let payload = try JSONDecoder().decode(WebSocketMessage<CountDownPayload>.self, from: data).payload
                
                return .game(.countDown(payload.remaining))
                
            case "WRONG_ANSWER":
                let payload = try JSONDecoder().decode(WebSocketMessage<WrongAnswerPayload>.self, from: data).payload
                
                return .game(.wrongAnswer(playerID: payload.playerID, wrongAnswer: payload.wrongAnswer))
                
            case "ROUND_RESULT":
                let payload = try JSONDecoder().decode(WebSocketMessage<RoundResultPayload>.self, from: data).payload
                let roundResult = RoundResult(winnerId: payload.winner, correctAnswer: payload.correctAnswer, scores: payload.scores)
                
                return .game(.roundEnded(roundResult))
                
            case "GAME_OVER":
                let payload = try JSONDecoder().decode(WebSocketMessage<GameOverPayload>.self, from: data).payload
                let gameResult = GameResult(winner: payload.winner, scores: payload.scores)
                
                return .gameFinished(gameResult)
                
            case "GAME_STARTED":
                return .gameStarted
                
            case "PLAYER_KICKED":
                return .kicked
                
            default: return nil
        }
    }
}

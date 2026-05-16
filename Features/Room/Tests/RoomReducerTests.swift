//
//  RoomReducerTests.swift
//  FeatureRoom
//
//  Created by 송지혁 on 5/15/26.
//

@testable import FeatureRoom

import ComposableArchitecture
import ClientRoomSessionTest
import Foundation
import Models
import XCTest

final class RoomReducerTests: XCTestCase {
    func test_게임_한_사이클() async {
        let clock = TestClock()
        let (stream, continuation) = AsyncStream.makeStream(of: RoomEvent.self)
        
        let hostPlayer = Player(id: UUID())
        
        let player1 = Player(id: UUID())
        let player2 = Player(id: UUID())
        let player3 = Player(id: UUID())
        
        var request: RoomRequest?
        
        let store = await TestStore(initialState: RoomReducer.State(roomID: UUID(),
                                                                    hostID: hostPlayer.id,
                                                                    players: [hostPlayer.id: hostPlayer],
                                                                    roomState: .waiting),
                                    reducer: { RoomReducer() }) {
            $0.roomSessionClient = .mock(send: { request = $0 }, roomEvents: { stream })
            $0.continuousClock = clock
        }
        
        let game = GameReducer.State(selectedLetters: [], roundState: .idle)
        
        await store.send(.onAppear)
        
        // 선수 입장
        continuation.yield(.playerJoined(player1))
        
        await store.receive(\.receive) {
            $0.players[player1.id] = player1
        }
        
        continuation.yield(.playerJoined(player2))
        
        await store.receive(\.receive) {
            $0.players[player2.id] = player2
        }
        
        continuation.yield(.playerJoined(player3))
        
        await store.receive(\.receive) {
            $0.players[player3.id] = player3
        }
        
        // 선수 한 명 퇴장
        continuation.yield(.playerLeft(player1))
        
        await store.receive(\.receive) {
            $0.players[player1.id] = nil
        }
        
        // 게임 시작
        continuation.yield(.gameStarted)
        
        await store.receive(\.receive) {
            $0.gameState = game
            $0.roomState = .playing
        }
        
        // preload Song
        let songURL = URL(string: "https://www.naver.com")!
        continuation.yield(.game(.preloadSong(songURL)))
        
        await store.receive(\.receive)
        await store.receive(\.game) {
            $0.gameState?.roundState = .loading(songURL)
            $0.gameState?.songURL = songURL
        }
        
        // 라운드 시작
        let roundData = RoundData.mock(roundNumber: 1, totalRounds: 100, wordCards: ["그", "대", "만", "있", "다", "면", "마", "라", "탕"], answerLength: 6, timeLimit: 3600)
        
        continuation.yield(.game(.roundStarted(roundData)))
        
        await store.receive(\.receive)
        await store.receive(\.game) {
            $0.gameState?.roundState = .playing
            $0.gameState?.inputState = .enabled
            $0.gameState?.roundData = roundData
        }
        
        // 전송
        let wrongAnswer = ["마", "라", "탕", "있", "다", "면"]
        await store.send(.game(.delegate(.submitAnswer(wrongAnswer.joined()))))
        
        await store.receive(\.toServer)
        
        XCTAssertEqual(request, .game(.submitAnswer(wrongAnswer.joined())))
        
        // 오답 패널티
        continuation.yield(.game(.wrongAnswer))
        await store.receive(\.receive)
        await store.receive(\.game) {
            $0.gameState?.inputState = .penalized
        }
        
        await clock.advance(by: .milliseconds(500))
        
        await store.receive(\.game) {
            $0.gameState?.selectedLetters = []
            $0.gameState?.inputState = .enabled
        }
        
        // 라운드 종료(정답 or 시간 초과)
        
        let roundResult = RoundResult(winnerId: player2.id, correctAnswer: "그대만 있다면", scores: [:])
        
        continuation.yield(.game(.roundEnded(roundResult)))
        
        await store.receive(\.receive)
        await store.receive(\.game) {
            $0.gameState?.roundResult = roundResult
            $0.gameState?.roundState = .result
        }
        
        // 다음 라운드
        continuation.yield(.game(.nextRound))
        
        await store.receive(\.receive)
        await store.receive(\.game) {
            $0.gameState?.roundState = .idle
            $0.gameState?.inputState = .enabled
            $0.gameState?.roundData = nil
            $0.gameState?.roundResult = nil
            $0.gameState?.songURL = nil
            $0.gameState?.selectedLetters = []
        }
        
        // 게임 종료
        let gameResult = GameResult()
        continuation.yield(.gameFinished(gameResult))
        
        await store.receive(\.receive) {
            $0.roomState = .result
            $0.gameResult = gameResult
            $0.gameState = nil
        }
        
        continuation.finish()
        await store.send(.onDisappear)
    }
    
    func test_플레이어가_들어오면_목록에_추가() async {
        
        let (stream, continuation) = AsyncStream.makeStream(of: RoomEvent.self)
        
        let store = await TestStore(initialState: RoomReducer.State(roomID: UUID(), hostID: UUID(), players: [:])) {
            RoomReducer()
        } withDependencies: {
            $0.roomSessionClient = .mock(roomEvents: { stream })
        }
        await store.send(.onAppear)
        
        let newPlayer = Player(id: UUID())
        continuation.yield(.playerJoined(newPlayer))
        
        await store.receive(\.receive) {
            $0.players[newPlayer.id] = newPlayer
        }
        
        continuation.finish()
        
        await store.send(.onDisappear)
    }
    
    func test_플레이어가_나가면_목록에서_제거() async {
        let (stream, continuation) = AsyncStream.makeStream(of: RoomEvent.self)
        let player = Player(id: UUID())
        
        let store = await TestStore(initialState: RoomReducer.State(roomID: UUID(), hostID: UUID(), players: [player.id: player]), reducer: { RoomReducer() }) {
            $0.roomSessionClient = .mock(roomEvents: { stream })
        }
        
        await store.send(.onAppear)
        
        continuation.yield(.playerLeft(player))
        
        await store.receive(\.receive) {
            $0.players[player.id] = nil
        }
        
        continuation.finish()
        
        await store.send(.onDisappear)
    }
    
    func test_호스트가_바뀌면_호스트ID가_변경() async {
        let (stream, continuation) = AsyncStream.makeStream(of: RoomEvent.self)
        let hostPlayer = Player(id: UUID())
        
        let store = await TestStore(initialState: RoomReducer.State(roomID: UUID(), hostID: hostPlayer.id, players: [:]), reducer: { RoomReducer() }) {
            $0.roomSessionClient = .mock(roomEvents: { stream })
        }
        
        await store.send(.onAppear)
        
        let newHost = Player(id: UUID())
        
        continuation.yield(.hostChanged(newHost))
        
        await store.receive(\.receive) {
            $0.hostID = newHost.id
        }
        
        continuation.finish()
        
        await store.send(.onDisappear)
        
    }
    
    func test_게임_시작() async {
        let (stream, continuation) = AsyncStream.makeStream(of: RoomEvent.self)
        
        let store = await TestStore(initialState: RoomReducer.State(roomID: UUID(), hostID: UUID(), players: [:])) {
            RoomReducer()
        } withDependencies: { $0.roomSessionClient = .mock(roomEvents: { stream }) }
        
        await store.send(.onAppear)
        
        continuation.yield(.gameStarted)
        
        await store.receive(\.receive) {
            $0.gameState = GameReducer.State()
            $0.roomState = .playing
        }
        
        continuation.finish()
        
        await store.send(.onDisappear)
    }
    
    func test_게임_종료() async {
        let (stream, continuation) = AsyncStream.makeStream(of: RoomEvent.self)
        
        let store = await TestStore(initialState: RoomReducer.State(roomID: UUID(),
                                                                    hostID: UUID(),
                                                                    players: [:],
                                                                    roomState: .playing,
                                                                    gameState: GameReducer.State()), reducer: { RoomReducer() }) {
            $0.roomSessionClient = .mock(roomEvents: { stream })
        }
        
        await store.send(.onAppear)
        let gameResult = GameResult()
        continuation.yield(.gameFinished(gameResult))
        
        await store.receive(\.receive) {
            $0.gameResult = gameResult
            $0.roomState = .result
            $0.gameState = nil
        }
        
        continuation.finish()
        
        await store.send(.onDisappear)
    }
    
    func test_답_제출하면_서버_전송() async {
        let (stream, continuation) = AsyncStream.makeStream(of: RoomEvent.self)
        var sentRequest: RoomRequest?
        
        let store = await TestStore(initialState: RoomReducer.State(roomID: UUID(),
                                                                    hostID: UUID(),
                                                                    players: [:],
                                                                    roomState: .playing,
                                                                    gameState: GameReducer.State()
                                                                   ), reducer: { RoomReducer() }) {
            $0.roomSessionClient = .mock(send: { sentRequest = $0 }, roomEvents: { stream })
        }
        
        await store.send(.onAppear)
        await store.send(.game(.delegate(.submitAnswer("test"))))
        
        await store.receive(\.toServer)
        
        XCTAssertEqual(sentRequest, .game(.submitAnswer("test")))
        
        continuation.finish()
        await store.send(.onDisappear)
    }
}

//
//  GameReducerTests.swift
//  M_GAME
//
//  Created by 송지혁 on 5/3/26.
//

@testable import FeatureGame

import ComposableArchitecture
import Foundation
import Models
import XCTest

final class GameReducerTests: XCTestCase {
    func test_PRELOAD_SONG_이벤트_받음() async {
        let store = await TestStore(initialState: GameReducer.State(), reducer: { GameReducer() })
        let url = URL(string: "www.naver.com")!
        
        await store.send(.preloadSong(url)) { $0.roundState = .loading(url) }
    }
    
    func test_ROUND_START_이벤트_받음() async {
        let url = URL(string: "www.naver.com")!
        let store = await TestStore(initialState: GameReducer.State(roundState: .loading(url)), reducer: { GameReducer() })
        
        let roundData = RoundData(roundNumber: 1, totalRounds: 100, wordCards: ["달", "리", "표", "현", "할", "수", "없", "어", "요"], timeLimit: 300)
        let inputState = InputState.enabled
        await store.send(.roundStart(roundData)) {
            $0.roundData = roundData
            $0.roundState = .playing(inputState)
        }
    }
    
    func test_답_제출() async {
        let roundData = RoundData(roundNumber: 1, totalRounds: 100, wordCards: ["달", "리", "표", "현", "할", "수", "없", "어", "요", "가", "나", "다", "라"], timeLimit: 300)
        let inputState = InputState.enabled
        
        let store = await TestStore(initialState: GameReducer.State(roundState: .playing(inputState), roundData: roundData), reducer: { GameReducer() })
        
        let submission = Submission(cards: ["달", "리", "표", "현", "할", "수", "없", "어", "요"], submissionTime: 360000)
        await store.send(.submitAnswer(submission)) {
            $0.roundState = .playing(.submitting)
        }
    }
    
    func test_오답_응답_받음() async {
        let roundData = RoundData(roundNumber: 1, totalRounds: 100, wordCards: ["달", "리", "표", "현", "할", "수", "없", "어", "요", "가", "나", "다", "라"], timeLimit: 300)
        let inputState = InputState.submitting
        let clock = TestClock()
        
        let store = await TestStore(initialState: GameReducer.State(roundState: .playing(inputState), roundData: roundData), reducer: { GameReducer() }) {
            $0.continuousClock = clock
        }
    
        await store.send(.answerWrong) {
            $0.roundState = .playing(.penalized)
        }
        
        await clock.advance(by: .milliseconds(500))
        
        await store.receive(\.penaltyFinished) {
            $0.roundState = .playing(.enabled)
        }
    }
    
    func test_라운드_결과() async {
        let roundData = RoundData(roundNumber: 1, totalRounds: 100, wordCards: ["달", "리", "표", "현", "할", "수", "없", "어", "요", "가", "나", "다", "라"], timeLimit: 300)
        let inputState = InputState.submitting
        
        let store = await TestStore(initialState: GameReducer.State(roundState: .playing(inputState), roundData: roundData), reducer: { GameReducer() })
        
        let roundResult = RoundResult(winnerId: UUID(123), correctAnswer: "달리표현할수없어요", scores: [:])
        
        await store.send(.roundResult(roundResult)) {
            $0.roundState = .result
            $0.roundResult = roundResult
        }
    }
    
    func test_다음_라운드() async {
        let roundData = RoundData(roundNumber: 1, totalRounds: 100, wordCards: ["달", "리", "표", "현", "할", "수", "없", "어", "요", "가", "나", "다", "라"], timeLimit: 300)
        
        let store = await TestStore(initialState: GameReducer.State(roundState: .result, roundData: roundData),
                                    reducer: { GameReducer() })
        
        await store.send(.nextRound) {
            $0.roundState = .idle
        }
    }
    
    func test_마지막_라운드() async {
        let roundData = RoundData(roundNumber: 100, totalRounds: 100, wordCards: ["너", "는", "나", "의", "봄", "이", "다", "어", "요", "가", "나", "다", "라"], timeLimit: 300)
        
        let store = await TestStore(initialState: GameReducer.State(roundState: .result, roundData: roundData), reducer: { GameReducer() })
        
        await store.send(.nextRound) {
            $0.roundState = .finished
        }
    }
}

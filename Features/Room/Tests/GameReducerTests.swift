//
//  GameReducerTests.swift
//  M_GAME
//
//  Created by 송지혁 on 5/3/26.
//

@testable import FeatureRoom

import ComposableArchitecture
import ClientRoomSessionTest
import Foundation
import Models
import XCTest

final class GameReducerTests: XCTestCase {
    
    func test_answerLength_도달_시_자동_제출() async {
        let roundData = RoundData(roundNumber: 1, totalRounds: 100, letterCards: ["그", "대", "만"], answerLength: 3)
        let store = await TestStore(initialState: GameReducer.State(roundData: roundData), reducer: { GameReducer() })
        
        await store.send(.selectLetter(0)) {
            $0.selectedLetters = ["그"]
        }
        
        await store.send(.selectLetter(1)) {
            $0.selectedLetters = ["그", "대"]
        }
        
        await store.send(.selectLetter(2)) {
            $0.selectedLetters = ["그", "대", "만"]
        }
        
        await store.receive(\.submit) {
            $0.inputState = .submitting
        }
        
        await store.receive(\.delegate)
    }
    
    func test_answerLength_초과_입력_무시() async {
        let roundData = RoundData(roundNumber: 1, totalRounds: 100, letterCards: ["그", "대", "만"], answerLength: 3)
        let store = await TestStore(
            initialState: GameReducer.State(selectedLetters: ["그", "대", "만"], roundData: roundData),
            reducer: { GameReducer() }
        )
        
        await store.send(.selectLetter(0))
    }
    
    func test_inputState_penalized_일_때_selectLetter() async {
        let roundData = RoundData(roundNumber: 1, totalRounds: 100, letterCards: ["그", "대", "만"], answerLength: 3)
        
        let store = await TestStore(
            initialState: GameReducer.State(inputState: .penalized, roundData: roundData),
            reducer: { GameReducer() }
        )
        
        await store.send(.selectLetter(0))
    }
    
    func test_inputState_submitting_일_떄_selectLetter() async {
        let roundData = RoundData(roundNumber: 1, totalRounds: 100, letterCards: ["그", "대", "만"], answerLength: 3)
        
        let store = await TestStore(
            initialState: GameReducer.State(inputState: .submitting, roundData: roundData),
            reducer: { GameReducer() }
        )
        
        await store.send(.selectLetter(0))
    }
    
    func test_roundData_nil_일_때_selectLetter() async {
        let store = await TestStore(
            initialState: GameReducer.State(inputState: .enabled),
            reducer: { GameReducer() }
        )
        
        await store.send(.selectLetter(0))
    }
    
    func test_penalized_아닐_때_penaltyFinished_무시() async {
        let store = await TestStore(
            initialState: GameReducer.State(inputState: .enabled),
            reducer: { GameReducer() }
        )
        
        await store.send(.penaltyFinished)
    }
}

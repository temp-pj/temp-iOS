//
//  RoomView.swift
//  FeatureRoom
//
//  Created by 송지혁 on 6/4/26.
//

import ComposableArchitecture
import Models
import SwiftUI

public struct RoomView: View {
    public let store: StoreOf<RoomReducer>
    private let columns = [GridItem(.adaptive(minimum: 56), spacing: 10)]
    
    public init(store: StoreOf<RoomReducer>) {
        self.store = store
    }
    
    public var body: some View {
        VStack {
            Text("ROOMID: \(store.roomID)\n")
            Text("Players: \(store.players.keys.debugDescription)\n")
            Text("RoomState: \(store.roomState)\n")
            Text("MAXPLAYER: \(store.maxPlayers)\n")
            Text("HostID: \(store.hostID)\n")
            Text("serverConnectionState: \(store.serverConnectionState)\n")
            Text("GameResult: \(store.gameResult)\n")
            
            if let gameStore = store.scope(state: \.gameState, action: \.game) {
                
                HStack {
                    Image(systemName: "clock.fill")
                        .foregroundColor(gameStore.remainingTime <= 5 ? .red : .orange)
                    
                    Text("\(gameStore.remainingTime)초")
                        .font(.title)
                        .monospacedDigit()
                        .fontWeight(.bold)
                        .foregroundColor(gameStore.remainingTime <= 5 ? .red : .primary)
                }
                .padding(.bottom, 10)
                .animation(.default, value: gameStore.remainingTime)
                
                Text(gameStore.selectedLetters.joined())
                    .bold()
                
                let cards = gameStore.roundData?.letterCards ?? []
                
                if cards.isEmpty {
                    Text("카드를 불러오는 중이거나 없습니다... 👾")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(Array(cards.enumerated()), id: \.offset) { index, letter in
                            Button {
                                gameStore.send(.selectLetter(index))
                            } label: {
                                Text(letter)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .frame(width: 48, height: 48)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color.orange, lineWidth: 2)
                                    )
                            }
                        }
                    }
                    .padding(.horizontal)
                    .id(cards.joined())
                }
                
                Button("SUBMIT") {
                    gameStore.send(.submit(gameStore.selectedLetters.joined()))
                }
                
            } else {
                Text("게임 시작을 기다리는 중... ⏱️")
                    .foregroundColor(.secondary)
                    .padding()
            }
            
            Button("GAME START") {
                store.send(.toServer(.startGame(category: Category(startYear: 2010,
                                                                   endYear: 2020,
                                                                   artistType: "Person",
                                                                   country: "South Korea",
                                                                   gender: "Male",
                                                                   genre: "ballad"),
                                                trackCount: 3, timeLimit: store.timeLimit)))
            }
        }
        .onAppear { store.send(.onAppear) }
    }
}

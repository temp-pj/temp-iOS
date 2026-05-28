//
//  RoomReducer.swift
//  FeatureRoom
//
//  Created by 송지혁 on 5/12/26.
//

import ClientAudio
import ClientRoomSession
import ComposableArchitecture
import Foundation
import Models

@Reducer
public struct RoomReducer {
    public typealias PlayerID = UUID
    public typealias RoomID = UUID
    
    public init() { }
    
    @ObservableState
    public struct State: Equatable {
        public let roomID: RoomID
        public var hostID: PlayerID
        public var players: [PlayerID: Player]
        public var roomState: RoomSessionState = .waiting
        public var gameState: GameReducer.State?
        public var gameResult: GameResult?
        public var serverConnectionState: ServerConnectionState = .disconnected(.normal)
        
        public init(roomID: RoomID, hostID: PlayerID, players: [PlayerID: Player], roomState: RoomSessionState = .waiting, gameState: GameReducer.State? = nil, gameResult: GameResult? = nil) {
            self.roomID = roomID
            self.hostID = hostID
            self.players = players
            self.roomState = roomState
            self.gameState = gameState
            self.gameResult = gameResult
        }
    }
    
    public enum Action {
        case onAppear
        case toServer(RoomRequest)
        case receive(RoomEvent)
        case game(GameReducer.Action)
        case onDisappear
    }
    
    public enum CancelID {
        case roomEvents
    }
    
    @Dependency(\.roomSessionClient) var roomSession
    @Dependency(\.audioClient) var audioClient
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                case .onAppear:
                    return .run { send in
                        for await roomEvent in roomSession.roomEvents() {
                            await send(.receive(roomEvent))
                        }
                    }
                    .cancellable(id: CancelID.roomEvents, cancelInFlight: true)
                    
                case .toServer(let request):
                    return .run { _ in
                        try await roomSession.send(request)
                    }
                    
                case .receive(let event):
                    switch event {
                        case .gameStarted:
                            state.roomState = .playing
                            state.gameState = GameReducer.State()
                            return .none
                            
                        case .playerJoined(let joinedPlayer):
                            state.players[joinedPlayer.id] = joinedPlayer
                            return .none
                            
                        case .playerLeft(let leftPlayer):
                            state.players[leftPlayer.id] = nil
                            return .none
                            
                        case .hostChanged(let newHost):
                            state.hostID = newHost.id
                            return .none
                            
                        case .serverConnectionChanged(let connectionState):
                            state.serverConnectionState = connectionState
                            return .none
                            
                        case .roomClosed(let reason):
                            return .none
                            
                        case .preloadSong(let song):
                            return .run { send in
                                // 추후에 여기서 startTime < endTime 방어 로직 구현
                                try await audioClient.preload(song.id, song.startTime, song.endTime)
                            }
                            
                        case .game(let event):
                            return .send(.game(.serverEvent(event)))
                            
                        case .gameFinished(let result):
                            state.roomState = .result
                            state.gameResult = result
                            state.gameState = nil
                            
                            return .none
                    }
                    
                case .game(.delegate(.submitAnswer(let answer))):
                    return .send(.toServer(.game(.submitAnswer(answer))))
                    
                case .game(.delegate(.playMusic)):
                    return .run { send in
                        try await audioClient.play()
                    }
                
                case .game(.delegate(.stopMusic)):
                    return .run { send in
                        try await audioClient.stop()
                    }
                    
                case .onDisappear:
                    return .merge(
                        .cancel(id: CancelID.roomEvents),
                        .run { _ in
                            try await roomSession.disconnect()
                        }
                    )
                        
                case .game: return .none
            }
        }
        .ifLet(\.gameState, action: \.game) { GameReducer() }
    }
}

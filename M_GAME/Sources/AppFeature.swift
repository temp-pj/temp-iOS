//
//  AppFeature.swift
//  M_GAME
//
//  Created by 송지혁 on 4/28/26.
//

import ComposableArchitecture
import FeatureLogin
import FeatureRoom
import Foundation

@Reducer
struct AppFeature {
    @ObservableState
    struct State {
        var room: RoomReducer.State?
        
    }
    
    enum Action {
        case room(RoomReducer.Action)
        case onAppear
        case joinRoomTapped(String)
        case createRoomSuccess(String)
        
    }
    
    @Dependency(\.roomSessionClient) var roomSessionClient
    @Dependency(\.musicEntitlementClient) var musicEntitlementClient
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                    
                case .onAppear:
                    return .run { _ in
                        await musicEntitlementClient.requestAuthorization()
                    }
                    
                case .joinRoomTapped(let id):
                    return .run { send in
                        if id.isEmpty {
                            try await roomSessionClient.connect(nil)
                        } else {
                            try await roomSessionClient.connect(UUID(uuidString: id))
                        }
                        
                        await send(.createRoomSuccess(id))
                    }
                    
                case .createRoomSuccess(let id):
                    state.room = RoomReducer.State(roomID: id, hostID: UUID(), players: [:])
                    return .none
                    
                case .room: return .none
            }
        }
        .ifLet(\.room, action: \.room) {
            RoomReducer()
        }
    }
}

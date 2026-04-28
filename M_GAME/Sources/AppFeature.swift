//
//  AppFeature.swift
//  M_GAME
//
//  Created by 송지혁 on 4/28/26.
//

import ComposableArchitecture
import FeatureLogin

@Reducer
struct AppFeature {
    @ObservableState
    struct State {
        
    }
    
    enum Action {
        
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                default: return .none
            }
        }
    }
}

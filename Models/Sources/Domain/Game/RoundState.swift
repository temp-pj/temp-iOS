//
//  RoundState.swift
//  Models
//
//  Created by 송지혁 on 5/3/26.
//

import Foundation

public enum RoundState: Equatable {
    case idle
    case loading(URL)
    case playing(InputState)
    case result
    case finished
}

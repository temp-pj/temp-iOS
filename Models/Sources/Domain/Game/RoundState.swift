//
//  RoundState.swift
//  Models
//
//  Created by 송지혁 on 5/3/26.
//

import Foundation

public enum RoundState: Equatable {
    case idle
    case loading
    case playing
    case result
    case finished
}

//
//  GameRequest.swift
//  Models
//
//  Created by 송지혁 on 5/14/26.
//

import Foundation

public enum GameRequest: Codable, Equatable {
    case submitAnswer(String)
}

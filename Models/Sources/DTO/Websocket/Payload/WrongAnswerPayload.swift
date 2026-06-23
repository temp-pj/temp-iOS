//
//  WrongAnswerPayload.swift
//  Models
//
//  Created by 송지혁 on 6/4/26.
//

public struct WrongAnswerPayload: Codable {
    public let playerID: String
    public let wrongAnswer: String
}

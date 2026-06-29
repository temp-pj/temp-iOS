//
//  SubmitAnswerPayload.swift
//  Models
//
//  Created by 송지혁 on 5/14/26.
//

public struct SubmitAnswerPayload: Codable {
    let answer: String
    
    public init(answer: String) {
        self.answer = answer
    }
}

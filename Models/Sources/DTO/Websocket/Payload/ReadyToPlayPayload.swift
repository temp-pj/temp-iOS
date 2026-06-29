//
//  ReadyToPlayPayload.swift
//  Models
//
//  Created by 송지혁 on 6/4/26.
//

public struct ReadyToPlayPayload: Codable {
    let roundNumber: Int
    
    public init(roundNumber: Int) {
        self.roundNumber = roundNumber
    }
}

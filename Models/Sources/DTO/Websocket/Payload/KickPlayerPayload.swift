//
//  KickPlayerPayload.swift
//  Models
//
//  Created by 송지혁 on 5/14/26.
//

public struct KickPlayerPayload: Codable {
    let targetPlayerID: String
    
    public init(targetPlayerID: String) {
        self.targetPlayerID = targetPlayerID
    }
}

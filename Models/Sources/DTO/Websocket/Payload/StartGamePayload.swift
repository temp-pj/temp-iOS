//
//  StartGamePayload.swift
//  Models
//
//  Created by 송지혁 on 6/2/26.
//

public struct StartGamePayload: Codable {
    let category: Category
    let trackCount: Int
    let timeLimit: Int
    
    public init(category: Category, trackCount: Int, timeLimit: Int) {
        self.category = category
        self.trackCount = trackCount
        self.timeLimit = timeLimit
    }
}

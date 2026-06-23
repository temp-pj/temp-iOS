//
//  PreloadSongPayload.swift
//  Models
//
//  Created by 송지혁 on 6/2/26.
//

public struct PreloadSongPayload: Codable {
    public let isrc: String
    public let startTime: Int
    public let roundNumber: Int
}

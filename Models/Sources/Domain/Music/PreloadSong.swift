//
//  PreloadSong.swift
//  Models
//
//  Created by 송지혁 on 5/28/26.
//

import Foundation

public struct PreloadSong: Equatable, Sendable {
    public let isrc: String
    public let startTime: TimeInterval
    
    public init(isrc: String, startTime: TimeInterval) {
        self.isrc = isrc
        self.startTime = startTime
    }
}

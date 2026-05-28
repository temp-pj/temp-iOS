//
//  PreloadSong.swift
//  Models
//
//  Created by 송지혁 on 5/28/26.
//

import Foundation

public struct PreloadSong: Equatable, Sendable {
    public let id: String
    public let startTime: TimeInterval
    public let endTime: TimeInterval
}

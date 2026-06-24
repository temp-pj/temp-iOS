//
//  ServerConfig.swift
//  ClientRoomSessionLive
//
//  Created by 송지혁 on 6/23/26.
//

import Foundation

enum ServerConfig {
    static var host: String {
        guard let host = Bundle.main.object(forInfoDictionaryKey: "SERVER_HOST") as? String, !host.isEmpty else {
            fatalError("SERVER HOST가 Info.plist에 없음")
        }
        
        return host
    }
}

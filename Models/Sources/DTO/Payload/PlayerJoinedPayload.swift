struct PlayerJoinedPayload: Codable {
    let playerId: String
    
    enum CodingKeys: String, CodingKey {
        case playerId = "PlayerID"
    }
}
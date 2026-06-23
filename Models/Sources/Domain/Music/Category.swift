//
//  Category.swift
//  Models
//
//  Created by 송지혁 on 6/2/26.
//

import Foundation

public struct Category: Equatable, Codable {
    let startYear: Int
    let endYear: Int
    let artistType: String
    let country: String
    let gender: String
    let genre: String
    
    public init(startYear: Int, endYear: Int, artistType: String, country: String, gender: String, genre: String) {
        self.startYear = startYear
        self.endYear = endYear
        self.artistType = artistType
        self.country = country
        self.gender = gender
        self.genre = genre
    }
}

//
//  Rating.swift
//  Movie-App
//
//  Created by Margaux Mazaleyras on 30/01/2025.
//

import Foundation

struct Rating: Codable {
    let source: String // ex: "Internet Movie Database"
    let value: String // ex: "8.3/10"
    
    enum CodingKeys: String, CodingKey {
        case source = "Source"
        case value = "Value"
    }
}


/* - - - - - - - - - - M O C K - - - - - - - - - - */

// Mocked data for Rating
extension Rating {
    static var mock: Rating {
        return Rating(
            source: "Internet Movie Database",
            value: "8.3/10"
        )
    }
}

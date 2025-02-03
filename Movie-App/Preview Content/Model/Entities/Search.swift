//
//  Search.swift
//  Movie-App
//
//  Created by Margaux Mazaleyras on 30/01/2025.
//

import Foundation

struct Search : Codable {
    let title: String // ex: "Inception"
    let year: String // ex: 2010"
    let imdbID: String // ex: "tt1375666"
    let type: String // ex: "movie"
    let poster: String // ex: "https:\//m.media-amazon.com/images/M/MV5BMjAxMzY3NjcxNF5BMl5BanBnXkFtZTcwNTI5OTM0Mw@@._V1_SX300.jpg"
    
    enum CodingKeys: String, CodingKey {
            case title = "Title"
            case year = "Year"
            case imdbID
            case type = "Type"
            case poster = "Poster"
        }

}

struct SearchResponse : Codable {
    let results: [Search] // dynamic table of searches
    let totalResults: String // ex: "38"
    let response: String // "True"
    
    enum CodingKeys: String, CodingKey {
        case results = "Search"
        case totalResults
        case response = "Response"
    }
}


/* - - - - - - - - - - M O C K - - - - - - - - - - */

// Mocked data for Search
extension Search {
    static func generateMock() -> Search {
        return Search(
            title: "Inception",
            year: "2010",
            imdbID: "tt1375666",
            type: "movie",
            poster: "https://m.media-amazon.com/images/M/MV5BMjAxMzY3NjcxNF5BMl5BanBnXkFtZTcwNTI5OTM0Mw@@._V1_SX300.jpg"
        )
    }
    
    static func generateTabOfSearchMocks(numberOfMocks: Int) -> [Search] {
        return Array(repeating: .generateMock(), count: numberOfMocks)
    }
}

// Mocked data for SearchResponse
extension SearchResponse {
    static func generateMock() -> SearchResponse {
        return SearchResponse(
            results: Search.generateTabOfSearchMocks(numberOfMocks: 5),
            totalResults: "5",
            response: "True"
        )
    }
}


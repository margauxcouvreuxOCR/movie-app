//
//  Search.swift
//  Movie-App
//
//  Created by Margaux Mazaleyras on 30/01/2025.
//

import Foundation

struct MovieSearch : Codable {
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

struct SearchResponse: Decodable {
    let search: [MovieSearch]? // ex: [ Movie1, Movie2, ...]
    let error: String? // ex: "Too many results."
    let response: String // ex: "True"
    
    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case error = "Error"
        case response = "Response"
    }
}



/* - - - - - - - - - - M O C K - - - - - - - - - - */

// Mocked data for Search
extension MovieSearch {
    static func generateMock() -> MovieSearch {
        return MovieSearch(
            title: "Inception",
            year: "2010",
            imdbID: "tt1375666",
            type: "movie",
            poster: "https://m.media-amazon.com/images/M/MV5BMjAxMzY3NjcxNF5BMl5BanBnXkFtZTcwNTI5OTM0Mw@@._V1_SX300.jpg"
        )
    }
    
    // a table of mocked searches
    static func generateTabOfSearchMocks(numberOfMocks: Int) -> [MovieSearch] {
        return Array(repeating: .generateMock(), count: numberOfMocks)
    }
}

// Mocked data for SearchResponse
extension SearchResponse {
    static func generateMock() -> SearchResponse {
        return SearchResponse(
            search: MovieSearch.generateTabOfSearchMocks(numberOfMocks: 5),
            error: nil,
            response: "True"
        )
    }

}


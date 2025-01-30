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
}

//
//  Movie.swift
//  Movie-App
//
//  Created by Margaux Mazaleyras on 30/01/2025.
//

import Foundation

struct Movie : Codable {
    let title: String // ex: "Prison Break"
    let year: String // ex: "2005–2017"
    let rated: String // ex: "TV-14"
    let released: String // ex: "29 Aug 2005"
    let runtime: String // ex: "44 min"
    let genre: String // ex: "Action, Crime, Drama"
    let director: String // ex: "N/A"
    let writer: String // ex: "Paul T. Scheuring"
    let actors: String // ex: "Dominic Purcell, Wentworth Miller, Amaury Nolasco"
    let plot: String // ex: "A structural engineer installs himself in a prison he helped design..."
    let language: String // ex: "English, Spanish, Arabic"
    let country: String // ex: "United Kingdom, United States"
    let awards: String // ex: "Nominated for 1 Primetime Emmy. 8 wins & 32 nominations total"
    let poster: String // ex: "https:\//m.media-amazon.com/images/M/MV5BMTg3NTkwNzAxOF5BMl5BanBnXkFtZTcwMjM1NjI5MQ@@._V1_SX300.jpg"
    let metascore: String // ex: "N/A"
    let imdbRating: String // ex: "8.3"
    let imdbVotes: String // ex: "608,495"
    let imdbID: String // ex: "tt0455275"
    let type: String // ex: "series"
    let totalSeasons: String? // ex: "5"
    let response: String // ex: "True"
    let ratings: [Rating] // a table of obj Rating
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case language = "Language"
        case country = "Country"
        case awards = "Awards"
        case poster = "Poster"
        case metascore = "Metascore"
        case imdbRating
        case imdbVotes
        case imdbID
        case type = "Type"
        case totalSeasons = "totalSeasons" // might not exist for a movie
        case response = "Response"
        case ratings = "Ratings"
    }
}


/* - - - - - - - - - - M O C K - - - - - - - - - - */

// Mocked data for Movie
extension Movie {
    static func generateMock() -> Movie {
        return Movie(
            title: "Prison Break",
            year: "2005–2017",
            rated: "TV-14",
            released: "29 Aug 2005",
            runtime: "44 min",
            genre: "Action, Crime, Drama",
            director: "C. Nolan",
            writer: "Paul T. Scheuring",
            actors: "Dominic Purcell, Wentworth Miller, Amaury Nolasco",
            plot: "A structural engineer installs himself in a prison he helped design...",
            language: "English, Spanish, Arabic",
            country: "United Kingdom, United States",
            awards: "Nominated for 1 Primetime Emmy. 8 wins & 32 nominations total",
            poster: "https://m.media-amazon.com/images/M/MV5BMTg3NTkwNzAxOF5BMl5BanBnXkFtZTcwMjM1NjI5MQ@@._V1_SX300.jpg",
            metascore: "N/A",
            imdbRating: "8.3",
            imdbVotes: "608,495",
            imdbID: "tt0455275",
            type: "series",
            totalSeasons: "5",
            response: "True",
            ratings: [Rating.mock]
        )
    }

    // a table of mocked movies
    static func generateTabOfMovieMocks(numberOfMocks: Int) -> [Movie] {
        return Array(repeating: .generateMock(), count: numberOfMocks)
    }
    
}

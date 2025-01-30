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
    let rated: String // ex: TV-14
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
    let totalSeasons: String // ex: "5"
    let response: String // ex: "True"
    let ratings: [Rating] // a table of obj Rating
}


//
//  Bridge.swift
//  Movie-App
//
//  Created by Margaux Mazaleyras on 30/01/2025.
//

import Foundation

// Bridge class makes communication possible between View and Model
class BridgeViewModel {
    
    // Singleton instance to ensure a single shared object across the app.
    static let shared = BridgeViewModel()
    
    weak var movieSearchDelegate: MovieSearchDelegate? { // Delegate to notify when allMovieSearches is updated
        didSet {
            movieSearchDelegate?.didUpdateSearch(with: allMovieSearches) // Notify delegate of initial state
        }
    }

    // Instance of API handler for making network calls
    let callAPI = APICalls()
    
    /* - - - - - - - - - - V A R I A B L E S - - - - - - - - - - */
    
    // Dynamic property to store the movie query
    @Published private var movieQuery: String = "" {
        didSet {
            // Log the changes to `movieQuery` for debugging purposes.
            print("BVM_Update : territorySlug changed from \(oldValue) to \(movieQuery)")
        }
    }
    
    // Dynamic property to store the vehicle ID.
    @Published private var movieId: String = "" {
        didSet {
            // Log the changes to `vehicleId` for debugging purposes.
            print("Update : vehicleId changed from \(String(describing: oldValue)) to \(String(describing: movieId))")
        }
    }
    
    /* - - - - - - - - - - S E T T E R S _ G E T T E R S - - - - - - - - - - */
    
    // Updates the `movieQuery` value.
    func setMovieQuery(_ movieQuery: String) {
        self.movieQuery = movieQuery
    }
    
    // Updates the `vehicleId` value.
    func setMovieId(_ imdbID: String) {
        self.movieId = imdbID
    }
    
    // Obtain a movie Id
    func getMovieId() -> String {
        return movieId
    }
    
    // Obtain the current movie from Api calls using its id
    func getCurrentMovie(imdbID: String) async -> Movie {
        return await callAPI.fetchMovie(for: imdbID)
    }
    
    // Obtain the search response from Api calls using its query
    func getSearch(searchQuery: String) async -> SearchResponse {
        return await callAPI.fetchSearch(for: searchQuery)
    }
    
    /* - - - - - - - - - - A R R A Y S - - - - - - - - - - */
    
    // Stores allMovieSearches fetched from the API
    @Published var allMovieSearches: [MovieSearch] = []

    
}

// Protocol for search results updates
protocol MovieSearchDelegate: AnyObject {
    func didUpdateSearch(with allMovieSearches: [MovieSearch]) // Called when the allMovieSearches (list of movieSeazrches) is updated
}

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
    
    weak var movieSearchDelegate: MovieSearchDelegate? { // Delegate to notify when the roadmap is updated
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
    
    /* - - - - - - - - - - S E T T E R S - - - - - - - - - - */
    
    // Updates the `movieQuery` value.
    func setMovieQuery(_ movieQuery: String) {
        self.movieQuery = movieQuery
    }
    
    /* - - - - - - - - - - A R R A Y S - - - - - - - - - - */
    
    // Stores allMovieSearches fetched from the API
    @Published var allMovieSearches: [MovieSearch] = []
    
}

// Protocol for roadmap updates
protocol MovieSearchDelegate: AnyObject {
    func didUpdateSearch(with allMovieSearches: [MovieSearch]) // Called when the roadmap (list of places) is updated
}

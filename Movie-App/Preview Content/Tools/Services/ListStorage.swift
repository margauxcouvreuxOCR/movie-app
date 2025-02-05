//
//  ListStorage.swift
//  Movie-App
//
//  Created by Margaux Mazaleyras on 04/02/2025.
//

import Foundation

class ListStorage: ObservableObject {
    
    // List of locally stored favorite movies
    @Published var favoriteMovies: [Movie] = [] {
        didSet {
            saveList(favoriteMovies, forKey: favoritesKey)
        }
    }
    
    // List of locally stored movies to watch
    @Published var watchlistMovies: [Movie] = [] {
        didSet {
            saveList(watchlistMovies, forKey: watchlistKey)
        }
    }
    
    // Key used to store and retrieve the lists of favorite/watchlist movies in UserDefaults
    private let favoritesKey: String
    private let watchlistKey: String

    init(favoritesKey: String, watchlistKey: String) {
        self.favoritesKey = favoritesKey
        self.watchlistKey = watchlistKey
        self.loadLists()
    }
    
    // Add a movie to a list
    func add(_ movie: Movie, to list: inout [Movie]) {
        if !list.contains(where: { $0.imdbID == movie.imdbID }) {
            list.append(movie)
        }
    }
    
    // Remove a movie from a list
    func remove(_ movie: Movie, from list: inout [Movie]) {
        list.removeAll { $0.imdbID == movie.imdbID }
    }
    
    // Check if a movie is already in a list
    func contains(_ movie: Movie, in list: [Movie]) -> Bool {
        return list.contains(where: { $0.imdbID == movie.imdbID })
    }
    
    // Save a list
    private func saveList(_ list: [Movie], forKey key: String) {
        if let encoded = try? JSONEncoder().encode(list) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
    // Load a list of movies
    private func loadLists() {
        if let favoritesData = UserDefaults.standard.data(forKey: favoritesKey),
           let decodedFavorites = try? JSONDecoder().decode([Movie].self, from: favoritesData) {
            favoriteMovies = decodedFavorites
        }
        
        if let watchlistData = UserDefaults.standard.data(forKey: watchlistKey),
           let decodedWatchlist = try? JSONDecoder().decode([Movie].self, from: watchlistData) {
            watchlistMovies = decodedWatchlist
        }
    }
}

extension ListStorage {
    static let shared = ListStorage(favoritesKey: "favoriteMovies", watchlistKey: "watchlistMovies")
}



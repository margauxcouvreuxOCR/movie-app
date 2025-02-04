//
//  ContentView.swift
//  Movie-App
//
//  Created by Margaux Mazaleyras on 30/01/2025.
//

import SwiftUI

struct ContentView: View {
    init() {
        greetingMessage()
    }
    
    @ObservedObject var store = ListStorage.shared
    
    var body: some View {
        TabView {
            NavigationStack {
                SearchView()
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
        
            // Vue des favoris
            NavigationStack {
                MovieListView(movies: store.favoriteMovies)
                .navigationTitle("Favorites")
            }
            .tabItem {
                Image(systemName: "heart")
                Text("Favorites")
            }
            
            // Vue de la watchlist
            NavigationStack {
                MovieListView(movies: store.watchlistMovies)
                .navigationTitle("Watchlist")
            }
            .tabItem {
                Image(systemName: "eye")
                Text("Watchlist")
            }
        } .accentColor(Color("DarkerGrey"))
        

    }
}

// Private function to print a welcome message to the console when the ContentView appears
private func greetingMessage() {
    // Print a welcome message to the console with formatting
    print("\n= = = = = \nWELCOME : MOVIE_APP\n= = = = =\n")
}

#Preview {
    ContentView()
}

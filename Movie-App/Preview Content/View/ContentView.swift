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
                Text("title_search")
            }
        
            // Vue des favoris
            NavigationStack {
                MovieListView(movies: store.favoriteMovies)
                .navigationTitle("title_favorites")
            }
            .tabItem {
                Image(systemName: "heart")
                Text("title_favorites")
            }
            
            // Vue de la watchlist
            NavigationStack {
                MovieListView(movies: store.watchlistMovies)
                .navigationTitle("title_watchlist")
            }
            .tabItem {
                Image(systemName: "eye")
                Text("title_watchlist")
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

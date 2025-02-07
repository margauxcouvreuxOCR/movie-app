//
//  ContentView.swift
//  Movie-App
//
//  Created by Margaux Mazaleyras on 30/01/2025.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    init() {
        greetingMessage()
    }
    
    // Shared storage for favorite and watchlist movies
    @ObservedObject var store = ListStorage.shared
    
    // Tracks user authentication status
    @State private var isUserLoggedIn = Auth.auth().currentUser != nil

    var body: some View {
        Group {
            if isUserLoggedIn {
                
                // Displays the main app interface if the user is logged in
                TabView {
                    
                    // Search tab
                    NavigationStack {
                        SearchView()
                    }
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("title_search")
                    }
                
                    // Favorites tab
                    NavigationStack {
                        MovieListView(movies: store.favoriteMovies)
                            .navigationTitle("title_favorites")
                    }
                    .tabItem {
                        Image(systemName: "heart")
                        Text("title_favorites")
                    }
                    
                    // Watchlist tab
                    NavigationStack {
                        MovieListView(movies: store.watchlistMovies)
                            .navigationTitle("title_watchlist")
                    }
                    .tabItem {
                        Image(systemName: "eye")
                        Text("title_watchlist")
                    }

                    // Logout tab
                    NavigationStack {
                        LogoutView(isUserLoggedIn: $isUserLoggedIn)
                    }
                    .tabItem {
                        Image(systemName: "power")
                        Text("title_logout")
                    }
                }
                .accentColor(Color("DarkerGrey"))
            } else {
                // Shows login view if the user is not logged in
                LoginView(isUserLoggedIn: $isUserLoggedIn)
            }
        }
    }
}

extension ContentView {
    // Prints a welcome message when ContentView appears
    private func greetingMessage() {
        print("\n= = = = = \nWELCOME : MOVIE_APP\n= = = = =\n")
    }
    
    // Logs out the user
    private func signOut() {
        do {
            try Auth.auth().signOut()
            isUserLoggedIn = false
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

#Preview {
    ContentView()
}

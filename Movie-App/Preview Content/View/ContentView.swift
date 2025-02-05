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
    
    @ObservedObject var store = ListStorage.shared
    @State private var isUserLoggedIn = Auth.auth().currentUser != nil

    var body: some View {
        Group {
            if isUserLoggedIn {
                // Affiche l'application si l'utilisateur est connecté
                TabView {
                    NavigationStack {
                        SearchView()
                    }
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("title_search")
                    }
                
                    NavigationStack {
                        MovieListView(movies: store.favoriteMovies)
                        .navigationTitle("title_favorites")
                    }
                    .tabItem {
                        Image(systemName: "heart")
                        Text("title_favorites")
                    }
                    
                    NavigationStack {
                        MovieListView(movies: store.watchlistMovies)
                        .navigationTitle("title_watchlist")
                    }
                    .tabItem {
                        Image(systemName: "eye")
                        Text("title_watchlist")
                    }

                    // Onglet de déconnexion
                    NavigationStack {
                        LogoutView(isUserLoggedIn: $isUserLoggedIn)
                    }
                    .tabItem {
                        Image(systemName: "power")
                        Text("Déconnexion")
                    }
                }
                .accentColor(Color("DarkerGrey"))
            } else {
                // Affiche la vue de connexion si l'utilisateur n'est pas connecté
                LoginView(isUserLoggedIn: $isUserLoggedIn)
            }
        }
    }
    
    // Fonction de déconnexion
    private func signOut() {
        do {
            try Auth.auth().signOut()
            isUserLoggedIn = false
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

// Shows a welcome message in console when ContentView appears
private func greetingMessage() {
    print("\n= = = = = \nWELCOME : MOVIE_APP\n= = = = =\n")
}

#Preview {
    ContentView()
}

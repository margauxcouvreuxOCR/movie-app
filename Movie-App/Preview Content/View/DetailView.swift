//
//  DetailView.swift
//  Movie-App
//
//  Created by Margaux Mazaleyras on 04/02/2025.
//

import SwiftUI

struct DetailView: View {
    
    
    @ObservedObject var viewModel: ViewModel // View model for the view logic
    @ObservedObject var favorites = ListStorage.shared // Shared instance for favorite movies
    @ObservedObject var watchlist = ListStorage.shared // Shared instance for watchlist movies
    let imdbID: String // IMDb ID for movie detail
    
    
    init(imdbID: String) {
        self.imdbID = imdbID
        self.viewModel = ViewModel(imdbID: imdbID)
    }
    
    var body: some View {
        
        ZStack {
            
            // Gradient color for background
            LinearGradient(
                gradient: Gradient(colors: [Color("LightGrey"), Color("DarkGrey")]),
                startPoint: .top,
                endPoint: .bottom
            )
            .opacity(0.1)
            .ignoresSafeArea()
            
            
            // Scrollview of the detailed view
            ScrollView {
                VStack {
                    
                    if viewModel.isLoading {
                        
                        // Displays a progression status while loading
                        ProgressView("detail_loading")
                            .progressViewStyle(CircularProgressViewStyle())
                            .font(.title)
                        
                    } else if let movie = viewModel.currentMovie {
                        
                        VStack(alignment: .leading, spacing: 10) {
                            
                            // Movie title, big format
                            Text(movie.title)
                                .font(.largeTitle)
                                .bold()
                            
                            // Movie poster
                            AsyncImage(url: URL(string: movie.poster)) { image in
                                image.resizable()
                                    .scaledToFill()
                                    .frame(maxWidth: .infinity)
                                    .clipped()
                                    .cornerRadius(10)
                            } placeholder: {
                                ProgressView() // 🔹 Affiche un placeholder pendant le chargement de l'image
                            }
                            
                            // Movie title, smaller
                            Text(movie.title)
                                .font(.title)
                                .foregroundStyle(Color("DarkerGrey"))
                            
                            // Rating displayed using star format
                            HStack(spacing: 2) {
                                let ratingValue = Double(movie.imdbRating) ?? 0.0
                                let starCount = Int(ratingValue / 2) // Convertir la note sur 10 en étoiles sur 5
                                
                                ForEach(0..<5) { index in
                                    Image(systemName: index < starCount ? "star.fill" : "star")
                                        .foregroundColor(Color("DarkerGrey"))
                                        .font(.caption)
                                }
                                Text(" (\(movie.imdbRating))").font(.caption)
                            }
                            
                            // Movie description
                            Text(movie.plot)
                            
                            // Title for movie director
                            Text("detail_director")
                                .bold()
                                .foregroundStyle(Color("DarkerGrey"))
                            
                            // Actual movie director
                            Text(movie.director)
                            
                            // Buttons to add the movie to a list of favorites or watchlist
                            HStack(spacing: 20){
                                
                                // Button to add/remove from Favorites
                                Button(action: {
                                    if favorites.contains(movie, in: favorites.favoriteMovies) {
                                        favorites.remove(movie, from: &favorites.favoriteMovies)
                                    } else {
                                        favorites.add(movie, to: &favorites.favoriteMovies)
                                    }
                                }) {
                                    // If the movie is in Favorites, heart is filled, otherwise it's lined
                                    Image(systemName: favorites.contains(movie, in: favorites.favoriteMovies) ? "heart.fill" : "heart")
                                }
                                
                                // Button to add/remove from Watchlist
                                Button(action: {
                                    if watchlist.contains(movie, in: watchlist.watchlistMovies) {
                                        watchlist.remove(movie, from: &watchlist.watchlistMovies)
                                    } else {
                                        watchlist.add(movie, to: &watchlist.watchlistMovies)
                                    }
                                }) {
                                    // If the movie is in Watchlist, eye is filled, otherwise it's lined
                                    Image(systemName: watchlist.contains(movie, in: watchlist.watchlistMovies) ? "eye.fill" : "eye")
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                            .foregroundColor(Color("DarkerGrey"))
                            .font(.largeTitle)
                            .padding(10)
                        }
                        .padding()
                        
                    } else {
                        // If error occurs, displays a message instead of the movie
                        Text("error_loading")
                            .foregroundColor(.red)
                    }
                }
                
                .padding()
            }
            .navigationTitle("") // No nav title, movie title is displayed instead
            .navigationBarTitleDisplayMode(.inline) // Stops the content from drowning the top bar
            
        }
    }
}



extension DetailView {
    class ViewModel: ObservableObject {
        @Published var currentMovie: Movie? = nil // Starts empty
        @Published var isLoading = true // Says if the page is loading or not
        
        init(imdbID: String) {
            print("\n- - - - -\nVIEW ON : Detail Movie \n- - - - -\n")
            fetchMovie(imdbID: imdbID)
        }
        
        func fetchMovie(imdbID: String) {
            Task {
                // Sets the movie response from a call made in BVM usind the movie id
                let movieResponse = await BridgeViewModel().getCurrentMovie(imdbID: imdbID)
                
                DispatchQueue.main.async {
                    self.currentMovie = movieResponse
                    self.isLoading = false // Fin du chargement
                }
            }
        }
    }
}




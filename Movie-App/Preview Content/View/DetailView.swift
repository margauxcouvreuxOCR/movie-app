//
//  DetailView.swift
//  Movie-App
//
//  Created by Margaux Mazaleyras on 04/02/2025.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var viewModel: ViewModel
    @ObservedObject var favorites = ListStorage.shared
    @ObservedObject var watchlist = ListStorage.shared
    let imdbID: String
    
    init(imdbID: String) {
        self.imdbID = imdbID
        self.viewModel = ViewModel(imdbID: imdbID)
    }

    var body: some View {
        
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color("LightGrey"), Color("DarkGrey")]),
                startPoint: .top,
                endPoint: .bottom
            )
            .opacity(0.1)
            .ignoresSafeArea()
            ScrollView {

        VStack {
            if viewModel.isLoading {
                ProgressView("detail_loading") // 🔹 Affiche un indicateur de chargement
                    .progressViewStyle(CircularProgressViewStyle())
                    .font(.title)
            } else if let movie = viewModel.currentMovie {
                VStack(alignment: .leading, spacing: 10) {
                    Text(movie.title)
                        .font(.largeTitle)
                        .bold()

                    
                    AsyncImage(url: URL(string: movie.poster)) { image in
                        image.resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity)
                            .clipped()
                            .cornerRadius(10)
                    } placeholder: {
                        ProgressView() // 🔹 Affiche un placeholder pendant le chargement de l'image
                    }

                    Text(movie.title)
                        .font(.title)
                        .foregroundStyle(Color("DarkerGrey"))
                    
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

                    Text(movie.plot)

                    Text("detail_director")
                        .bold()
                        .foregroundStyle(Color("DarkerGrey"))

                    Text(movie.director)
                    
                    HStack(spacing: 20){ //icones fav et watchlist
                        // Bouton pour ajouter/retirer des favoris
                        Button(action: {
                            if favorites.contains(movie, in: favorites.favoriteMovies) {
                                favorites.remove(movie, from: &favorites.favoriteMovies)
                            } else {
                                favorites.add(movie, to: &favorites.favoriteMovies)
                            }
                        }) {
                            // Si le film est dans les favoris, on affiche un cœur rempli, sinon un cœur vide
                            Image(systemName: favorites.contains(movie, in: favorites.favoriteMovies) ? "heart.fill" : "heart")
                        }
                        
                        // Bouton pour ajouter/retirer de la watchlist
                        Button(action: {
                            if watchlist.contains(movie, in: watchlist.watchlistMovies) {
                                watchlist.remove(movie, from: &watchlist.watchlistMovies)
                            } else {
                                watchlist.add(movie, to: &watchlist.watchlistMovies)
                            }
                        }) {
                            // Si le film est dans la watchlist, on affiche un œil rempli, sinon un œil vide
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
                Text("error_loading")
                    .foregroundColor(.red)
            }
        }
                
        .padding()
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
            
           
            
        }
    }
}



extension DetailView {
    class ViewModel: ObservableObject {
        @Published var currentMovie: Movie? = nil // Commence vide
        @Published var isLoading = true // Indique si le chargement est en cours
        
        init(imdbID: String) {
            print("\n- - - - -\nVIEW ON : Detail Movie \n- - - - -\n")
            fetchMovie(imdbID: imdbID)
        }
        
        func fetchMovie(imdbID: String) {
            Task {
                let movieResponse = await BridgeViewModel().getCurrentMovie(imdbID: imdbID)
                
                DispatchQueue.main.async {
                    self.currentMovie = movieResponse
                    self.isLoading = false // Fin du chargement
                }
            }
        }
    }
}




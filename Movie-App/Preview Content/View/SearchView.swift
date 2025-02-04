//
//  SearchView.swift
//  Movie-App
//
//  Created by Margaux Mazaleyras on 03/02/2025.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel = ViewModel() // ViewModel instance

    var body: some View {
        NavigationStack {
            VStack {
                TextField("search_query", text: $viewModel.searchQuery)
                    .textFieldStyle(RoundedBorderTextFieldStyle()) // Style du champ de recherche
                    .padding()
                
                // Affichage du message d'erreur si présent
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }

                
                // Liste des résultats
                
                List(viewModel.movieSearchResults, id: \.imdbID) { movie in
                    HStack {
                        
                        AsyncImage(url: URL(string: movie.poster != "N/A" ? movie.poster : "https://via.placeholder.com/50x75")) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 50, height: 75)
                        .clipShape(RoundedRectangle(cornerRadius: 5))


                        VStack(alignment: .leading) {
                            Text(movie.title)
                                .font(.headline)
                            Text(movie.year)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .navigationTitle("search_title")
        }
    }
}

extension SearchView {
    class ViewModel: ObservableObject, MovieSearchDelegate {
        @Published var errorMessage: String? = nil
        @Published var movieSearchResults: [MovieSearch] = [] // Initialisation correcte
        @Published var searchQuery: String = "" {
            didSet {
                fetchMovieQueryResults(searchQuery: searchQuery)
            }
        }
        
        private var bridgeViewModel: BridgeViewModel
        
        init() {
            print("\n- - - - -\nVIEW ON : Search Movie \n- - - - -\n")
            self.bridgeViewModel = BridgeViewModel()
            self.bridgeViewModel.movieSearchDelegate = self
        }
        
        func fetchMovieQueryResults(searchQuery: String) {
            guard !searchQuery.isEmpty else {
                self.movieSearchResults = []
                self.errorMessage = nil
                return
            }

            Task {
                let searchResponse = await APICalls.shared.fetchSearch(for: searchQuery)

                DispatchQueue.main.async {
                    if let error = searchResponse.error {
                        // Si l'API renvoie une erreur
                        self.errorMessage = error
                        self.movieSearchResults = []
                    } else if let results = searchResponse.search {
                        // Si l'API renvoie des résultats valides
                        self.movieSearchResults = results
                        self.errorMessage = nil
                    } else {
                        // Cas inconnu
                        self.errorMessage = "error_unknown"
                        self.movieSearchResults = []
                    }
                }
            }
        }

        
        // Delegate method: mise à jour des résultats
        func didUpdateSearch(with movieSearchResults: [MovieSearch]) {
            DispatchQueue.main.async {
                self.movieSearchResults = movieSearchResults
            }
        }

    }
}

#Preview {
    SearchView()
}

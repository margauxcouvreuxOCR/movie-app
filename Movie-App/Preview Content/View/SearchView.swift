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
                
                // Liste des résultats
                List(viewModel.movieSearchResults, id: \.imdbID) { movie in
                    HStack {
                        AsyncImage(url: URL(string: movie.poster)) { image in
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
        @Published var movieSearchResults: [MovieSearch] = [] // Initialisation correcte
        @Published var searchQuery: String = "" {
            didSet {
                fetchMovieQueryResults(searchQuery: searchQuery)
            }
        }
        
        private var bridgeViewModel: BridgeViewModel
        
        init() {
            print("\n- - - - -\nTURNING ON : Search Movie \n- - - - -\n")
            self.bridgeViewModel = BridgeViewModel()
            self.bridgeViewModel.movieSearchDelegate = self
//            loadMockData() // Activer pour tester sans API
        }
        
        func fetchMovieQueryResults(searchQuery: String) {
            guard !searchQuery.isEmpty else {
                self.movieSearchResults = [] // Réinitialiser si vide
                return
            }
            
            Task {
                let response = await APICalls.shared.fetchSearch(for: searchQuery)
                DispatchQueue.main.async {
                    self.movieSearchResults = response
                }
            }
        }
        
        // Delegate method: mise à jour des résultats
        func didUpdateSearch(with movieSearchResults: [MovieSearch]) {
            DispatchQueue.main.async {
                self.movieSearchResults = movieSearchResults
            }
        }

//        func loadMockData() {
//            let mockResponse = SearchResponse.generateMock()
//            movieSearchResults = mockResponse.results
//        }
    }
}

#Preview {
    SearchView()
}

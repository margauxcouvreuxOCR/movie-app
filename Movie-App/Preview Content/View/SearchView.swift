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
                
        HStack {
        }
        .searchable(text: $viewModel.searchQuery) // Une seule barre de recherche ici
        .navigationTitle("search_title")

        VStack {
            if viewModel.searchQuery.isEmpty && viewModel.movieSearchResults.isEmpty {
                MovieClapper()
                Text("error_empty")
                    .foregroundColor(Color("DarkerGrey"))
                    .font(.headline)

            } else if viewModel.movieSearchResults.isEmpty {
                if let errorMessage = viewModel.errorMessage {
                    MovieClapper()
                    Text(errorMessage)
                        .foregroundColor(Color("DarkerGrey"))
                        .font(.headline)

                }
            } else {
                SearchListView(searches: viewModel.movieSearchResults)
            }
        }
        
        
    }
}

extension SearchView {
    class ViewModel: ObservableObject, MovieSearchDelegate {
        @Published var errorMessage: String? = nil
        @Published var movieSearchResults: [MovieSearch] = []
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
                let searchResponse = await bridgeViewModel.getSearch(searchQuery: searchQuery)
                
                DispatchQueue.main.async {
                    if let error = searchResponse.error {
                        self.errorMessage = error
                        self.movieSearchResults = []
                    } else if let results = searchResponse.search {
                        self.movieSearchResults = results
                        self.errorMessage = nil
                    } else {
                        self.errorMessage = "error_unknown"
                        self.movieSearchResults = []
                    }
                }
            }
        }
        
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

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
            // (Empty on purpose)
        }
        .searchable(text: $viewModel.searchQuery) // Searchable text field
        .navigationTitle("search_title")

        VStack {
            // Check if search query and results are empty
            if viewModel.searchQuery.isEmpty && viewModel.movieSearchResults.isEmpty {
                
                // Display placeholder for no search results
                MovieClapper()
                
                // Display error text for empty results
                Text("error_empty")
                    .foregroundColor(Color("DarkerGrey"))
                    .font(.headline)

                // Check if there are no results but a query
            } else if viewModel.movieSearchResults.isEmpty {
                
                // Display error message if any
                if let errorMessage = viewModel.errorMessage {
                    
                    // Display placeholder for error
                    MovieClapper()
                    
                    // Show the error message
                    Text(errorMessage)
                        .foregroundColor(Color("DarkerGrey"))
                        .font(.headline)

                }
            } else {
                // Show search results in list
                SearchListView(searches: viewModel.movieSearchResults)
            }
        }
    }
}

extension SearchView {
    class ViewModel: ObservableObject, MovieSearchDelegate {
        
        @Published var errorMessage: String? = nil // Holds error message
        @Published var movieSearchResults: [MovieSearch] = [] // List of search results
        @Published var searchQuery: String = "" { // Search query text
            didSet {
                fetchMovieQueryResults(searchQuery: searchQuery) // Fetch results when query changes
            }
        }
        
        private var bridgeViewModel: BridgeViewModel // Instance of BridgeViewModel
        
        init() {
            print("\n- - - - -\nVIEW ON : Search Movie \n- - - - -\n")
            self.bridgeViewModel = BridgeViewModel()
            self.bridgeViewModel.movieSearchDelegate = self
        }
        
        // Fetch search results from the bridge view model
        func fetchMovieQueryResults(searchQuery: String) {
            // If query is empty resets results
            guard !searchQuery.isEmpty else {
                self.movieSearchResults = []
                self.errorMessage = nil
                return
            }
            
            Task {
                // Fetch data asynchronously
                let searchResponse = await bridgeViewModel.getSearch(searchQuery: searchQuery)
                
                DispatchQueue.main.async {
                    if let error = searchResponse.error {
                        // Handle error
                        self.errorMessage = error
                        self.movieSearchResults = []
                    } else if let results = searchResponse.search {
                        // Handle successful response
                        self.movieSearchResults = results
                        self.errorMessage = nil
                    } else {
                        // Handle unknown error
                        self.errorMessage = "error_unknown"
                        self.movieSearchResults = []
                    }
                }
            }
        }
        
        // Delegate method to update search results
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

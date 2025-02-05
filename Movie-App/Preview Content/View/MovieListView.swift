//
//  MovieListView.swift
//  Movie-App
//
//  Created by Margaux Mazaleyras on 04/02/2025.
//

import SwiftUI

struct MovieListView: View {
    
    var movies: [Movie] // List of movies to display
    
    var body: some View {
        
        // If movie list is empty dislays movie clapper with error message
        if movies.isEmpty {
            MovieClapper()
            Text("error_empty")
                .foregroundColor(Color("DarkerGrey"))
                .font(.headline)
        } else {
            // Displays the list of movies in a table of movies
            List(movies, id: \.imdbID) { movie in
                
                // Navigate to detailView using movie id
                NavigationLink(destination: DetailView(imdbID: movie.imdbID)) {
                    
                    HStack {
                        // Movie poster
                        AsyncImage(url: URL(string: movie.poster != "N/A" ? movie.poster : "https://via.placeholder.com/50x75")) { image in
                            image
                                .resizable() // Make the image resizable
                                .scaledToFit() // Scale the image
                                .frame(width: 60, height: 60) // Set frame for image
                                .clipShape(RoundedRectangle(cornerRadius: 10)) // Round the image corners
                        } placeholder: {
                            ProgressView()
                                .frame(width: 50, height: 50)
                        }
                        
                        // Display movie text next to the poster
                        VStack(alignment: .leading) {
                            Text(movie.title)
                                .font(.headline)
                            Text(movie.year)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
    }
}

struct SearchListView: View {
    
    var searches: [MovieSearch] // List of search results
    
    var body: some View {
        // Displays the list of movies in a table of searches
        List(searches, id: \.imdbID) { movie in
            
            // Navigate to detailView using movie id
            NavigationLink(destination: DetailView(imdbID: movie.imdbID)) {
                
                HStack {
                    
                    // Movie poster
                    AsyncImage(url: URL(string: movie.poster != "N/A" ? movie.poster : "https://via.placeholder.com/50x75")) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 50, height: 75)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    
                    // Display movie text next to the poster
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
    }
}

//
//  MovieListView.swift
//  Movie-App
//
//  Created by Margaux Mazaleyras on 04/02/2025.
//

import SwiftUI

struct MovieListView: View {
    var movies: [Movie]
    
    var body: some View {
        if movies.isEmpty {
            MovieClapper()
            Text("error_empty")
                .foregroundColor(Color("DarkerGrey"))
                .font(.headline)
        } else {
                List(movies, id: \.imdbID) { movie in
                    NavigationLink(destination: DetailView(imdbID: movie.imdbID)) {
                        HStack {
                            
                            AsyncImage(url: URL(string: movie.poster != "N/A" ? movie.poster : "https://via.placeholder.com/50x75")) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60, height: 60)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            } placeholder: {
                                ProgressView()
                                    .frame(width: 50, height: 50)
                            }
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


struct SearchListView : View {
    var searches: [MovieSearch]
    
    var body: some View {
        List(searches, id: \.imdbID) { movie in
            NavigationLink(destination: DetailView(imdbID: movie.imdbID)) {
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

    }
}

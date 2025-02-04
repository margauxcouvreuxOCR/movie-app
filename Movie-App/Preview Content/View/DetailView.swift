//
//  DetailView.swift
//  Movie-App
//
//  Created by Margaux Mazaleyras on 04/02/2025.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var viewModel: ViewModel
    let imdbID: String
    
    init(imdbID: String) {
        self.imdbID = imdbID
        self.viewModel = ViewModel(imdbID: imdbID)
    }

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("detail_loading") // 🔹 Affiche un indicateur de chargement
                    .progressViewStyle(CircularProgressViewStyle())
                    .font(.title)
            } else if let movie = viewModel.currentMovie {
                VStack(alignment: .leading, spacing: 10) {
                    Text(movie.title)
                        .bold()
                        .font(.largeTitle)

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

                    Text(movie.plot)

                    Text("detail_director")
                        .bold()

                    Text(movie.director)
                }
                .padding()
            } else {
                Text("error_loading")
                    .foregroundColor(.red)
            }
        }
        .padding()
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



#Preview {
    DetailView(imdbID: "tt0455275")
}

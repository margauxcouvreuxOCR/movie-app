//
//  DetailView.swift
//  Movie-App
//
//  Created by Margaux Mazaleyras on 04/02/2025.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var viewModel = ViewModel() // ViewModel instance
    var currentMovie: Movie = Movie.generateMock()

    var body: some View {
        VStack(alignment: .leading, spacing: 10) { // Aligne tout le contenu à gauche
            Text(currentMovie.title)
                .bold()
                .font(.largeTitle)

            AsyncImage(url: URL(string: currentMovie.poster)) { image in
                image.resizable() // Redimensionner l'image
                    .scaledToFill() // Remplir l'espace sans conserver les proportions
                    .frame(maxWidth: .infinity) // L'image prend toute la largeur
                    .clipped() // Empêche que l'image dépasse
                    .cornerRadius(10) // Coins arrondis
            } placeholder: {
                ProgressView() // Affiche une barre de progression pendant le chargement de l'image
            }
            
            Text(currentMovie.title)
                .font(.title)

            Text(currentMovie.plot)
            
            Text("detail_director")
                .bold()
            
            Text(currentMovie.director)
        }
        .padding() // Un peu de marge autour du contenu
    }
}


extension DetailView {
    class ViewModel: ObservableObject {
        
        private var bridgeViewModel: BridgeViewModel
        init() {
            print("\n- - - - -\nVIEW ON : Detail Movie \n- - - - -\n")
            self.bridgeViewModel = BridgeViewModel()
        }
    }
}

#Preview {
    DetailView()
}

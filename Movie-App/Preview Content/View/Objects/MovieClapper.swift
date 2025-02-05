//
//  MovieClapper.swift
//  Movie-App
//
//  Created by Margaux Mazaleyras on 05/02/2025.
//

import SwiftUI

struct MovieClapper: View {
    
    var body: some View {
        Image(systemName: "movieclapper.fill")
            .resizable()
            .frame(width: 100, height: 100)
            .overlay(
                LinearGradient(
                    gradient: Gradient(colors: [Color("LightGrey"), Color("DarkGrey")]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .mask(
                    Image(systemName: "movieclapper.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                )
            )
    }
}

#Preview {
    MovieClapper()
}

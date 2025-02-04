//
//  Movie_AppApp.swift
//  Movie-App
//
//  Created by Margaux Mazaleyras on 30/01/2025.
//

import SwiftUI

@main
struct Movie_AppApp: App {
    @State private var isActive = false

       var body: some Scene {
           WindowGroup {
               if isActive {
                   ContentView() // ⚡️ Affiche l’app après 2 secondes
               } else {
                   LaunchScreen()
                       .onAppear {
                           DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                               isActive = true
                           }
                       }
               }
           }
       }
}

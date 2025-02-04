//
//  ContentView.swift
//  Movie-App
//
//  Created by Margaux Mazaleyras on 30/01/2025.
//

import SwiftUI

struct ContentView: View {
    init() {
        greetingMessage()
    }
    var body: some View {
        SearchView()
    }
}

// Private function to print a welcome message to the console when the ContentView appears
private func greetingMessage() {
    // Print a welcome message to the console with formatting
    print("\n= = = = = \nWELCOME : MOVIE_APP\n= = = = =\n")
}

#Preview {
    ContentView()
}

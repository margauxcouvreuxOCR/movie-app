//
//  LogoutView.swift
//  Movie-App
//
//  Created by Margaux Mazaleyras on 05/02/2025.
//

import SwiftUI
import FirebaseAuth

struct LogoutView: View {
    @Binding var isUserLoggedIn: Bool

    var body: some View {
        VStack {
            Text("Voulez-vous vraiment vous déconnecter ?")
                .padding()
            Button(action: {
                signOut()
            }) {
                Text("Se déconnecter")
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
    }

    private func signOut() {
        do {
            try Auth.auth().signOut()
            isUserLoggedIn = false
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

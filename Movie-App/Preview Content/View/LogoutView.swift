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
        
        VStack(spacing: 20) {
            
            // Question + message to ensure action
            VStack(alignment: .leading, spacing: 8) {
                Text("deconnexion_question")
                    .font(.title)
                    .bold()

                Text("deconnexion_alert")
                    .font(.subheadline)
            }
            
            Divider()
            
            HStack {
                Spacer()
                
                // Lougout button
                Button(action: {
                    signOut()
                }) {
                    Text("deconnexion_logout")
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 1)
        )
        .padding()
    }

}

extension LogoutView {
    // Signout sets the authentication to false to logout
    private func signOut() {
        do {
            try Auth.auth().signOut()
            isUserLoggedIn = false
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

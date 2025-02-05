//
//  LoginView.swift
//  Movie-App
//
//  Created by Margaux Mazaleyras on 05/02/2025.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @Binding var isUserLoggedIn: Bool

    var body: some View {
        VStack {
            
            // Animated logo
            Image("Movie_app")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .cornerRadius(50)
                
            // App title
            Text("title_app")
                .font(.largeTitle)
                .foregroundColor(Color("DarkerGrey"))
                .bold()
            
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Button(action: {
                Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                    if let error = error {
                        alertMessage = error.localizedDescription
                        showingAlert = true
                    } else {
                        alertMessage = "Connexion réussie!"
                        showingAlert = true
                        isUserLoggedIn = true
                    }
                }
            }) {
                Text("Se connecter")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Résultat"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
        .padding()
    }
}

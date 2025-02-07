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
        
        ZStack {
            
            // Gradient color for background
            LinearGradient(
                gradient: Gradient(colors: [Color("LightGrey"), Color("DarkGrey")]),
                startPoint: .top,
                endPoint: .bottom
            )
            .opacity(0.1)
            .ignoresSafeArea()
            
            
            VStack {
                Spacer()
                
                // Logo
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
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("label_email")
                        .font(.headline)
                        .foregroundStyle(Color("DarkerGrey"))
                    
                    TextField("text_email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding()
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("label_password")
                        .font(.headline)
                        .foregroundStyle(Color("DarkerGrey"))
                    
                    SecureField("text_password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding()
                
                Spacer()
                
                // Login button
                Button(action: {
                    loginUser()
                }) {
                    Text("connexion_login")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color("DarkerGrey"))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("connexion_result"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                    
                }
                .padding(.horizontal)
                .padding(.bottom,20)
            }
            .padding()
            
        }
    }
    
    
    
}

extension LoginView {
    // Signout sets the authentication to true to login
    private func loginUser() {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                alertMessage = error.localizedDescription
                showingAlert = true
            } else {
                alertMessage = "connexion_success"
                showingAlert = true
                isUserLoggedIn = true
            }
        }
    }
}

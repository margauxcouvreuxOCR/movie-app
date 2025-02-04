//
//  LaunchScreen.swift
//  Movie-App
//
//  Created by Margaux Mazaleyras on 04/02/2025.
//

import SwiftUI

struct LaunchScreen: View {
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color("LightGrey"), Color("DarkGrey")]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack {
                Image("Movie_app") // Ton logo ou image de lancement
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .cornerRadius(50)
                    .opacity(isAnimating ? 1 : 0.3) // Control opacity for blinking effect
                    .animation(Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: true), value: isAnimating) // Animation that repeats forever with easing
                    .onAppear {
                        isAnimating = true // Start the animation when the view appears
                    }
                    

                Text("Movie App")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .bold()
            }
        }
    }
}

#Preview {
    LaunchScreen()
}

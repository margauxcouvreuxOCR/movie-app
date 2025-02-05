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
            
            // Gradient color for background
            LinearGradient(
                gradient: Gradient(colors: [Color("LightGrey"), Color("DarkGrey")]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack {
                
                // Animated logo
                Image("Movie_app")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .cornerRadius(50)
                    .opacity(isAnimating ? 1 : 0.3) // Control opacity for blinking effect
                    .animation(Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: true), value: isAnimating) // Animation that repeats forever with easing
                    .onAppear {
                        isAnimating = true // Start the animation when the view appears
                    }
                    
                // App title
                Text("title_app")
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

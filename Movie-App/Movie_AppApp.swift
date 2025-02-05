//
//  Movie_AppApp.swift
//  Movie-App
//
//  Created by Margaux Mazaleyras on 30/01/2025.
//

import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct Movie_AppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @State private var isActive = false


    var body: some Scene {
        WindowGroup {
            if isActive {
                ContentView() // Affiche l'app après 2 secondes
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

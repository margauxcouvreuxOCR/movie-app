//
//  Bridge.swift
//  Movie-App
//
//  Created by Margaux Mazaleyras on 30/01/2025.
//

import Foundation

// Bridge class makes communication possible between View and Model
class BridgeViewModel {
    
    static let shared = BridgeViewModel() // Singleton for Bridge
    
    let callAPI = APICalls() // Instance of Api caller
    
}

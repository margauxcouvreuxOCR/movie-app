//
//  DataFormatter.swift
//  Movie-App
//
//  Created by Margaux Mazaleyras on 30/01/2025.
//

import Foundation

// Extend the `Data` class to add a `printJson` method for printing JSON data in a readable format.
extension Data {
    
    // This function displays the JSON data as a readable string.
    func printJson() {
        do {
            // Attempt to convert data into a JSON object
            let json = try JSONSerialization.jsonObject(with: self, options: [])
            
            // Convert the JSON object into pretty-printed data
            let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            
            // Convert the data into a UTF-8 string
            guard let jsonString = String(data: data, encoding: .utf8) else {
                // If conversion fails, display an error message
                print("Invalid data")
                return
            }
            
            // Print the JSON string in the console
            print(jsonString)
        } catch {
            // Catch and display any errors
            print("Error: \(error.localizedDescription)")
        }
    }
}

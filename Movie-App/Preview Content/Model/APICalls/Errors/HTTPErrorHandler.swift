//
//  HTTPErrorHandler.swift
//  Movie-App
//
//  Created by Margaux Mazaleyras on 30/01/2025.
//

import Foundation

// HTTPErrorHandler class manages HTTP errors
class HTTPErrorHandler {
    
    // Function to retrieve the error message based on the HTTP status code
    // If the status code is not found, it returns a default error message.
    func message(forStatusCode code: Int) -> String {
        return HTTPErrorMessages.statusMessages[code] ?? "Unknown error: Status code \(code)"
    }

    // Function to create an NSError based on the status code
    func createError(forStatusCode code: Int) -> NSError {
        let message = message(forStatusCode: code)
        return NSError(domain: "APICalls", code: code, userInfo: [NSLocalizedDescriptionKey: message])
    }

    // Function to handle HTTP request errors
    // It checks if the HTTP status code is not 200 (success) and returns an error if true.
    func handleRequestError(response: URLResponse?) -> NSError? {
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
            return createError(forStatusCode: httpResponse.statusCode)
        }
        return nil
    }

    // Function to handle decoding errors
    // It creates an NSError based on the decoding error description.
    func handleDecodingError(error: Error) -> NSError {
        let message = "Decoding error: \(error.localizedDescription)"
        return NSError(domain: "APICalls", code: 0, userInfo: [NSLocalizedDescriptionKey: message])
    }

    // Function to handle general errors (other than request or decoding errors)
    // It creates an NSError based on the error description.
    func handleGeneralError(error: Error) -> NSError {
        let message = "General error: \(error.localizedDescription)"
        return NSError(domain: "APICalls", code: 0, userInfo: [NSLocalizedDescriptionKey: message])
    }
}

//
//  HTTPErrorMessages.swift
//  Movie-App
//
//  Created by Margaux Mazaleyras on 30/01/2025.
//

import Foundation

// HTTPErrorMessages struct stores most commun http request error messags
struct HTTPErrorMessages {
    // A dictionary mapping HTTP status codes to their respective error messages.
    static let statusMessages: [Int: String] = [
        200: NSLocalizedString("error_200", comment: "Sytem error for HTTP status code 200"),
        204: NSLocalizedString("error_204", comment: "Sytem error for HTTP status code 204"),
        400: NSLocalizedString("error_400", comment: "System error for HTTP status code 400"),
        401: NSLocalizedString("error_401", comment: "System error for HTTP status code 401"),
        403: NSLocalizedString("error_403", comment: "System error for HTTP status code 403"),
        404: NSLocalizedString("error_404", comment: "System error for HTTP status code 404"),
        500: NSLocalizedString("error_500", comment: "System error for HTTP status code 500")
    ]
}

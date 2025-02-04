//
//  APICalls.swift
//  Movie-App
//
//  Created by Margaux Mazaleyras on 30/01/2025.
//

import Foundation

// APICalls class makes the calls to the api
class APICalls {
    
    static let shared = APICalls()
    
    // ex: https:\//www.omdbapi.com/?s=PrisonBreak&apikey=fc07f088
    
    /* - - - - - - - - - - V A R I A B L E S - - - - - - - - - - */
    // Instances and route storage
    let errorHandler = HTTPErrorHandler() // instance of obj HttpErreorHandler
    let baseURL = "https://www.omdbapi.com" // the base url for OMDb api
    let searchURL = "/?s="
    let apiKeyURL = "&apikey=fc07f088" // the api key for OMDb api
    
    /* - - - - - - - - - - M O V I E _ S E A R C H - - - - - - - - - - */
    
    // Fetch searches for the query in search bar
    func fetchSearch(for movieQuery: String) async -> SearchResponse {
        let url = buildUrl(for: movieQuery)
        print("APICALLS_fetchSearch: URL = \(url)")

        let request = buildRequest(for: url)

        do {
            if let searchResponse: SearchResponse = await fetchData(for: request) {
                return searchResponse
            } else {
                print("APICALLS_fetchSearch: No Movie Searches")
                return SearchResponse(search: nil, error: "Unknown error", response: "False")
            }
        }
    }

    

    
    /* - - - - - - - - - - T O O L S - - - - - - - - - - */
    
    // Build URL from route string
    func buildUrl(for movieTitle: String) -> URL {
        guard let encodedTitle = movieTitle.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: baseURL + searchURL + encodedTitle + apiKeyURL) else {
            fatalError("APICALLS_buildUrl: Invalid URL after encoding: \(baseURL + searchURL + movieTitle + apiKeyURL)")
        }
        return url
    }

    
    
    // Build URLRequest for the given URL while authenticated to the app
    func buildRequest(for url: URL, authenticated : Bool = true) -> URLRequest {
        var request = URLRequest(url: url)
//        if authenticated {
//            let token = "Token \(DynamicsHandler.shared.loginToken)"
//            print("Api call : buildRequest(for : \(url) | Token value : \(token)")
//            request.addValue(token, forHTTPHeaderField: "Authorization")  // Add authorization header
//        }
        return request  // Return request
    }
    
    
    // Fetch and decode data from URLRequest
    func fetchData<T: Decodable>(for request: URLRequest) async -> T? {
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            data.printJson()  // Debugging

            if let error = errorHandler.handleRequestError(response: response) {
                print("APICALLS_fetchData: HTTP Error: \(error.localizedDescription)")
                return nil  // Retourne nil en cas d'erreur
            }

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(T.self, from: data)  // Décode en type générique
        } catch {
            print("APICALLS_fetchData: Decoding error: \(error.localizedDescription)")
            return nil
        }
    }

}

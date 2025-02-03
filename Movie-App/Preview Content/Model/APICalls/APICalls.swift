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
    
    /* - - - - - - - - - - V A R I A B L E S - - - - - - - - - - */
    // Instances and route storage
    let errorHandler = HTTPErrorHandler() // instance of obj HttpErreorHandler
    let baseURL = "https://www.omdbapi.com" // the base url for OMDb api
    let apiKey = "fc07f088" // the api key for OMDb api
    
    func fetchSearch(query: String) async -> [Search] {
        guard let url = URL(string: "https://www.omdbapi.com/?s=\(query)&apikey=\(apiKey)") else {
            print("APICALLS_fetchSearch: Invalid URL")
            return []
        }
        print("APICALLS_fetchSearch: \(url.absoluteString)")
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let searchData  = try decoder.decode(SearchResponse.self, from: data)
            return searchData.results
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    // ex: https:\//www.omdbapi.com/?s=PrisonBreak&apikey=fc07f088
    
}

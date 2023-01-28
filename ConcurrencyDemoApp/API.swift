//
//  API.swift
//  ConcurrencyDemoApp
//
//  Created by Mobven-HasanGungor on 26.01.2023.
//

import Foundation

final class API {
    static let shared: API = API()
    private init() { }
    
    func search(term: String, completion: @escaping(Result<iTunesSearchResponse?, Error>) ->()) {
        
        var urlComponents = URLComponents(string: "https://itunes.apple.com/search")!
        urlComponents.queryItems = [URLQueryItem(name: "term", value: term)]
        
        var urlRequest = URLRequest(url: urlComponents.url!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, err in
            
            if let error = err {
                completion(.failure(error))
            } else {
                if let searchData = data {
                    do {
                        let searchResponse = try JSONDecoder().decode(iTunesSearchResponse.self, from: searchData)
                        completion(.success(searchResponse))
                        
                    } catch (let err) {
                        completion(.failure(err))
                    }
                }
            }
        }
        
        task.resume()
    }
}

//
//  ModernConcurrency.swift
//  ConcurrencyDemoApp
//
//  Created by Mobven-HasanGungor on 28.01.2023.
//

import Foundation

final class ModernConcurrency {
    
    func fetchMusicDataFromItunes() async throws -> iTunesSearchResponse {
        
        var urlComponents = URLComponents(string: "https://itunes.apple.com/search")!
        urlComponents.queryItems = [URLQueryItem(name: "term", value: "Sezen Aksu")]
        
        let urlRequest = URLRequest(url: urlComponents.url!)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        print("Response::: \(response)")
        
        do {
            return try JSONDecoder().decode(iTunesSearchResponse.self, from: data)
        } catch(let err) {
            print(err.localizedDescription)
            throw err
        }
    }
    
    // MARK: DispatchQueues - Before async/await
    func fetchWeatherHistory(completion: @escaping ([Double]) -> Void) {
        // Complex networking code here; we'll just send back 100,000 random temperatures
        DispatchQueue.global().async {
            let results = (1...100_000).map { _ in Double.random(in: -10...30) }
            completion(results)
        }
    }

    func calculateAverageTemperature(for records: [Double], completion: @escaping (Double) -> Void) {
        // Sum our array then divide by the array size
        DispatchQueue.global().async {
            let total = records.reduce(0, +)
            let average = total / Double(records.count)
            completion(average)
        }
    }

    func upload(result: Double, completion: @escaping (String) -> Void) {
        // More complex networking code; we'll just send back "OK"
        DispatchQueue.global().async {
            completion("OK")
        }
    }
    
    // MARK: New - After Swift 5.5 async/await
    func fetchWeatherHistory() async -> [Double] {
        (1...100_000).map { _ in Double.random(in: -10...30) }
    }

    func calculateAverageTemperature(for records: [Double]) async -> Double {
        let total = records.reduce(0, +)
        let average = total / Double(records.count)
        return average
    }

    func upload(result: Double) async -> String {
        "OK"
    }
}

//
//  SwiftConcurrencyViewController.swift
//  ConcurrencyDemoApp
//
//  Created by Mobven-HasanGungor on 5.02.2023.
//

import UIKit

class SwiftConcurrencyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let modernConcurrency = ModernConcurrency()
        
//        Task {
//            do {
//                let response = try await modernConcurrency.fetchMusicDataFromItunes()
//                print(response.results)
//            } catch (let err) {
//                print(err.localizedDescription)
//            }
//        }
//
//        Task {
//            await example1()
//        }
        
        
//        Task {
//            modernConcurrencyExample
//        }
    }
    
    // Swift offers a special syntax that lets you group several asynchronous calls and await them all together.
    func example1() async {
        let modernConcurrency = ModernConcurrency()

        async let call1 = modernConcurrency.fetchMusicDataFromItunes()
        async let call2 = modernConcurrency.fetchMusicDataFromItunes()
        async let call3 = modernConcurrency.fetchMusicDataFromItunes()
        
        do {
            let calls = try await [call1, call2, call3]
            print(calls)
        } catch (let error) {
            print(error.localizedDescription)
        }
    }
    
    func modernConcurrencyExample() async {
        let modernConcurrency = ModernConcurrency()
        
        let records = await modernConcurrency.fetchWeatherHistory()
        let average = await modernConcurrency.calculateAverageTemperature(for: records)
        let response = await modernConcurrency.upload(result: average)
        
        print("Server response: \(response)")
    }
    
    func dispatchQueueExample() {
        let modernConcurrency = ModernConcurrency()

        modernConcurrency.fetchWeatherHistory { records in
            modernConcurrency.calculateAverageTemperature(for: records) { avgTemp in
                modernConcurrency.upload(result: avgTemp) { response in
                    print("Server Response: \(response)")
                }
            }
        }
    }
}

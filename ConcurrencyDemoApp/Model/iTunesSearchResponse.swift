//
//  iTunesSearchResponse.swift
//  ConcurrencyDemoApp
//
//  Created by Mobven-HasanGungor on 28.01.2023.
//

import Foundation

struct iTunesSearchResponse: Decodable {
    
    let results: [iTunesResult]
}

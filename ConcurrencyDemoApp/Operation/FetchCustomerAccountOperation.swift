//
//  FetchCustomerAccountOperation.swift
//  ConcurrencyDemoApp
//
//  Created by Mobven-HasanGungor on 29.01.2023.
//

import Foundation

class FetchCustomerAccountOperation: Operation {
    
    override func main() {
        guard !isCancelled else { return }
        
        print("Fetching customer account.....")
        sleep(1) // Act like long-running
    }
}

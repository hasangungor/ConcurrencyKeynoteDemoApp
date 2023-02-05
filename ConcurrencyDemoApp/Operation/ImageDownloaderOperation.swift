//
//  OperationDemo.swift
//  ConcurrencyDemoApp
//
//  Created by Mobven-HasanGungor on 28.01.2023.
//

import Foundation

class ImageDownloaderOperation: Operation {
    
    override func main() {
        
        guard !dependencies.contains(where: { $0.isCancelled }), !isCancelled else {
            return
        }
        
        print("Image downloading.....")
        sleep(2) // Act like long-running
    }
}

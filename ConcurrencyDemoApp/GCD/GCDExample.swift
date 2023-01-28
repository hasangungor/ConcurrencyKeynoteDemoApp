//
//  GCDExample.swift
//  ConcurrencyDemoApp
//
//  Created by Mobven-HasanGungor on 28.01.2023.
//

import Foundation

final class GCDExample {
    
    static func dispatchQueueExaple() {
        
        let queue = DispatchQueue(label: "com.concurrencyDemo.app")
        
        // Somewhere in your function
        queue.async {
            // Call slow non-UI methods here
            
            DispatchQueue.main.async {
                // Update the UI here
            }
        }
    }
    
    static func concurrentQueueExample() {
        
        let concurrentQueue = DispatchQueue.global()
        
        concurrentQueue.async {
            print("Task 1....")
        }
        
        concurrentQueue.async {
            sleep(2)
            print("Task 2....")
        }
        
        concurrentQueue.async {
            sleep(1)
            print("Task 3....")
        }
        
        concurrentQueue.async {
            print("Task 4....")
        }
    }
}

//
//  DispatchGroupExample.swift
//  ConcurrencyDemoApp
//
//  Created by Mobven-HasanGungor on 4.02.2023.
//

import Foundation

final class DispatchGroupExample {
    
    func dispatchGroupDemo() {
        
        let dispatchGroup = DispatchGroup()
        
        let sampleTaskDispatchQueue = DispatchQueue(label: "com.concurrencyAppDemo.task1")
        let sampleTaskDispatchQueue2 = DispatchQueue(label: "com.concurrencyAppDemo.task2")
        let sampleTaskDispatchQueue3 = DispatchQueue(label: "com.concurrencyAppDemo.task3")
        
        dispatchGroup.enter()
        sampleTaskDispatchQueue.async {
            print("Do jobs..")
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        sampleTaskDispatchQueue2.async {
            print("Do some different jobs..")
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        sampleTaskDispatchQueue3.async {
            print("Do some long running different jobs..")
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            print("All jobs are done, you can refresh the UI")
        }
    }
}

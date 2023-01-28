//
//  ViewController.swift
//  ConcurrencyDemoApp
//
//  Created by Mobven-HasanGungor on 26.01.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        exampleGrandCentralDispatch()
        
//        GCDExample.concurrentQueueExample()
    }
    
    func fetchSearchAPI() {
        API.shared.search(term: "Taylor Swift") { result in
            switch result {
            case .success(let success):
                _ = success
//                print(success)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func exampleGrandCentralDispatch() {
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            // Run async on the Background Thread. E.g.: Some API calls.
            // ..
            print("---- Background Thread Running: API call running..")
            self?.fetchSearchAPI()
            sleep(2)
            print("---- ----- ------ ------ ------ ------ -------")
            
            DispatchQueue.main.async { [weak self] in
                // Run async code on the Main/UI Thread. E.g.: Refresh TableView
                // ...
                print("Main Thread is runnning. UI is refreshed")
                self?.label.text = "API called"
                print("---- ----- ------ ------ ------ ------ -------")
            }
        }
    }
}


//
//  OperationDemoViewController.swift
//  ConcurrencyDemoApp
//
//  Created by Mobven-HasanGungor on 4.02.2023.
//

import UIKit
import Combine

class OperationDemoViewController: UIViewController {
    
    @IBOutlet var statusLabel: UILabel!
    
    var cancellable: AnyCancellable?
    var observation : NSKeyValueObservation?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("------------------------------------------------------------")
        let imageDownloadOperation = ImageDownloaderOperation()
        imageDownloadOperation.completionBlock = {
            print("Image is downloaded.")
            DispatchQueue.main.async { [weak self] in
                self?.statusLabel.text = "Image is downloaded."
            }
        }
        
        let fetchCustomerAccountOperation = FetchCustomerAccountOperation()
        fetchCustomerAccountOperation.completionBlock = {
            print("Customer account is fetched.")
            DispatchQueue.main.async { [weak self] in
                self?.statusLabel.text = "Customer account is fetched."
            }
        }
        
        let operationQueue = OperationQueue()
        
        // KVO - Key Value Observing
        observation = operationQueue.observe(\.operationCount, options: [.new]) { [unowned self] queue, changeValue in
            if changeValue.newValue! == 0 {
                self.observation = nil
                print("All tasks are done.")
                DispatchQueue.main.async { [weak self] in
                    self?.statusLabel.text = "All tasks are done."
                }
            }
        }
        
        imageDownloadOperation.addDependency(fetchCustomerAccountOperation) // image downloading operation will start when customer fetch finished
        
        operationQueue.addOperation(fetchCustomerAccountOperation)
        operationQueue.addOperation(imageDownloadOperation)

    }
    
    func updateUI(status: String) {
        DispatchQueue.main.async { [weak self] in
            self?.statusLabel.text = status
        }
    }
}

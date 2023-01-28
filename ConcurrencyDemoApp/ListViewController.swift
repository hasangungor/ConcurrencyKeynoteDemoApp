//
//  ListViewController.swift
//  ConcurrencyDemoApp
//
//  Created by Mobven-HasanGungor on 28.01.2023.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet var listTableView: UITableView!
    
    var itunesResults: [iTunesResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.dataSource = self
        listTableView.delegate = self
        
        API.shared.search(term: "Micheal Jackson") { [weak self] result in
            switch result {
            case .success(let res):
                if let response = res {
                    self?.itunesResults = response.results
                    self?.reloadList()
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    
    func reloadList() {
        DispatchQueue.main.async { [weak self] in
            self?.listTableView.reloadData()
        }
    }
}


extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itunesResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultCell", for: indexPath) as! ResultTableViewCell
        cell.configure(with: itunesResults[indexPath.row])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

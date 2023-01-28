//
//  ResultTableViewCell.swift
//  ConcurrencyDemoApp
//
//  Created by Mobven-HasanGungor on 28.01.2023.
//

import UIKit

class ResultTableViewCell: UITableViewCell {

    @IBOutlet var artworkImage: UIImageView!
    @IBOutlet var artistNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func configure(with result: iTunesResult) {
        artistNameLabel.text = result.artistName
        downloadImage(imageURL: result.artworkUrl100)
    }
    
    
    private func downloadImage(imageURL: URL) {
        let task = URLSession.shared.dataTask(with: URLRequest(url: imageURL)) { data, response, err in
            if err == nil , let imgData = data {

                // Main Thread Issue
//                self.artworkImage.image = UIImage(data: imgData)
                
                // Correct Way: Update UI in only main thread
                DispatchQueue.main.async { [weak self] in
                    self?.artworkImage.image = UIImage(data: imgData)
                }
            }
        }
        
        task.resume()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

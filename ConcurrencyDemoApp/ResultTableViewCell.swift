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
                self.setImageWithCorrectWayInMainThread(data: imgData)
            }
        }
        
        task.resume()
    }
    
    func setImageWithWrongWayInBackgroundThread(data: Data) {
        // Main Thread Issue will occurs
        self.artworkImage.image = UIImage(data: data)
    }
    
    func setImageWithCorrectWayInMainThread(data: Data) {
        DispatchQueue.main.async { [weak self] in
            self?.artworkImage.image = UIImage(data: data)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

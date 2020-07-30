//
//  NewsTableViewCell.swift
//  Newsapp-demo-iOS
//
//  Created by Kapil Bhattarai on 7/29/20.
//  Copyright © 2020 Kapil Bhattarai. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    @IBOutlet weak var newsDescription: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsTitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setCell(news: News) {
        newsTitleLabel.text = news.title
        newsDescription.text = news.description
        if news.thumbnail != "" {
            if  let cacheData = CacheManager.getVideoCache(news.thumbnail) {
                newsImage.image = UIImage(data: cacheData)
                return
            }
            guard let url =  URL(string: news.thumbnail) else {
                return
            }
            let session = URLSession.shared
            let dataTask = session.dataTask(with: url) { (data, _, error) in
                guard let data = data, error == nil else {
                    return
                }
                if url.absoluteString != news.thumbnail {
                    return
                }
                CacheManager.setVideoCache(url.absoluteString, data)
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.newsImage.image = image
                }
            }
            dataTask.resume()
        }
    }
}
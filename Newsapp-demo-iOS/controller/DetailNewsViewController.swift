//
//  DetailNewsViewController.swift
//  Newsapp-demo-iOS
//
//  Created by Kapil Bhattarai on 7/29/20.
//  Copyright © 2020 Kapil Bhattarai. All rights reserved.
//

import UIKit

class DetailNewsViewController: UIViewController {

    @IBOutlet weak var newsDescription: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    var newsItem: News?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        newsDescription.text = ""
        newsTitle.text = ""
        guard newsItem != nil else {
            return
        }
        newsDescription.text = newsItem!.description
        newsTitle.text = newsItem!.title
        if newsItem!.thumbnail != "" {
                   if  let cacheData = CacheManager.getVideoCache(newsItem!.thumbnail) {
                       newsImage.image = UIImage(data: cacheData)
                       return
                   }
                   let url = URL(string: newsItem!.thumbnail)
                   let session = URLSession.shared
                   guard url != nil else {
                       return
                   }
                   let dataTask = session.dataTask(with: url!) { (data, _, error) in
                       if error == nil && data != nil {
                        if url!.absoluteString != self.newsItem!.thumbnail {
                               return
                           }
                           CacheManager.setVideoCache(url!.absoluteString, data!)
                           let image = UIImage(data: data!)
                           DispatchQueue.main.async {
                               self.newsImage.image = image
                           }
                       }
                   }
                   dataTask.resume()
    }
}
}

//
//  DetailNewsViewController.swift
//  Newsapp-demo-iOS
//
//  Created by Kapil Bhattarai on 7/29/20.
//  Copyright © 2020 Kapil Bhattarai. All rights reserved.
//

import UIKit
import SDWebImage

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
        guard let newsItem = newsItem else {
            return
        }
        newsDescription.text = newsItem.description
        newsTitle.text = newsItem.title
        self.newsImage.sd_setImage(with: URL(string: newsItem.thumbnail))
    }
}

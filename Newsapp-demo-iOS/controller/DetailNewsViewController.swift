//
//  DetailNewsViewController.swift
//  Newsapp-demo-iOS
//
//  Created by Kapil Bhattarai on 7/29/20.
//  Copyright © 2020 Kapil Bhattarai. All rights reserved.
//

import UIKit
import SDWebImage
import SafariServices

class DetailNewsViewController: UIViewController {
    @IBOutlet weak var newsDescription: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var fullNews: UIButton!
    @IBOutlet weak var newsTitle: UILabel!
    var newsItem: News?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "isDarkTheme") {
            overrideUserInterfaceStyle = .dark
        } else {
            overrideUserInterfaceStyle = .light
        }
        newsDescription.text = ""
        newsTitle.text = ""
        guard let newsItem = newsItem else {
            return
        }
        newsDescription.text = newsItem.descriptions
        newsTitle.text = newsItem.title
        self.newsImage.sd_setImage(with: URL(string: newsItem.thumbnail))
    }
    @IBAction func onFullNewsClicked(_ sender: Any) {
        let browserVc = SFSafariViewController(url: URL(string: newsItem!.link)!)
        present(browserVc, animated: true)
    }
}

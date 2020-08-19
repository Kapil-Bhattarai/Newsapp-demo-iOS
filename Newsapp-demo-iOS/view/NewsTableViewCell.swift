//
//  NewsTableViewCell.swift
//  Newsapp-demo-iOS
//
//  Created by Kapil Bhattarai on 7/29/20.
//  Copyright © 2020 Kapil Bhattarai. All rights reserved.
//

import UIKit
import SDWebImage

protocol NewsTableViewCellDelegate: AnyObject {
    func onBookmarkClicked(_ cell: NewsTableViewCell, _ sender: UIButton)
}

class NewsTableViewCell: UITableViewCell {
    @IBOutlet weak var newsDescription: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var bookmarkImage: UIButton!
    weak var delegate: NewsTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setCell(news: News) {
        newsTitleLabel.text = news.title
        newsDescription.text = news.descriptions
        self.newsImage.sd_setImage(with: URL(string: news.thumbnail))
        if news.isBookMarked {
            self.bookmarkImage.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
       } else {
           self.bookmarkImage.setImage(UIImage(systemName: "bookmark"), for: .normal)
       }
    }
    @IBAction func onBookmarkClicked(_ sender: UIButton) {
         delegate?.onBookmarkClicked(self, sender)
    }
}

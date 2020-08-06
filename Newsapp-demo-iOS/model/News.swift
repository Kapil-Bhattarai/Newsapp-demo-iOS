//
//  News.swift
//  Newsapp-demo-iOS
//
//  Created by Kapil Bhattarai on 7/29/20.
//  Copyright © 2020 Kapil Bhattarai. All rights reserved.
//

import Foundation
import RealmSwift

class News: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var descriptions: String = ""
    @objc dynamic var thumbnail: String = ""
    @objc dynamic var isBookMarked: Bool = false
    convenience  init(newsTitle title: String,
                      newsDescriptions descriptions: String,
                      image thumbnail: String,
                      save isBookMarked: Bool) {
        self.init()
        self.title = title
        self.descriptions = descriptions
        self.thumbnail = thumbnail
        self.isBookMarked = isBookMarked
    }
}

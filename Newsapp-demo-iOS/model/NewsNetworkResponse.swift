//
//  NewsNetworkResponse.swift
//  Newsapp-demo-iOS
//
//  Created by Kapil Bhattarai on 7/29/20.
//  Copyright © 2020 Kapil Bhattarai. All rights reserved.
//

import Foundation

// MARK: - NewsNetworkResponse
struct NewsNetworkResponse: Codable {
    let version: Int?
    let feeds: [Feed]?
}

// MARK: - Feed
struct Feed: Codable {
    let id, title, description, content: String?
    let link: String?
    let encloserurl, encloserType, source, category: String?
    let author, image, uuid, fetchDate: String?
    let pubDate, updateDate: String?

    enum CodingKeys: String, CodingKey {
        case id, title
        case description
        case content, link
        case encloserurl
        case encloserType
        case source, category, author, image, uuid
        case fetchDate
        case pubDate
        case updateDate
    }
}

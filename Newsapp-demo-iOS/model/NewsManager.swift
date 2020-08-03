//
//  NewsManager.swift
//  Newsapp-demo-iOS
//
//  Created by Kapil Bhattarai on 7/29/20.
//  Copyright © 2020 Kapil Bhattarai. All rights reserved.
//

import Foundation
import Alamofire

protocol NewsManagerDelegate: AnyObject {
    func didUpdateNews(_ newsManager: NewsManager, _ news: [News])
    func didFailWithError(_ error: Error)
}
struct NewsManager {
    weak var delegate: NewsManagerDelegate?
    func fetchNews() {
        guard let url =  URL(string: "\(Constants.NewsURL)") else {
            return
        }
        AF.request(url).response { (response) in
            guard let data = response.data else {return}
            do {
                let decoder = JSONDecoder()
                let news = try decoder.decode(NewsNetworkResponse.self, from: data)
                let newsItems = news.feeds?.map { ( item: Feed) in
                    News(title: item.title ?? "",
                         description: item.description ?? "",
                         thumbnail: item.image ?? "")
                }
                if let news = newsItems {
                    DispatchQueue.main.async {
                        self.delegate?.didUpdateNews(self, news)
                    }
                }
            } catch {
                self.delegate?.didFailWithError(error)
                return
            }
        }
    }
}

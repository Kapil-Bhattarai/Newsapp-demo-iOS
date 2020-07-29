//
//  NewsManager.swift
//  Newsapp-demo-iOS
//
//  Created by Kapil Bhattarai on 7/29/20.
//  Copyright © 2020 Kapil Bhattarai. All rights reserved.
//

import Foundation

protocol NewsManagerDelegate: AnyObject {
    func didUpdateNews(_ newsManager: NewsManager, _ news: [News])
    func didFailWithError(_ error: Error)
}
struct NewsManager {
    weak var delegate: NewsManagerDelegate?
    func fetchNews() {
        let url = URL(string: "\(Constants.NewsURL)")
        guard url != nil else {
            return
        }
        let session  = URLSession.shared
        let dataTask = session.dataTask(with: url!) { (data, _, error) in
            if data == nil || error != nil {
                return
            }
            do {
                let decoder = JSONDecoder()
                //decoder.dateDecodingStrategy = .iso8601
                let news = try decoder.decode(NewsNetworkResponse.self, from: data!)
                let newsItems = news.feeds?.map { ( item: Feed) in
                    News(title: item.title ?? "",
                         description: item.description ?? "",
                         thumbnail: item.image ?? "")
                }
                if  let news = newsItems {
                    DispatchQueue.main.async {
                        self.delegate?.didUpdateNews(self, news)
                    }
                }
            } catch {
                self.delegate?.didFailWithError(error)
                return
            }
        }
        dataTask.resume()
    }
}

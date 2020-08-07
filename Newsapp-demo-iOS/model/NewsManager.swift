//
//  NewsManager.swift
//  Newsapp-demo-iOS
//
//  Created by Kapil Bhattarai on 7/29/20.
//  Copyright © 2020 Kapil Bhattarai. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift

protocol NewsManagerDelegate: AnyObject {
    func didUpdateNews(_ newsManager: NewsManager, _ news: [News])
    func didFailWithError(_ error: Error)
}
struct NewsManager {
    weak var delegate: NewsManagerDelegate?
    func fetchNews(filerBy query: String?) {
        guard let realm = try? Realm() else { return }
        var cache =  [News]()
        if query == nil {
            cache = realm.objects(News.self).toArray()
        } else {
            cache = realm.objects(News.self).filter(query!).toArray()
        }
        if cache.count > 0 || query != nil {
            self.delegate?.didUpdateNews(self, cache)
            return
        }
        guard let url =  URL(string: "\(Constants.NewsURL)") else {
            return
        }
        AF.request(url).response { (response) in
            guard let data = response.data else {return}
            do {
                let decoder = JSONDecoder()
                let news = try decoder.decode(NewsNetworkResponse.self, from: data)
                realm.beginWrite()
                realm.delete(realm.objects(News.self))
                let newsItems: [News]? = news.feeds?.map { ( item: Feed) in
                    let finalNews = News(newsTitle: item.title ?? "",
                         newsDescriptions: item.description ?? "",
                         image: item.image ?? "",
                         save: false
                    )
                    realm.add(finalNews)
                    return finalNews
                }
                do {
                try realm.commitWrite()
                } catch {
                 print("Error")
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
extension Results {
   func toArray() -> [Element] {
     return compactMap {
       $0
     }
   }
}

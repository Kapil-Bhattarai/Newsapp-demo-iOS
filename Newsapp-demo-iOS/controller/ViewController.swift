//
//  ViewController.swift
//  Newsapp-demo-iOS
//
//  Created by Kapil Bhattarai on 7/22/20.
//  Copyright © 2020 Kapil Bhattarai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var news = [News]()
    var newsManager = NewsManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        newsManager.delegate = self
        newsManager.fetchNews()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard tableView.indexPathForSelectedRow != nil else {
            return
        }
        let selectedNews = news[tableView.indexPathForSelectedRow!.row]
        let detailVc = segue.destination as? DetailNewsViewController
        detailVc?.newsItem = selectedNews
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate, NewsManagerDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(Constants.NewsCellname)",
            for: indexPath) as? NewsTableViewCell ?? NewsTableViewCell()
        cell.setCell(news: news[indexPath.row])
        return cell
    }
    func didUpdateNews(_ newsManager: NewsManager, _ news: [News]) {
        self.news = news
        tableView.reloadData()
    }
    func didFailWithError(_ error: Error) {
        print(error)
    }
}

//
//  ViewController.swift
//  Newsapp-demo-iOS
//
//  Created by Kapil Bhattarai on 7/22/20.
//  Copyright © 2020 Kapil Bhattarai. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var themeSwitch: UISwitch!
    var tabBar: UITabBar?
    var news = [News]()
    var newsManager = NewsManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(Realm.Configuration.defaultConfiguration.fileURL ?? nil)
        // Do any additional setup after loading the view.
        tabBar = self.tabBarController?.tabBar
    }
    override func viewWillAppear(_ animated: Bool) {
        let isThemeSelected = UserDefaults.standard.bool(forKey: "isDarkTheme")
        changeTheme(isDarkTheme: isThemeSelected)
        if isThemeSelected {
            themeSwitch?.isOn = true
        } else {
             themeSwitch?.isOn = false
        }
        tableView.dataSource = self
        newsManager.delegate = self
        if let restorationId = self.restorationIdentifier {
            if restorationId == "news" {
                newsManager.fetchNews(filerBy: nil)
            } else {
                newsManager.fetchNews(filerBy: "isBookMarked = true")
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard tableView.indexPathForSelectedRow != nil else {
            return
        }
        let selectedNews = news[tableView.indexPathForSelectedRow!.row]
        let detailVc = segue.destination as? DetailNewsViewController
        detailVc?.newsItem = selectedNews
    }
    @IBAction func onThemeChanged(_ sender: UISwitch) {
        changeTheme(isDarkTheme: sender.isOn)
    }
    func changeTheme(isDarkTheme: Bool = false) {
        if isDarkTheme {
            UserDefaults.standard.set(isDarkTheme, forKey: "isDarkTheme")
            overrideUserInterfaceStyle = .dark
            tabBar?.tintColor = UIColor.white
            tabBar?.barTintColor = UIColor.black
        } else {
            UserDefaults.standard.set(isDarkTheme, forKey: "isDarkTheme")
            overrideUserInterfaceStyle = .light
            tabBar?.tintColor = UIColor.black
            tabBar?.barTintColor = UIColor.white
        }
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
        cell.delegate = self
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
extension ViewController: NewsTableViewCellDelegate {
    func onBookmarkClicked(_ cell: NewsTableViewCell, _ sender: UIButton) {
        let buttonPosition = sender.convert(CGPoint.zero, to: self.tableView)
        if let indexPath = self.tableView.indexPathForRow(at: buttonPosition) {
            if let cell = self.tableView.cellForRow(at: indexPath) as? NewsTableViewCell {
                guard let realm = try? Realm() else { return }
                if news[indexPath.row].isBookMarked {
                    cell.bookmarkImage.setImage(UIImage(systemName: "bookmark"), for: .normal)
                } else {
                    cell.bookmarkImage.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
                }
                try? realm.write {
                    news[indexPath.row].isBookMarked = !news[indexPath.row].isBookMarked
                }
            }
        }
    }
}

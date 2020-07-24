//
//  ViewController.swift
//  Newsapp-demo-iOS
//
//  Created by Kapil Bhattarai on 7/22/20.
//  Copyright © 2020 Kapil Bhattarai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var osTableView: UITableView!
    
    
    var osList = [
        OperatingSystem(name :  "Mac Os", image : "apple", description : "Big Sur"),
        OperatingSystem(name :  "Windows", image : "window", description : "Windwos 10"),
        OperatingSystem(name :  "Kali Linux", image : "linux", description : "Kali 2020.2"),
        OperatingSystem(name :  "Ubuntu", image : "ubuntu", description : "Ubuntu 18.04")
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
         osTableView.dataSource = self
    }
}


extension ViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return osList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = osTableView.dequeueReusableCell(withIdentifier: "osCell") as! OsTableCell
        cell.osName.text = osList[indexPath.row].name
        cell.osImage.image = UIImage(named : osList[indexPath.row].image)
        cell.osDescription.text = osList[indexPath.row].description
        return cell
    }
}


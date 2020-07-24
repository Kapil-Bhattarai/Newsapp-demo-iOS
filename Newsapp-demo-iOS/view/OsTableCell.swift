//
//  OsTableCell.swift
//  Newsapp-demo-iOS
//
//  Created by Kapil Bhattarai on 7/24/20.
//  Copyright © 2020 Kapil Bhattarai. All rights reserved.
//

import UIKit

class OsTableCell: UITableViewCell {

    @IBOutlet weak var osDescription: UILabel!
    @IBOutlet weak var osName: UILabel!
    @IBOutlet weak var osImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

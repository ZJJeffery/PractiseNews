//
//  ZJNewsCell.swift
//  网易NEWS
//
//  Created by Jiajun Zheng on 15/5/8.
//  Copyright (c) 2015年 hgProject. All rights reserved.
//

import UIKit

class ZJNewsCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var desLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    var news : ZJNews?
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.desLabel.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.width - self.desLabel.frame.origin.x - 20
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

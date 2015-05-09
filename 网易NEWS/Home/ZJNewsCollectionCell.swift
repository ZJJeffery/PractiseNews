//
//  ZJNewsCollectionCell.swift
//  网易NEWS
//
//  Created by Jiajun Zheng on 15/5/8.
//  Copyright (c) 2015年 hgProject. All rights reserved.
//

import UIKit

class ZJNewsCollectionCell: UICollectionViewCell {
    
    var newVc : ZJNewsTableViewController?
    var channel : String?{
        willSet(tid){
            newVc?.urlString = tid
        }
    }
    
    override func awakeFromNib() {
        let sb = UIStoryboard(name: "News", bundle: nil)
        let vc = sb.instantiateInitialViewController() as! ZJNewsTableViewController
        
        newVc = vc
        vc.urlString = channel
        
        self.addSubview(vc.view)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        newVc?.view.frame = self.bounds
    }
    
}

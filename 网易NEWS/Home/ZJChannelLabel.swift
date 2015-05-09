//
//  ZJChannelLabel.swift
//  网易NEWS
//
//  Created by Jiajun Zheng on 15/5/8.
//  Copyright (c) 2015年 hgProject. All rights reserved.
//

import UIKit


class ZJChannelLabel: UILabel {

    let normalFrontSize : CGFloat = 16.0
    let selectedFrontSize : CGFloat = 18.0
    
    var scale : CGFloat?{
        didSet{
            let max = selectedFrontSize / normalFrontSize - 1.0
            let current = self.scale! * max + 1
            
            self.transform = CGAffineTransformMakeScale(current, current)
            
            self.textColor = UIColor(red: scale!, green: 0.0, blue: 0.0, alpha: 1.0)
        }
    }
    class func channelLabelWithTitle(title : String) -> ZJChannelLabel{
        let model = ZJChannelLabel()
        model.text = title
        model.font = UIFont.systemFontOfSize(18)
        model.sizeToFit()
        model.font = UIFont.systemFontOfSize(16)

        model.userInteractionEnabled = true
        return model
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
    }
    
    
}

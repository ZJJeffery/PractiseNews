//
//  ZJChannelLabel.swift
//  网易NEWS
//
//  Created by Jiajun Zheng on 15/5/8.
//  Copyright (c) 2015年 hgProject. All rights reserved.
//

import UIKit

class ZJChannelLabel: UILabel {
    static let normalFrontSize : CGFloat = 16.0
    static let selectedFrontSize : CGFloat = 18.0
    
    class func channelLabelWithTitle(title : String) -> ZJChannelLabel{
        let model = ZJChannelLabel()
        model.text = title
        model.font = UIFont.systemFontOfSize(selectedFrontSize)
        model.sizeToFit()
        model.font = UIFont.systemFontOfSize(normalFrontSize)
        
        model.userInteractionEnabled = true
        return model
        
    }
    
    
}

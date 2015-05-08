//
//  ZJChannel.swift
//  网易NEWS
//
//  Created by Jiajun Zheng on 15/5/8.
//  Copyright (c) 2015年 hgProject. All rights reserved.
//

import UIKit

class ZJChannel: NSObject {
    var tname : String?
    var tid : String?
    
    class func channles() -> NSArray {
        let url = NSBundle.mainBundle().URLForResource("topic_news.json", withExtension: nil)
        let data = NSData(contentsOfURL: url!)
        let dict = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.allZeros, error: nil) as! NSDictionary
        let array = dict[dict.keyEnumerator().nextObject() as! NSString] as! NSArray
        
        let arrayM = NSMutableArray()
        for var i = 0; i<array.count; i++ {
            let dic = array[i] as! NSDictionary
            let channel = ZJChannel.channleWithDic(dic)
            arrayM.addObject(channel)
        }
        return arrayM.copy() as! NSArray
        
    }
    
    class func channleWithDic(dic : NSDictionary) -> ZJChannel {
        let model = ZJChannel()
        model.tname = dic["tname"] as? String
        let tid = dic["tid"] as? String
        model.tid = tid?.stringByAppendingString("/0-20.html")
        return model
    }
    
}

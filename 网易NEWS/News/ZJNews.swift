//
//  ZJNews.swift
//  网易NEWS
//
//  Created by Jiajun Zheng on 15/5/7.
//  Copyright (c) 2015年 hgProject. All rights reserved.
//

import UIKit

class ZJNews: NSObject {
    
    var title : String?
    var digest : String?
    var replyCount : NSInteger?
    var imgsrc : String?
    
    class func newsWithDict(let dict: NSDictionary) -> ZJNews {
        var new = ZJNews()
        new.title = dict["title"] as? String
        new.digest = dict["digest"] as? String
        new.replyCount = dict["replyCount"] as? NSInteger
        new.imgsrc = dict["imgsrc"] as? String
        return new
    }
    
    class func newsList(let string : NSString, finished:(array: NSArray)-> Void) {
        let baseUrlPath = "http://c.m.163.com/nc/article/headline/"
        let urlString = baseUrlPath.stringByAppendingPathComponent(string as String)
        let url = NSURL(string: urlString)
        let request = NSURLRequest(URL: url!)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (_, data, error) -> Void in
            
            let result = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.allZeros, error: nil) as! NSDictionary
            let array = result[result.keyEnumerator().nextObject() as! NSString] as! NSArray
        
            var arrayM = NSMutableArray()
            array.enumerateObjectsUsingBlock({ (dic, index, stop) -> Void in
                
                let model = ZJNews.newsWithDict(dic as! NSDictionary)
                arrayM .addObject(model)
            })
            
            finished(array: arrayM)
    }
    
    
    }
}

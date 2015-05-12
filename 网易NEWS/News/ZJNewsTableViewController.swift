//
//  ZJNewsTableViewController.swift
//  网易NEWS
//
//  Created by Jiajun Zheng on 15/5/7.
//  Copyright (c) 2015年 hgProject. All rights reserved.
//

import UIKit
import Kingfisher

class ZJNewsTableViewController: UITableViewController {

   
    // 用于传递不同的数据更新不同的新闻类型
    var urlString : String?{
        didSet{
            if urlString != nil {
                ZJNews.newsList(urlString!, finished: { (array) -> Void in
                    self.dataList = array
                    self.tableView.reloadData()
                })
            }
        }
    }
    
    var dataList : NSArray?
    
//    lazy var imgCache : NSCache = {
//        return NSCache()
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.

        return self.dataList?.count ?? 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! ZJNewsCell
        let news = self.dataList![indexPath.row] as? ZJNews
        if news != nil {
            cell.titleLabel.text = news!.title!
            cell.desLabel.text = news!.digest!
            if news?.replyCount == nil {
                cell.countLabel.text = "0"
            }else{
                cell.countLabel.text = "\(news!.replyCount!)"
            }
            
            var url = NSURL(string: news!.imgsrc! as String)

            let pimg = UIImage(named: "contentview_image_default")
            
            cell.imgView.kf_setImageWithURL(url!, placeholderImage: pimg)
        }

        return cell
    }

}

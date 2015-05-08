//
//  ZJNewsTableViewController.swift
//  网易NEWS
//
//  Created by Jiajun Zheng on 15/5/7.
//  Copyright (c) 2015年 hgProject. All rights reserved.
//

import UIKit


class ZJNewsTableViewController: UITableViewController {

   
    // 用于传递不同的数据更新不同的新闻类型
    var urlString : String?{
        willSet(urlString){
            if urlString != nil {
                ZJNews.newsList(urlString!, finished: { (array) -> Void in
                    self.dataList = array
                    self.tableView.reloadData()
                })
            }
        }
    }
    
    var dataList : NSArray?
    
    var imgCache : NSCache?
    
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
        if(self.dataList == nil)
        {
            return 0
        }
        return self.dataList!.count
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
            cell.imgView.image = UIImage(named: "contentview_image_default")
            var url = NSURL(string: news!.imgsrc! as String)
            
            // 从缓存获取图片
            if self.imgCache?.objectForKey(url!) != nil {
                cell.imgView.image = self.imgCache?.objectForKey(url!) as? UIImage
                return cell
            }
            // 无缓存从网络获取
            dispatch_async(dispatch_get_global_queue(0, 0), { () -> Void in
                var dataImg = NSData(contentsOfURL: url!)
                var img = UIImage(data: dataImg!)
                self.imgCache?.setObject(img!, forKey: url!)
                cell.imgView.image = img
                self.tableView .reloadData()
            })
            
        }

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}

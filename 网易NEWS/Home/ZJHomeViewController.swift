//
//  ZJHomeViewController.swift
//  网易NEWS
//
//  Created by Jiajun Zheng on 15/5/8.
//  Copyright (c) 2015年 hgProject. All rights reserved.
//

import UIKit

class ZJHomeViewController: UIViewController, UICollectionViewDataSource {

    
    @IBOutlet weak var titleView: UIScrollView!
    

    @IBOutlet weak var newsView: UICollectionView!
    
    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    
    var currentLabelNumber = 0
    
    lazy var channels : NSArray? = {
        
        return ZJChannel.channles()
    }()
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //部署collectView的布局属性
        self.layoutFlow()
    }
    
    func layoutFlow(){
        
        self.layout.itemSize = self.newsView.frame.size
        self.layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        self.layout.minimumInteritemSpacing = 0
        self.layout.minimumLineSpacing = 0
        self.newsView.pagingEnabled = true
        self.newsView.showsHorizontalScrollIndicator = false
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setChannelLabels()
    }

    func setChannelLabels(){
        self.automaticallyAdjustsScrollViewInsets = false
        
        let margin : CGFloat = 8.0
        var x = margin
        let h = self.titleView.bounds.size.height
        
        var index = 0
        for var i = 0; i<self.channels!.count; i++ {
            let channel = self.channels![i] as! ZJChannel
            let model = ZJChannelLabel.channelLabelWithTitle(channel.tname!) as ZJChannelLabel
            model.frame = CGRect(x: x, y: 0, width: model.bounds.size.width, height: h)
            model.tag = i
            x = model.bounds.size.width + x
            
            self.titleView.addSubview(model)
            
        }
        
        // 设置contentSize
        self.titleView.contentSize = CGSizeMake(x + margin, h)
        
        let currentLabel = self.titleView.subviews[self.currentLabelNumber] as! ZJChannelLabel
        currentLabel.scale = 1.0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - CollectionView 数据源方法
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.channels!.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = self.newsView.dequeueReusableCellWithReuseIdentifier("News", forIndexPath: indexPath) as! ZJNewsCollectionCell
        if indexPath.row % 2 == 1 {
            cell.backgroundColor = UIColor.redColor()
        } else {
            cell.backgroundColor = UIColor.blueColor()
        }
        let channel = self.channels![indexPath.row] as! ZJChannel
        
        let childArrays = self.childViewControllers as NSArray
        if !childArrays.containsObject(cell.newVc!) {
            self.addChildViewController(cell.newVc!)
        }
        
        cell.channel = channel.tid
        
        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ZJHomeViewController : UICollectionViewDelegate {

    func scrollViewDidScroll(scrollView: UIScrollView) {
        var currentLabel = self.titleView.subviews[self.currentLabelNumber] as! ZJChannelLabel
        var nextLabel : ZJChannelLabel?
        
        for path in self.newsView.indexPathsForVisibleItems(){
            if path.item != self.currentLabelNumber {
                nextLabel = self.titleView.subviews[path.item] as? ZJChannelLabel
                break
            }
        }
        
        if nextLabel == nil{
            return
        }
        
        
        
        var scale : CGFloat = abs(scrollView.contentOffset.x / scrollView.frame.size.width - (CGFloat)(self.currentLabelNumber))
        
        nextLabel!.scale = scale
        currentLabel.scale = 1.0 - scale
        
        println("\(scale)" + "\(1.0 - scale)")
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        self.currentLabelNumber = (Int)(scrollView.contentOffset.x / scrollView.frame.size.width)
    }
}


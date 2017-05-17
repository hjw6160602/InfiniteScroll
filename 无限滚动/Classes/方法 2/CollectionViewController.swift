//
//  CollectionViewController.swift
//  无限滚动
//
//  Created by shoule on 16/4/25.
//  Copyright © 2016年 SaiDicaprio. All rights reserved.
//

import UIKit

private let MaxSections = 3
private let timeInterval:NSTimeInterval = 2

class CollectionViewController: UIViewController {
    let MidSection = MaxSections / 2
    var numberOfPages = 1
    var timer = NSTimer()
    
    let pageControl = UIPageControl()
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionHeight: NSLayoutConstraint!
    
    var currentPage = 0 {
        didSet{
            pageControl.currentPage = currentPage
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initStatusBar()
        initControls()
    }
    
    /** 初始化 statusBar */
    private func initStatusBar(){
        let statusBarCover = UIView(frame: CGRect(x:0, y:0, width:SCREEN_WIDTH, height:20))
        statusBarCover.backgroundColor = UIColor.blackColor()
        view.addSubview(statusBarCover)
    }
    
    private func initControls(){
        collectionHeight.constant = SCREEN_WIDTH / aspectRatio
        
        //1. 注册cell
        collectionView.registerNib(UINib(nibName: "AdvertisingCell", bundle: nil), forCellWithReuseIdentifier:"AdvertisingCell")
        
        collectionView.scrollToItemAtIndexPath(NSIndexPath(forRow: 0, inSection: MaxSections/2), atScrollPosition: UICollectionViewScrollPosition.Left, animated: true)

        //2. 设置pageControl
        pageControl.numberOfPages = ImgCount
        pageControl.centerX = view.centerX
        pageControl.y = collectionHeight.constant - 20
        view.addSubview(pageControl)
        
        //3. 定时器
        addTimer()
    }
    
    private func addTimer(){
        timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: #selector(CollectionViewController.nextPage), userInfo: nil, repeats: true)
        // 主线程在处理其他时间的时候也处理自动滚动
        NSRunLoop.mainRunLoop() .addTimer(timer, forMode: NSRunLoopCommonModes)
    }
    
    @objc private func nextPage(){
        // 下面这个方法取出在屏幕上可见的collectionView的可见items数组
        let lastVisibleIndexPath = collectionView!.indexPathsForVisibleItems().last
        // 拿到当前滚动所在的indexPath
        if let lastVisibleIndexPath = lastVisibleIndexPath {
            
            // 将item滚动到下一页
            var next = nextIndexPath(lastVisibleIndexPath)
            
            // 发现下一页的section和最中间section不等 并且下一页不是第一页
            if next.section != MidSection && next.row != 0{//那么就
                let restetdIndexPath = NSIndexPath(item: currentPage, section: MidSection)
                collectionView!.scrollToItem(at: restetdIndexPath, at: .left, animated: false)
                next.section = MidSection
                print("before:\(restetdIndexPath.section).\(restetdIndexPath.row)")
            }
            
            collectionView!.scrollToItem(at: next, at: .left, animated: true)
            print("after:\(next.section).\(next.row)")
            // 滚动完毕，当前页面+1
            currentPage = (currentPage + 1) % numberOfPages
            //            print("last:\(lastVisibleIndexPath.row) current:\(currentPage)")
            if lastVisibleIndexPath.row != (currentPage - 1){
                guard (lastVisibleIndexPath.row % (numberOfPages-1)) == 0 else {
                    print("日了狗!\nlast:\(lastVisibleIndexPath.row) current:\(currentPage)")
                    fatalError()
                }
            }
        }
    }
        
    /// nextIndexPath
    /// - Parameter indexPath: 传入一个IndexPath
    /// - Returns: 返回下一个即将要滚动到的IndexPath
    private func nextIndexPath(indexPath:NSIndexPath) -> NSIndexPath{
        var next = indexPath
        next.row += 1;
        if indexPath.row == (numberOfPages - 1) {
            next.row = 0;
            next.section += 1
        }
        //        print("section:\(next.section) row:\(next.row)")
        return next
    }
        

    //MARK: - 懒加载
    private lazy var imgArr:[UIImage] = {
        var imgArray = [UIImage]()
        for index in 0..<ImgCount {
            let imgName = "page\(index)"
            imgArray.append(UIImage(named:imgName)!)
        }
        return imgArray
    }()
}

//MARK: - <UICollectionViewDataSource>
extension CollectionViewController: UICollectionViewDataSource{
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return MaxSections
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArr.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("AdvertisingCell", forIndexPath: indexPath) as! AdvertisingCell
        
        cell.imgView.image = self.imgArr[indexPath.item];
        return cell;
    }
}

extension CollectionViewController: UICollectionViewDelegate{
    /** 调整CollectionViewCell的Size */
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize{
        return CGSizeMake(SCREEN_WIDTH, collectionHeight.constant)
    }
    
    // OC版 的函数：
    //- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
}

//MARK: - <UIScrollViewDelegate>
extension CollectionViewController: UIScrollViewDelegate{
    /** 当用户即将拖拽的时候就会调用 */
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.timer.invalidate()
    }
    
    /** 当用户停止拖拽的时候就会调用 */
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        addTimer()
    }
    
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        // 算出当前page
        currentPage = Int(Float(scrollView.contentOffset.x / scrollView.width) + 0.5) % numberOfPages
    }
    
    
}


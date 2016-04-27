//
//  CollectionViewController.swift
//  无限滚动
//
//  Created by shoule on 16/4/25.
//  Copyright © 2016年 SaiDicaprio. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {
    
    let MaxSections = 3
    var currentPage = 0
    var timer = NSTimer()
    
    let pageControl = UIPageControl()
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionHeight: NSLayoutConstraint!
    
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
        timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "nextPage", userInfo: nil, repeats: true)
        // 主线程在处理其他时间的时候也处理自动滚动
        NSRunLoop.mainRunLoop() .addTimer(timer, forMode: NSRunLoopCommonModes)
    }
    
    private func removeTimer(){
        self.timer.invalidate()
    }
    
    func nextPage(){
        //只要定时器一开始，进入当前方法，就拿到当前滚动所在的indexPath,然后偷偷将item滚动到最中间的组
        resetScrollIndexPath()
        
        var Offset = collectionView.contentOffset
        Offset.x += SCREEN_WIDTH;
        print(Offset.x)
        
        currentPage = (currentPage+1) % ImgCount
        
        collectionView.setContentOffset(Offset, animated: true)
    }
    
    private func resetScrollIndexPath(){
        // 下面这个方法取出在屏幕上可见的collectionView的可见items数组
        let currentIndexPath = collectionView.indexPathsForVisibleItems().last!
        if currentIndexPath.row != currentPage{
            print("日了狗！")
        }
//        print("currentIndexPath : section \(currentIndexPath.section),row \(currentIndexPath.row),")
        let restetdIndexPath = NSIndexPath(forItem: currentPage, inSection: MaxSections/2)
//        print("restetdIndexPath : section \(restetdIndexPath.section),row \(restetdIndexPath.row),")
        collectionView.scrollToItemAtIndexPath(restetdIndexPath, atScrollPosition: UICollectionViewScrollPosition.Left, animated: false)
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
        removeTimer()
    }
    
    /** 当用户停止拖拽的时候就会调用 */
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addTimer()
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // 算出当前的页数
        let page = Int(scrollView.contentOffset.x / scrollView.width + 0.5) % imgArr.count
        currentPage = page
        pageControl.currentPage = currentPage
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        print("currentPage:\(currentPage)")
        resetScrollIndexPath()
    }
}


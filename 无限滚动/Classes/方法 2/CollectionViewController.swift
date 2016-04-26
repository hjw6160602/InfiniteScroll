//
//  CollectionViewController.swift
//  无限滚动
//
//  Created by shoule on 16/4/25.
//  Copyright © 2016年 SaiDicaprio. All rights reserved.
//

import UIKit



class CollectionViewController: UIViewController {
    
    let MaxSections = 100
    var currentPage = 1
    var isInteraction = false
    let pageControl = UIPageControl()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initControls()
    }
    
    private func initControls(){
        // 注册cell
        collectionView.registerNib(UINib(nibName: "AdvertisingCell", bundle: nil), forCellWithReuseIdentifier:"AdvertisingCell")
        
        collectionView.scrollToItemAtIndexPath(NSIndexPath(forRow: 0, inSection: MaxSections/2), atScrollPosition: UICollectionViewScrollPosition.Left, animated: true)
        
        pageControl.numberOfPages = ImgCount
        pageControl.centerX = view.centerX
        pageControl.y = imgHeight - 20
        view.addSubview(pageControl)
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

//MARK: - <UIScrollViewDelegate>
extension CollectionViewController: UIScrollViewDelegate{
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        isInteraction = true
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        isInteraction = false
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        var page = Int(scrollView.contentOffset.x / SCREEN_WIDTH) - (5 * MaxSections/2)

        if page < 0{
            page = page % ImgCount
            if page != 0 {
                page += ImgCount
            }
        }
        else{
            page = page % ImgCount
        }
        currentPage = page
        print("currentPage :\(currentPage)")

        pageControl.currentPage = currentPage
    }
    
    
    
}


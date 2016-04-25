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
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 注册cell
        collectionView.registerNib(UINib(nibName: "AdvertisingCell", bundle: nil), forCellWithReuseIdentifier:"AdvertisingCell")
        
//        collectionView.scrollToItemAtIndexPath(NSIndexPath(forRow: 0, inSection: MaxSections/2), atScrollPosition: UICollectionViewScrollPosition.Left, animated: true)
    }
    
    //MARK: - 懒加载
    private lazy var imgArr:[UIImage] = {
        var imgArray = [UIImage]()
        for index in 0..<5 {
            let imgName = "page\(index)"
            imgArray.append(UIImage(named:imgName)!)
        }
        return imgArray
    }()
}

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
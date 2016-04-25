//
//  ViewController.swift
//  无限滚动
//
//  Created by shoule on 16/4/25.
//  Copyright © 2016年 SaiDicaprio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    let SCREEN_WIDTH  = UIScreen.mainScreen().bounds.width
    let imgHeight:CGFloat = 317
    let pageControl = UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initControls()
    }
    
    //MARK: - Inits
    private func initControls(){
        
        view.addSubview(scrollView)
        //比数组个数 多出 2 
        //用来将 数组中最后一张图片放到第一张的位置，第一张图片放到最后位置，造成视觉上的循环
        let contentWidth = CGFloat(imgArr.count + 2) * SCREEN_WIDTH
        scrollView.contentSize = CGSizeMake(contentWidth, 0)
        scrollView.contentOffset.x = SCREEN_WIDTH
        
        //遍历广告数组将数组中的模型取出，并根据数组的个数设置scrollView的大小，然后放上图片显示出来
        for i in 0..<imgArr.count{
            let imgView = imgArr[i]
            let x =  SCREEN_WIDTH * CGFloat(i + 1)
            imgView.frame = CGRectMake(x, 0, SCREEN_WIDTH, imgHeight)
            scrollView.addSubview(imgView)
        }
        
        // 将最后一张图片弄到第一张的位置 注意：这里必须新建一个imageView而不能直接从原来的数组中取
        let lastImgView = UIImageView(image: UIImage(named: "page4"))
        lastImgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, imgHeight)
        scrollView.addSubview(lastImgView)
        
        // 将第一张图片放到最后位置，造成视觉上的循环
        let firstImgView = UIImageView(image: UIImage(named: "page0"))
        let imgViewX = SCREEN_WIDTH * CGFloat(imgArr.count + 1)
        firstImgView.frame = CGRectMake(imgViewX, 0, SCREEN_WIDTH, imgHeight)
        scrollView.addSubview(firstImgView)
        
        pageControl.numberOfPages = 5
        pageControl.centerX = view.centerX
        pageControl.y = imgHeight
        view.addSubview(pageControl)
    }
    
    //MARK: - 懒加载
    private lazy var imgArr:[UIImageView] = {
        var imgArray = [UIImageView]()
        for index in 0..<5 {
            let imgName = "page\(index)"
            let img = UIImage(named:imgName)
            let imgView = UIImageView(image: img)
            imgView.contentMode = UIViewContentMode.ScaleAspectFill;
            imgArray.append(imgView)
        }
        return imgArray
    }()
}

//MARK: - <UIScrollViewDelegate>
extension ViewController: UIScrollViewDelegate{
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let OffsetX = scrollView.contentOffset.x
        let currentPage = Int(OffsetX/SCREEN_WIDTH)
        
        // 如果当前页是第0页就跳转到数组中最后一个地方进行跳转
        if currentPage == 0 {
            scrollView.contentOffset = CGPointMake(SCREEN_WIDTH * CGFloat(imgArr.count), 0)
        } else if currentPage == imgArr.count + 1 {
            // 如果是第最后一页就跳转到数组第一个元素的地点
            scrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0)
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let page = scrollView.contentOffset.x / SCREEN_WIDTH
        var currentPage = Int(page + 0.5)
        
        // 如果当前页是第0页就是第5页
        if currentPage == 0 {
            currentPage = 5
        }// 如果是第最后一页就是第一页
        
        if currentPage == imgArr.count + 1 {
            currentPage = 1
        }
        print("CurrentPage :\(currentPage)")
        pageControl.currentPage = currentPage-1
    }
}


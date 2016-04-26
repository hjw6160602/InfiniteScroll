//
//  Const.swift
//  学龄宝Swift
//
//  Created by shoule on 15/9/23.
//  Copyright © 2015年 SaiDicaprio. All rights reserved.
//

import Foundation
import UIKit

// MARK: - 功能性函数

//随机色
let HJWRandomColor = HJWColor (Int(arc4random_uniform(256)), Int(arc4random_uniform(256)), Int(arc4random_uniform(256)))

func HJWColor(R:Int, _ G:Int, _ B:Int) -> UIColor{
    let red   :CGFloat = CGFloat(R)/255.0
    let green :CGFloat = CGFloat(G)/255.0
    let blue  :CGFloat = CGFloat(B)/255.0
    return UIColor(red: red, green: green, blue: blue, alpha: 1)
}

// MARK: - 全局需要的简写宏
/** 屏幕宽高 */
let SCREEN_FRAME  = UIScreen.mainScreen().bounds
let SCREEN_HEIGHT = UIScreen.mainScreen().bounds.height
let SCREEN_WIDTH  = UIScreen.mainScreen().bounds.width

let INCH3_0       = SCREEN_WIDTH==320 && SCREEN_HEIGHT==480
let INCH4_0       = SCREEN_WIDTH==320 && SCREEN_HEIGHT==568
let INCH4_7       = SCREEN_WIDTH==375 && SCREEN_HEIGHT==667
let INCH5_5       = SCREEN_WIDTH==414 && SCREEN_HEIGHT==736

let NaviBar_H: CGFloat   = 64
let TabBar_H : CGFloat   = 49
let StatusBar_H: CGFloat = 20

/** 全局单例 [NSUserDefaults standardUserDefaults] */
let USER_DEFAULT  = NSUserDefaults.standardUserDefaults()
/** 通知中心 */
let NOTI_CENTER   = NSNotificationCenter.defaultCenter()
/** KeyWindow [UIApplication sharedApplication].keyWindow */
let KEY_WINDOW    = UIApplication.sharedApplication().keyWindow
/** 沙盒缓存路径 */
let DOC_PATH      = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
/** 手机的UUID */
let iPhone_UUID   = UIDevice.currentDevice().identifierForVendor?.UUIDString
/** 主Bundle */
let MAIN_BUNDLE   = NSBundle.mainBundle()

// MARK: - 项目相关 图片总数
let ImgCount = 5
let aspectRatio:CGFloat = 1.183

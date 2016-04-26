//
//  AdvertisingCell.swift
//  无限滚动
//
//  Created by shoule on 16/4/25.
//  Copyright © 2016年 SaiDicaprio. All rights reserved.
//

import UIKit

class AdvertisingCell: UICollectionViewCell {
    
    var cellHeight:CGFloat?
    
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.cellHeight = SCREEN_WIDTH / aspectRatio
//        print(self.height)
    }

}

//
//  IFCollectionViewCell.m
//  IFScrollRefreshDemo
//
//  Created by liuwy on 16/9/23.
//  Copyright © 2016年 MetYourMakers. All rights reserved.
//

#import "IFCollectionViewCell.h"

@implementation IFCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){

    }
    return self;
}

- (void)setImage:(UIImage *)image{
    _image = image;
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:self.bounds];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    imgView.image = self.image;
    [self addSubview:imgView];
}

@end

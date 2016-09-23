//  
//  UIView+Extension.m
//  IFScrollRefreshDemo
//
//  Created by SaiDicaprio. on 16/9/22.
//  Copyright © 2016年 SaiDicaprio. All rights reserved.
//

#import "UIView+IFExtension.h"

@implementation UIView (IFExtension)

- (void)setIf_x:(CGFloat)if_x
{
    CGRect frame = self.frame;
    frame.origin.x = if_x;
    self.frame = frame;
}

- (CGFloat)if_x
{
    return self.frame.origin.x;
}

- (void)setIf_y:(CGFloat)if_y
{
    CGRect frame = self.frame;
    frame.origin.y = if_y;
    self.frame = frame;
}

- (CGFloat)if_y
{
    return self.frame.origin.y;
}

- (void)setIf_w:(CGFloat)if_w
{
    CGRect frame = self.frame;
    frame.size.width = if_w;
    self.frame = frame;
}

- (CGFloat)if_w
{
    return self.frame.size.width;
}

- (void)setIf_h:(CGFloat)if_h
{
    CGRect frame = self.frame;
    frame.size.height = if_h;
    self.frame = frame;
}

- (CGFloat)if_h
{
    return self.frame.size.height;
}

- (void)setIf_size:(CGSize)if_size
{
    CGRect frame = self.frame;
    frame.size = if_size;
    self.frame = frame;
}

- (CGSize)if_size
{
    return self.frame.size;
}

- (void)setIf_origin:(CGPoint)if_origin
{
    CGRect frame = self.frame;
    frame.origin = if_origin;
    self.frame = frame;
}

- (CGPoint)if_origin
{
    return self.frame.origin;
}
@end

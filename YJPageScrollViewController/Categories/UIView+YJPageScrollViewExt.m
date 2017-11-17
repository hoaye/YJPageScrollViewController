//
//  UIView+YJPageScrollViewExt.m
//  YJPageScrollViewControllerDemo
//
//  Created by YJHou on 2017/11/16.
//  Copyright © 2017年 https://github.com/stackhou. All rights reserved.
//

#import "UIView+YJPageScrollViewExt.h"

@implementation UIView (YJPageScrollViewExt)

- (void)setYj_x:(CGFloat)yj_x{
    CGRect frame = self.frame;
    frame.origin.x = yj_x;
    self.frame = frame;
}

- (CGFloat)yj_x{
    return self.frame.origin.x;
}

- (void)setYj_y:(CGFloat)yj_y{
    CGRect frame = self.frame;
    frame.origin.y = yj_y;
    self.frame = frame;
}

- (CGFloat)yj_y{
    return self.frame.origin.y;
}

- (void)setYj_width:(CGFloat)yj_width{
    CGRect frame = self.frame;
    frame.size.width = yj_width;
    self.frame = frame;
}

- (CGFloat)yj_width{
    return self.frame.size.width;
}

- (void)setYj_height:(CGFloat)yj_height{
    CGRect frame = self.frame;
    frame.size.height = yj_height;
    self.frame = frame;
}

- (CGFloat)yj_height{
    return self.frame.size.height;
}

- (void)removeAllSubviews{
    while (self.subviews.count) {
        UIView *child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

@end

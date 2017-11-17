//
//  UIView+YJPageScrollViewExt.h
//  YJPageScrollViewControllerDemo
//
//  Created by YJHou on 2017/11/16.
//  Copyright © 2017年 https://github.com/stackhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YJPageScrollViewExt)

@property (nonatomic, assign) CGFloat yj_x;

@property (nonatomic, assign) CGFloat yj_y;

@property (nonatomic, assign) CGFloat yj_width;

@property (nonatomic, assign) CGFloat yj_height;

- (void)removeAllSubviews;

@end

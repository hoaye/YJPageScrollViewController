//
//  UIViewController+YJPageScrollViewExt.h
//  YJPageScrollViewControllerDemo
//
//  Created by YJHou on 2017/11/16.
//  Copyright © 2017年 https://github.com/stackhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YJPageScrollViewController;
@interface UIViewController (YJPageScrollViewExt)

/**
 子类直接获取

 @return YJPageScrollViewController
 */
- (YJPageScrollViewController *)yjPageScrollViewController;

@end

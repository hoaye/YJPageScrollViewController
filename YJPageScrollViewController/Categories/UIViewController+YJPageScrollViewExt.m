//
//  UIViewController+YJPageScrollViewExt.m
//  YJPageScrollViewControllerDemo
//
//  Created by YJHou on 2017/11/16.
//  Copyright © 2017年 https://github.com/stackhou. All rights reserved.
//

#import "UIViewController+YJPageScrollViewExt.h"
#import "YJPageScrollViewController.h"

@implementation UIViewController (YJPageScrollViewExt)

- (YJPageScrollViewController *)yjPageScrollViewController{
    
    if (self.parentViewController && [self.parentViewController isKindOfClass:[YJPageScrollViewController class]]) {
        return (YJPageScrollViewController *)self.parentViewController;
    }
    return nil;
}

@end

//
//  YJPageScrollHeaderView.m
//  YJPageScrollViewControllerDemo
//
//  Created by YJHou on 2017/11/16.
//  Copyright © 2017年 https://github.com/stackhou. All rights reserved.
//

#import "YJPageScrollHeaderView.h"

@implementation YJPageScrollHeaderView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if (self.delegate && [self.delegate respondsToSelector:@selector(yjPageScrollHeaderViewHitTest:)]) {
        [self.delegate yjPageScrollHeaderViewHitTest:!CGRectContainsPoint(self.frame, point)];
    }
    return [super hitTest:point withEvent:event];
}


@end

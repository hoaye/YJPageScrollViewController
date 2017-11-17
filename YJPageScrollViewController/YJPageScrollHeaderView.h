//
//  YJPageScrollHeaderView.h
//  YJPageScrollViewControllerDemo
//
//  Created by YJHou on 2017/11/16.
//  Copyright © 2017年 https://github.com/stackhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YJPageScrollHeaderViewDelegate <NSObject>

- (void)yjPageScrollHeaderViewHitTest:(BOOL)showGestureBegin;

@end

@interface YJPageScrollHeaderView : UIView

@property (nonatomic, weak) id<YJPageScrollHeaderViewDelegate> delegate; /**< 代理 */

@end

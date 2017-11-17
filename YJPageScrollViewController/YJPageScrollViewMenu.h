//
//  YJPageScrollViewMenu.h
//  YJPageScrollViewControllerDemo
//
//  Created by YJHou on 2017/11/16.
//  Copyright © 2017年 https://github.com/stackhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJPageScrollViewMenuTool.h"

@protocol YJPageScrollViewMenuDelegate <NSObject>

@optional
- (void)pageScrollViewMenuItemOnClick:(UILabel *)label index:(NSInteger)index;

- (void)pageScrollViewMenuAddButtonAction:(UIButton *)button;

@end

@interface YJPageScrollViewMenu : UIView

@property (nonatomic, strong) NSArray *titlesArray; /**< 标题数组 */

@property (nonatomic, strong) YJPageScrollViewMenuTool *configration;
@property (nonatomic, weak) id<YJPageScrollViewMenuDelegate> delegate;

+ (instancetype)new UNAVAILABLE_ATTRIBUTE;
- (instancetype)init UNAVAILABLE_ATTRIBUTE;

+ (instancetype)pageScrollViewMenuWithFrame:(CGRect)frame titles:(NSArray *)titlesArray Configration:(YJPageScrollViewMenuTool *)configration delegate:(id)delegate currentIndex:(NSInteger)currentIndex;

- (void)adjustItemPositionWithCurrentIndex:(NSInteger)index;
- (void)adjustItemWithProgress:(CGFloat)progress lastIndex:(NSInteger)lastIndex currentIndex:(NSInteger)currentIndex;
- (void)selectedItemIndex:(NSInteger)index animated:(BOOL)animated;
- (void)adjustItemWithAnimated:(BOOL)animated;

@end

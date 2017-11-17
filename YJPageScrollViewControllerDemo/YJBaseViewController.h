//
//  YJBaseViewController.h
//  YJPageScrollViewControllerDemo
//
//  Created by YJHou on 2017/11/17.
//  Copyright © 2017年 https://github.com/stackhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJBaseViewController : UIViewController <UITableViewDataSource , UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSNumber *siteId; /**< id*/

@end

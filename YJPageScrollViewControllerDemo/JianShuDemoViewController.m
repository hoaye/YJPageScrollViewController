//
//  JianShuDemoViewController.m
//  YJPageScrollViewControllerDemo
//
//  Created by YJHou on 2017/11/17.
//  Copyright © 2017年 https://github.com/stackhou. All rights reserved.
//

#import "JianShuDemoViewController.h"
#import <MJRefresh.h>

@interface JianShuDemoViewController ()

@property (nonatomic, strong)  UIView *lineView;

@end

@implementation JianShuDemoViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    self.title = @"Demo";
    
    [self.navigationController.navigationBar setBackgroundImage:[self createImageWithColor:[UIColor redColor]] forBarMetrics:UIBarMetricsDefault];

}

- (void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
//    [self.scrollViewMenu addSubview:self.lineView];
}

- (UIView *)lineView {
    
    if (!_lineView) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(10, self.scrollViewMenu.frame.size.height - 3, self.scrollViewMenu.frame.size.width - 20, 3)];
        _lineView = lineView;
        _lineView.backgroundColor = [UIColor orangeColor];
    }
    return _lineView;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage *)createImageWithColor:(UIColor *)color{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end

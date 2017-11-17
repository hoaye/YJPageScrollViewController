//
//  ViewController.m
//  YJPageScrollViewControllerDemo
//
//  Created by YJHou on 2017/11/16.
//  Copyright © 2017年 https://github.com/stackhou. All rights reserved.
//

#import "ViewController.h"
#import "JianShuDemoViewController.h"
#import "YJTextViewController.h"
#import "MJRefresh.h"
#import "YJBannerView.h"
#import <YJCommonMacro.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface ViewController () <YJPageScrollViewControllerDataSource, YJPageScrollViewControllerDelegate, YJBannerViewDataSource, YJBannerViewDelegate>

@property (nonatomic, strong) YJBannerView *bannerView; /**< banner */

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-  (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UIViewController *vc = [self getJianShuDemoViewController];
    [self.navigationController pushViewController:vc animated:YES];
}

//简书Demo
- (UIViewController *)getJianShuDemoViewController{
    //配置信息
    YJPageScrollViewMenuTool *configration = [[YJPageScrollViewMenuTool alloc]init];
    configration.scrollViewBackgroundColor = [UIColor redColor];
    configration.itemLeftAndRightMargin = 10;
    configration.lineColor = [UIColor redColor];
    configration.lineHeight = 2;
    configration.lineLeftAndRightAddWidth = -10;//线条宽度增加
    configration.itemMaxScale = 1.0;
    configration.pageScrollViewMenuStyle = YJPageScrollViewMenuStyleSuspension;
    configration.scrollViewBackgroundColor = [UIColor whiteColor];
    configration.selectedItemColor = [UIColor redColor];
    //设置平分不滚动   默认会居中
    configration.aligmentModeCenter = YES;
    configration.scrollMenu = YES;
//    configration.showNavigation = YES;
    
    configration.showGradientColor = YES;//取消渐变
    
    JianShuDemoViewController *vc = [JianShuDemoViewController pageScrollViewControllerWithControllers:[self getViewController] titles:@[@"第一个界面",@"第二个界面",@"第三个界面",@"第四个界面",@"第五个界面",@"第六个界面",@"第七个界面",@"第八个界面",@"第九个界面"] Configration:configration];
    // 头部是否能伸缩效果   要伸缩效果就不要有下拉刷新控件 默认NO*/
    vc.HeaderViewCouldScale = NO;
        
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kYJSCREEN_WIDTH, 700)];
    [bgView addSubview:self.bannerView];
    [self.bannerView reloadData];

    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 500)];
    imageView.image = [UIImage imageNamed:@"BackGroundWithMy"];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewTap)]];
    [bgView addSubview:imageView];
    
    //头像
    UIButton *icon = [[UIButton alloc]initWithFrame:CGRectMake(150, 30, 180, 50)];
    icon.tag = 100001;
    icon.backgroundColor = [UIColor whiteColor];
    [icon setTitle:@"按钮" forState:UIControlStateNormal];
    [icon setTitle:@"按钮" forState:UIControlStateHighlighted];
    
    [icon setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [icon setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];

    [icon addTarget:self action:@selector(iconClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:icon];
    [icon addTarget:self action:@selector(iconMoveChangeAction:) forControlEvents:UIControlEventTouchDragOutside];
    [imageView addSubview:icon];
    [icon addTarget:self action:@selector(iconCancleChangeAction:) forControlEvents:UIControlEventTouchCancel];
    [imageView addSubview:icon];
    
    
    //里面有默认高度 等ScrollView的高度 //里面设置了背景颜色与tableview相同
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)];
    
    vc.pageIndex = 0;
    
    vc.placeHoderView = footerView;
    
    vc.headerView = bgView;
    
    vc.dataSource = self;
    
    //设置拉伸View
    UIImageView *imageViewScale = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 245)];
    imageViewScale.image = [UIImage imageNamed:@"BackGroundWithMy"];
    
    vc.scaleBackgroundView = imageViewScale;
    
    //设置代理 监听伸缩
    vc.delegate = self;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //        imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, 100);
        //        [vc reloadHeaderViewFrame];
    });
    
    return vc;
}

- (void)iconClickAction:(UIButton *)btn{
    NSLog(@"-->%@", @"------");
}

- (void)iconMoveChangeAction:(UIButton *)btn{

}

- (void)iconCancleChangeAction:(UIButton *)btn{
    
}

- (void)imageViewTap{
    
    NSLog(@"----- imageViewTap -----");
}

- (NSArray *)getViewController{
    
    YJTextViewController *one0 = [[YJTextViewController alloc] init];
    one0.siteId = @0;
    YJTextViewController *one1 = [[YJTextViewController alloc] init];
    one1.siteId = @1;
    YJTextViewController *one2 = [[YJTextViewController alloc] init];
    one2.siteId = @2;
    YJTextViewController *one3 = [[YJTextViewController alloc] init];
    one3.siteId = @3;
    YJTextViewController *one4 = [[YJTextViewController alloc] init];
    one4.siteId = @4;
    YJTextViewController *one5 = [[YJTextViewController alloc] init];
    one5.siteId = @5;
    YJTextViewController *one6 = [[YJTextViewController alloc] init];
    one6.siteId = @6;
    YJTextViewController *one7 = [[YJTextViewController alloc] init];
    one7.siteId = @7;
    YJTextViewController *one8 = [[YJTextViewController alloc] init];
    one8.siteId = @8;
    
    return @[one0,one1,one2,one3,one4,one5,one6,one7,one8];
}

#pragma mark - YJPageScrollViewControllerDataSource
- (UITableView *)pageScrollViewController:(YJPageScrollViewController *)pageScrollViewController scrollViewForIndex:(NSInteger)index{
    
    YJBaseViewController *VC= (YJBaseViewController *)pageScrollViewController.currentViewController;
    return [VC tableView];
    
};

- (BOOL)pageScrollViewController:(YJPageScrollViewController *)pageScrollViewController headerViewIsRefreshingForIndex:(NSInteger)index{
    
    [self.bannerView adjustBannerViewWhenViewWillAppear];
    YJBaseViewController *VC= (YJBaseViewController *)pageScrollViewController.currentViewController;
    return [[[VC tableView] mj_header ] isRefreshing];
}

- (void)pageScrollViewController:(YJPageScrollViewController *)pageScrollViewController scrollViewHeaderAndFooterEndRefreshForIndex:(NSInteger)index{
    
    YJBaseViewController *VC= pageScrollViewController.viewControllers[index];
    [[[VC tableView] mj_header] endRefreshing];
    [[[VC tableView] mj_footer] endRefreshing];
}

#pragma mark - YPageScrollViewDelegate
/** 伸缩开始结束监听*/
- (void)pageScrollViewController:(YJPageScrollViewController *)pageScrollViewController
      scrollViewHeaderScaleState:(BOOL)isStart {
    //这里处理方式不是特别好
    //1.在开始的时候需要手动隐藏背景图片,反之,相反.
    
    UIImageView *imageView =  (UIImageView *)pageScrollViewController.headerView;
    if (isStart) {
        imageView.image = nil;
    }else{
        imageView.image = [UIImage imageNamed:@"mine_header_bg"];
    }
}

/** 伸缩位置contentOffset*/
- (void)pageScrollViewController:(YJPageScrollViewController *)pageScrollViewController
scrollViewHeaderScaleContentOffset:(CGFloat)contentOffset {
//    NSLog(@"contentOffset : %f",contentOffset);
}

- (YJBannerView *)bannerView{
    if (!_bannerView) {
        _bannerView = [YJBannerView bannerViewWithFrame:CGRectMake(0, 0, kYJSCREEN_WIDTH, 200) dataSource:self delegate:self placeholderImageName:@"" selectorString:@"sd_setImageWithURL:placeholderImage:"];
    }
    return _bannerView;
}

#pragma mark - Basnner
- (NSArray *)bannerViewImages:(YJBannerView *)bannerView{
    return @[@"http://img.zcool.cn/community/01430a572eaaf76ac7255f9ca95d2b.jpg",
             @"http://img.zcool.cn/community/0137e656cc5df16ac7252ce6828afb.jpg",
             @"http://img.zcool.cn/community/01e5445654513e32f87512f6f748f0.png@900w_1l_2o_100sh.jpg",
             @"http://www.aykj.net/front/images/subBanner/baiduV2.jpg"
             ];
}

- (void)bannerView:(YJBannerView *)bannerView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"点击-->%ld", index);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

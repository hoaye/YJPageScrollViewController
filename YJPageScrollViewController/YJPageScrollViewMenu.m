//
//  YJPageScrollViewMenu.m
//  YJPageScrollViewControllerDemo
//
//  Created by YJHou on 2017/11/16.
//  Copyright © 2017年 https://github.com/stackhou. All rights reserved.
//

#import "YJPageScrollViewMenu.h"
#import "UIView+YJPageScrollViewExt.h"

#define converMarginX 5
#define converMarginW 10

@interface YJPageScrollViewMenu ()

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIView *converView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) NSMutableArray *itemsArrayM;
@property (nonatomic, strong) NSMutableArray *itemsWidthArraM;
@property (nonatomic, assign) NSInteger lastIndex;
@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation YJPageScrollViewMenu

+ (instancetype)pageScrollViewMenuWithFrame:(CGRect)frame titles:(NSArray *)titlesArray Configration:(YJPageScrollViewMenuTool *)configration delegate:(id)delegate currentIndex:(NSInteger)currentIndex{
    
    return [[YJPageScrollViewMenu alloc] initPageScrollViewMenuWithFrame:frame titles:titlesArray Configration:configration delegate:delegate currentIndex:currentIndex];
}

- (instancetype)initPageScrollViewMenuWithFrame:(CGRect)frame titles:(NSArray *)titlesArray Configration:(YJPageScrollViewMenuTool *)configration delegate:(id)delegate currentIndex:(NSInteger)currentIndex{
    
    self.currentIndex = currentIndex;
    self.titlesArray = titlesArray;
    self.configration = configration ? configration : [YJPageScrollViewMenuTool pageScrollViewMenuTool];
    self.delegate = delegate;
    if (self.configration.menuHeight > 0) {
        frame.size.height = self.configration.menuHeight;
    }
    self = [super initWithFrame:frame];
    if (self) {
        [self initMenuItems];
        [self configUI];
    }
    return self;
}

- (void)initMenuItems{
    [self.titlesArray enumerateObjectsUsingBlock:^(id  _Nonnull title, NSUInteger idx, BOOL * _Nonnull stop) {

        UILabel *itemLabel = [[UILabel alloc]init];
        itemLabel.font = self.configration.itemFont;
        itemLabel.textColor = self.configration.normalItemColor;
        itemLabel.text = title;
        itemLabel.tag = idx;
        itemLabel.textAlignment = NSTextAlignmentCenter;
        itemLabel.userInteractionEnabled = YES;
        
        [itemLabel addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(itemLabelTapOnClick:)]];
        
        CGFloat width = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : itemLabel.font} context:nil].size.width;
        
        [self.itemsWidthArraM addObject:@(width)];
        [self.itemsArrayM addObject:itemLabel];
        [self.scrollView addSubview:itemLabel];
    }];
}

- (void)configUI{
    
    self.scrollView.frame = CGRectMake(0, 0, self.configration.showAddButton ? self.yj_width - self.yj_height : self.yj_width, self.yj_height);
    [self addSubview:self.scrollView];
    
    if (self.configration.showAddButton) {
        self.addButton.frame = CGRectMake(self.yj_width - self.yj_height, 0, self.yj_height, self.yj_height);
        [self addSubview:self.addButton];
    }
    
    __block CGFloat itemX = 0;
    __block CGFloat itemY = 0;
    __block CGFloat itemW = 0;
    __block CGFloat itemH = self.yj_height - self.configration.lineHeight;
    
    [self.itemsArrayM enumerateObjectsUsingBlock:^(UILabel * _Nonnull label, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == 0) {
            itemX += self.configration.itemLeftAndRightMargin;
        }else{
            itemX += self.configration.itemMargin + [self.itemsWidthArraM[idx - 1] floatValue];
        }
        label.frame = CGRectMake(itemX, itemY, [self.itemsWidthArraM[idx] floatValue], itemH);
        
    }];
    
    CGFloat scrollSizeWidht = self.configration.itemLeftAndRightMargin + CGRectGetMaxX([[self.itemsArrayM lastObject] frame]);
    if (scrollSizeWidht < self.scrollView.yj_width) {//不超出宽度
        itemX = 0;
        itemY = 0;
        itemW = 0;
        
        CGFloat left = 0;
        for (NSNumber *width in self.itemsWidthArraM) {
            left += [width floatValue];
        }
        
        left = (self.scrollView.yj_width - left - self.configration.itemMargin * (self.itemsWidthArraM.count-1)) * 0.5;
        if (self.configration.aligmentModeCenter && left >= 0) {//居中且有剩余间距
            
            [self.itemsArrayM enumerateObjectsUsingBlock:^(UILabel  * label, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if (idx == 0) {
                    itemX += left;
                }else{
                    itemX += self.configration.itemMargin + [self.itemsWidthArraM[idx - 1] floatValue];
                }
                label.frame = CGRectMake(itemX, itemY, [self.itemsWidthArraM[idx] floatValue], itemH);
            }];
            
            self.scrollView.contentSize = CGSizeMake(left + CGRectGetMaxX([[self.itemsArrayM lastObject] frame]), self.scrollView.yj_height);
            
        }else{//否则按原来样子
            if (!self.configration.scrollMenu) {//不能滚动则平分
                [self.itemsArrayM enumerateObjectsUsingBlock:^(UILabel  * label, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    itemW = self.scrollView.yj_width / self.itemsArrayM.count;
                    itemX = itemW *idx;
                    label.frame = CGRectMake(itemX, itemY, itemW, itemH);
                }];
                self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX([[self.itemsArrayM lastObject] frame]), self.scrollView.yj_height);
            }else{
                self.scrollView.contentSize = CGSizeMake(scrollSizeWidht, self.scrollView.yj_height);
            }
        }
    }else{//大于scrollView的width·
        self.scrollView.contentSize = CGSizeMake(scrollSizeWidht, self.scrollView.yj_height);
    }
    
    CGFloat lineX = [(UILabel *)[self.itemsArrayM firstObject] yj_x];
    CGFloat lineY = self.scrollView.yj_height - self.configration.lineHeight;
    CGFloat lineW = [[self.itemsArrayM firstObject] yj_width];
    CGFloat lineH = self.configration.lineHeight;
    
    if (!self.configration.scrollMenu&&!self.configration.aligmentModeCenter&&self.configration.lineWidthEqualFontWidth) {//处理Line宽度等于字体宽度
        lineX = [(UILabel *)[self.itemsArrayM firstObject] yj_x] + ([[self.itemsArrayM firstObject] yj_width]  - ([self.itemsWidthArraM.firstObject floatValue])) / 2;
        lineW = [self.itemsWidthArraM.firstObject floatValue];
    }
    //conver
    if (self.configration.showConver) {
        
        self.converView.frame = CGRectMake(lineX - converMarginX, (self.scrollView.yj_height - self.configration.converHeight - self.configration.lineHeight) * 0.5, lineW + converMarginW, self.configration.converHeight);
        [self.scrollView insertSubview:self.converView atIndex:0];
    }
    
    if (self.configration.showScrollLine) {
        self.lineView.frame = CGRectMake(lineX - self.configration.lineLeftAndRightAddWidth, lineY - self.configration.lineBottomMargin, lineW + self.configration.lineLeftAndRightAddWidth * 2, lineH);
        [self.scrollView addSubview:self.lineView];
    }
    
    if (self.configration.itemMaxScale > 1) {
        ((UILabel *)self.itemsArrayM[0]).transform = CGAffineTransformMakeScale(self.configration.itemMaxScale, self.configration.itemMaxScale);
    }
    [self setDefaultTheme];
    [self selectedItemIndex:self.currentIndex animated:NO];
}

- (void)setDefaultTheme{
    
    UILabel *currentLabel = self.itemsArrayM[self.currentIndex];
    
    if (self.configration.itemMaxScale > 1) {
        currentLabel.transform = CGAffineTransformMakeScale(self.configration.itemMaxScale, self.configration.itemMaxScale);
    }
    currentLabel.textColor = self.configration.selectedItemColor;
    
    if (self.configration.showScrollLine) {
        self.lineView.yj_x = currentLabel.yj_x - self.configration.lineLeftAndRightAddWidth;
        self.lineView.yj_width = currentLabel.yj_width + self.configration.lineLeftAndRightAddWidth *2;
        
        if (!self.configration.scrollMenu&&!self.configration.aligmentModeCenter&&self.configration.lineWidthEqualFontWidth) {//处理Line宽度等于字体宽度
            
            self.lineView.yj_x = currentLabel.yj_x + ([currentLabel yj_width]  - ([self.itemsWidthArraM[currentLabel.tag] floatValue])) / 2 - self.configration.lineLeftAndRightAddWidth;;
            self.lineView.yj_width = [self.itemsWidthArraM[currentLabel.tag] floatValue] + self.configration.lineLeftAndRightAddWidth *2;
        }
        
    }
    
    if (self.configration.showConver) {
        self.converView.yj_x = currentLabel.yj_x - converMarginX;
        self.converView.yj_width = currentLabel.yj_width +converMarginW;
        
        if (!self.configration.scrollMenu&&!self.configration.aligmentModeCenter&&self.configration.lineWidthEqualFontWidth) {//处理conver宽度等于字体宽度
            self.converView.yj_x = currentLabel.yj_x + ([currentLabel yj_width]  - ([self.itemsWidthArraM[currentLabel.tag] floatValue])) / 2 - converMarginX;
            self.converView.yj_width = [self.itemsWidthArraM[currentLabel.tag] floatValue] + converMarginW;
        }
        
    }
    self.lastIndex = self.currentIndex;
}

#pragma mark - Action
- (void)itemLabelTapOnClick:(UITapGestureRecognizer *)tapGresture{
    
    UILabel *label = (UILabel *)tapGresture.view;
    self.currentIndex = label.tag;
    [self adjustItemWithAnimated:YES];
}

#pragma mark - Publick Method
- (void)selectedItemIndex:(NSInteger)index animated:(BOOL)animated{
    self.currentIndex = index;
    [self adjustItemAnimate:animated];
}

- (void)adjustItemWithAnimated:(BOOL)animated{
    if (self.lastIndex == self.currentIndex) return;
    [self adjustItemAnimate:animated];
}

- (void)adjustItemAnimate:(BOOL)animated{
    
    UILabel *lastLabel = self.itemsArrayM[self.lastIndex];
    UILabel *currentLabel = self.itemsArrayM[self.currentIndex];
    [UIView animateWithDuration:animated ? 0.25 : 0 animations:^{
        
        if (self.configration.itemMaxScale > 1) {
            lastLabel.transform = CGAffineTransformMakeScale(1, 1);
            currentLabel.transform = CGAffineTransformMakeScale(self.configration.itemMaxScale, self.configration.itemMaxScale);
        }
        
        [self.itemsArrayM enumerateObjectsUsingBlock:^(UILabel  * obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.textColor = self.configration.normalItemColor;
            if (idx == self.itemsArrayM.count - 1) {
                currentLabel.textColor = self.configration.selectedItemColor;
            }
        }];
        
        if (self.configration.showScrollLine) {
            self.lineView.yj_x = currentLabel.yj_x - self.configration.lineLeftAndRightAddWidth;
            self.lineView.yj_width = currentLabel.yj_width + self.configration.lineLeftAndRightAddWidth *2;
            
            if (!self.configration.scrollMenu&&!self.configration.aligmentModeCenter&&self.configration.lineWidthEqualFontWidth) {//处理Line宽度等于字体宽度
                self.lineView.yj_x = currentLabel.yj_x + ([currentLabel yj_width]  - ([self.itemsWidthArraM[currentLabel.tag] floatValue])) / 2 - self.configration.lineLeftAndRightAddWidth;;
                self.lineView.yj_width = [self.itemsWidthArraM[currentLabel.tag] floatValue] + self.configration.lineLeftAndRightAddWidth *2;
            }
        }
        
        if (self.configration.showConver) {
            self.converView.yj_x = currentLabel.yj_x - converMarginX;
            self.converView.yj_width = currentLabel.yj_width +converMarginW;
            
            if (!self.configration.scrollMenu&&!self.configration.aligmentModeCenter&&self.configration.lineWidthEqualFontWidth) {//处理conver宽度等于字体宽度
                self.converView.yj_x = currentLabel.yj_x + ([currentLabel yj_width]  - ([self.itemsWidthArraM[currentLabel.tag] floatValue])) / 2  - converMarginX;
                self.converView.yj_width = [self.itemsWidthArraM[currentLabel.tag] floatValue] +converMarginW;
            }
        }
        self.lastIndex = self.currentIndex;
    }completion:^(BOOL finished) {
        [self adjustItemPositionWithCurrentIndex:self.currentIndex];
    }];
    
    if (self.delegate &&[self.delegate respondsToSelector:@selector(pageScrollViewMenuItemOnClick:index:)]) {
        [self.delegate pageScrollViewMenuItemOnClick:currentLabel index:self.lastIndex];
    }
}

- (void)adjustItemWithProgress:(CGFloat)progress lastIndex:(NSInteger)lastIndex currentIndex:(NSInteger)currentIndex{
    self.lastIndex = lastIndex;
    self.currentIndex = currentIndex;
    
    if (lastIndex == currentIndex) return;
    UILabel *lastLabel = self.itemsArrayM[self.lastIndex];
    UILabel *currentLabel = self.itemsArrayM[self.currentIndex];
    
    if (self.configration.itemMaxScale > 1) {
        CGFloat scaleB = self.configration.itemMaxScale - self.configration.deltaScale * progress;
        CGFloat scaleS = 1 + self.configration.deltaScale * progress;
        lastLabel.transform = CGAffineTransformMakeScale(scaleB, scaleB);
        currentLabel.transform = CGAffineTransformMakeScale(scaleS, scaleS);
    }
    
    if (self.configration.showGradientColor) {
        
        [self.configration setRGBWithProgress:progress];
        
        lastLabel.textColor = [UIColor colorWithRed:self.configration.deltaNorR green:self.configration.deltaNorG blue:self.configration.deltaNorB alpha:1];
        
        currentLabel.textColor = [UIColor colorWithRed:self.configration.deltaSelR green:self.configration.deltaSelG blue:self.configration.deltaSelB alpha:1];
    }else{
        if (progress > 0.5) {
            lastLabel.textColor = self.configration.normalItemColor;
            currentLabel.textColor = self.configration.selectedItemColor;
        }else if (progress < 0.5 && progress > 0){
            lastLabel.textColor = self.configration.selectedItemColor;
            currentLabel.textColor = self.configration.normalItemColor;
        }
    }
    
    CGFloat xD = currentLabel.yj_x - lastLabel.yj_x;
    CGFloat wD = currentLabel.yj_width - lastLabel.yj_width;
    
    if (self.configration.showScrollLine) {
        self.lineView.yj_x = lastLabel.yj_x + xD *progress - self.configration.lineLeftAndRightAddWidth;
        self.lineView.yj_width = lastLabel.yj_width + wD *progress + self.configration.lineLeftAndRightAddWidth *2;
        
        if (!self.configration.scrollMenu&&!self.configration.aligmentModeCenter&&self.configration.lineWidthEqualFontWidth) {//处理Line宽度等于字体宽度
            self.lineView.yj_x = lastLabel.yj_x + ([lastLabel yj_width]  - ([self.itemsWidthArraM[lastLabel.tag] floatValue])) / 2 - self.configration.lineLeftAndRightAddWidth + xD *progress;
            self.lineView.yj_width = [self.itemsWidthArraM[lastLabel.tag] floatValue] + self.configration.lineLeftAndRightAddWidth *2 + wD *progress;
        }
    }
    
    if (self.configration.showConver) {
        self.converView.yj_x = lastLabel.yj_x + xD *progress - converMarginX;
        self.converView.yj_width = lastLabel.yj_width  + wD *progress + converMarginW;
        
        if (!self.configration.scrollMenu&&!self.configration.aligmentModeCenter&&self.configration.lineWidthEqualFontWidth) {//处理cover宽度等于字体宽度
            self.converView.yj_x = lastLabel.yj_x + ([lastLabel yj_width]  - ([self.itemsWidthArraM[lastLabel.tag] floatValue])) / 2 -  converMarginX + xD *progress;
            self.converView.yj_width = [self.itemsWidthArraM[lastLabel.tag] floatValue] + converMarginW + wD *progress;
        }
    }
}

- (void)adjustItemPositionWithCurrentIndex:(NSInteger)index{
    
    if (self.scrollView.contentSize.width != self.scrollView.yj_width + 20) {
        UILabel *label = self.itemsArrayM[index];
        CGFloat offSex = label.center.x - self.scrollView.yj_width * 0.5;
        offSex = offSex > 0 ? offSex : 0;
        CGFloat maxOffSetX = self.scrollView.contentSize.width - self.scrollView.yj_width;
        maxOffSetX = maxOffSetX > 0 ? maxOffSetX : 0;
        offSex = offSex > maxOffSetX ? maxOffSetX : offSex;
        [self.scrollView setContentOffset:CGPointMake(offSex, 0) animated:YES];
    }
}

#pragma mark - lazy
- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = self.configration.lineColor;
    }
    return _lineView;
}

- (UIView *)converView{
    
    if (!_converView) {
        _converView = [[UIView alloc] init];
        _converView.layer.backgroundColor = self.configration.converColor.CGColor;
        _converView.layer.cornerRadius = self.configration.coverCornerRadius;
        _converView.layer.masksToBounds = YES;
        _converView.userInteractionEnabled = NO;
    }
    return _converView;
}

- (UIScrollView *)scrollView{
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.pagingEnabled = NO;
        _scrollView.bounces = self.configration.bounces;
        _scrollView.backgroundColor = self.configration.scrollViewBackgroundColor;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.scrollEnabled = self.configration.scrollMenu;
    }
    return _scrollView;
}

- (UIButton *)addButton{
    if (!_addButton) {
        _addButton = [[UIButton alloc] init];
        [_addButton setBackgroundImage:[UIImage imageNamed:self.configration.addButtonNormalImageName] forState:UIControlStateNormal];
        [_addButton setBackgroundImage:[UIImage imageNamed:self.configration.addButtonHightImageName] forState:UIControlStateHighlighted];
        _addButton.layer.shadowColor = [UIColor grayColor].CGColor;
        _addButton.layer.shadowOffset = CGSizeMake(-1, 0);
        _addButton.layer.shadowOpacity = 0.5;
        _addButton.backgroundColor = self.configration.addButtonBackgroundColor;
        [_addButton addTarget:self action:@selector(addButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}

#pragma mark -  addButtonAction
- (void)addButtonAction:(UIButton *)button{
    if(self.delegate && [self.delegate respondsToSelector:@selector(pageScrollViewMenuAddButtonAction:)]){
        [self.delegate pageScrollViewMenuAddButtonAction:button];
    }
}
- (NSMutableArray *)itemsArrayM{
    if (!_itemsArrayM) {
        _itemsArrayM = [[NSMutableArray alloc] initWithCapacity:self.titlesArray.count];
    }
    return _itemsArrayM;
}

- (NSMutableArray *)itemsWidthArraM{
    if (!_itemsWidthArraM) {
        _itemsWidthArraM = [[NSMutableArray alloc] initWithCapacity:self.titlesArray.count];
    }
    return _itemsWidthArraM;
}

@end

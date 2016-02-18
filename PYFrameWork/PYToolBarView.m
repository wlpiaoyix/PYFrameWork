//
//  PYToolBarView.m
//  PYFrameWork
//
//  Created by wlpiaoyi on 16/2/3.
//  Copyright © 2016年 wlpiaoyi. All rights reserved.
//

#import "PYToolBarView.h"
#import <Utile/Utile.Framework.h>

@interface PYToolBarView()<UIScrollViewDelegate>

@property (nonatomic, strong, nonnull) UIScrollView * scrollMenu;
@property (nonatomic) CGFloat widthButton;
@property (nonatomic) CGFloat offsetPer;

@end

@implementation PYToolBarView
-(instancetype) init{
    if (self = [super init]) {
        self.scrollMenu = [UIScrollView new];
        self.scrollMenu.backgroundColor = [UIColor clearColor];
        self.scrollMenu.delegate = self;
        self.scrollMenu.showsHorizontalScrollIndicator = NO;
        self.scrollMenu.showsVerticalScrollIndicator = NO;
        [self addSubview:self.scrollMenu];
        self.offsetPer = 0;
        self.maxShow = 4;
    }
    return self;
}
-(void) setButtonMenus:(NSArray<PYButton *> *)buttonMenus{
    
    _buttonMenus = buttonMenus;
    
    for (UIView * view in [self.scrollMenu subviews]) {
        [view removeFromSuperview];
    }
    
    for (PYButton * button in self.buttonMenus) {
        [self.scrollMenu addSubview:button];
    }
    
    self.widthButton = 0;
}
-(void) setMaxShow:(NSUInteger)maxShow{
    _maxShow = maxShow;
    
    if (_maxShow == 0) {
        return;
    }
    
    if (!self.buttonMenus || ![self.buttonMenus count]) {
        return;
    }
    
    CGFloat widthButton = self.frame.size.width / MIN([self.buttonMenus count], _maxShow);
    if (((NSInteger)widthButton) == ((NSInteger)self.widthButton)) {
        return;
    }
    
    self.widthButton = widthButton;
    self.scrollMenu.contentSize = CGSizeMake(widthButton * [self.buttonMenus count], self.frame.size.height);
    self.scrollMenu.frame = self.bounds;
    
    NSInteger index = 0;
    for (PYButton * button in self.buttonMenus) {
        button.frame = CGRectMake(index * self.widthButton, 0, self.widthButton, self.frame.size.height);
        index ++;
    }
    [self.scrollMenu setContentOffset:CGPointMake(self.offsetPer * self.scrollMenu.contentSize.width, 0)];
    
}
-(void) layoutSubviews{
    self.maxShow = self.maxShow;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if(decelerate) return;
    [self scrollViewDidEndDecelerating:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.offsetPer = scrollView.contentOffset.x / scrollView.contentSize.width;
    
}

@end

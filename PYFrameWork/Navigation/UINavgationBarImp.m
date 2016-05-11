//
//  UINavgationBarImp.m
//  PYFrameWork
//
//  Created by wlpiaoyi on 16/2/17.
//  Copyright © 2016年 wlpiaoyi. All rights reserved.
//

#import "UINavgationBarImp.h"
#import <Utile/PYUtile.h>
#import <Utile/PYHook.h>
#import <Utile/UIView+Expand.h>
#import <Utile/PYViewAutolayoutCenter.h>
@interface UINavgationBarImp()
@property (nonatomic, strong) PYNavigationBarTools * ntbTools;
@end

@implementation UINavgationBarImp

+(void) initialize{
    
    [PYHook mergeHookInstanceWithTarget:[UINavigationController class] action:@selector(setToolbarHidden:animated:) blockBefore:^BOOL(NSInvocation * _Nonnull invoction) {
        return true;
    } blockAfter:^(NSInvocation * _Nonnull invoction) {
        [UINavgationBarImp checkRootViewWithVc:invoction.target];
    }];
    
}
-(instancetype) init{
    if (self = [super init]) {
        self.ntbTools = [PYNavigationBarTools new];
    }
    return self;
}
-(void) beforeExcuteViewWillAppear:(nonnull BOOL *) isExcute target:(nonnull UIViewController *) target{
    (*isExcute) = true;
}
-(void) afterExcuteViewWillAppearWithTarget:(nonnull UIViewController *) target{
    
    if (!target.navigationController) {
        return;
    }
    
    [target.navigationController setNavigationBarHidden:NO];
    if (IOS7_OR_LATER) {
        [[UIApplication sharedApplication] setStatusBarStyle:[target preferredStatusBarStyle]];
    }
    
    [self.ntbTools setDefaultStyle:target.navigationController.navigationBar];
    if (self.blockSetNavationBar) {
        _blockSetNavationBar(target, self.ntbTools);
    }
    
    
}

-(void) beforeExcuteViewWillLayoutSubviews:(nonnull BOOL *) isExcute target:(nonnull UIViewController *) target{
    (*isExcute) = true;
}
-(void) afterExcuteViewWillLayoutSubviewsWithTarget:(nonnull UIViewController *) target{
    
    if (!target.navigationController) {
        return;
    }
    [UINavgationBarImp checkRootViewWithVc:target.navigationController];
    target.view.frameHeight = target.navigationController.view.frameHeight;
}

-(void) beforeExcutePreferredStatusBarStyle:(nonnull BOOL *) isExcute target:(nonnull UIViewController *) target{
    *isExcute = true;
}
-(UIStatusBarStyle) afterExcutePreferredStatusBarStyleWithTarget:(nonnull UIViewController *) target{
    return UIStatusBarStyleLightContent;
}

+(void) checkRootViewWithVc:(UINavigationController*) vc {
    
    CGRect rectNavigationBar = vc.navigationBar.frame;
    CGRect rectToolBar = vc.toolbar.frame;
    
    CGRect rectCurView = CGRectMake(0, 0, rectNavigationBar.size.width, vc.view.frame.size.height - - (vc.toolbarHidden ? 0 : rectToolBar.size.height));
    
    CGRect rectPerView = [PYUtile getCurrentController].view.frame;
    if (rectCurView.origin.x == rectPerView.origin.x && rectPerView.origin.y == rectCurView.origin.y && rectCurView.size.width == rectPerView.size.width && rectCurView.size.height == rectPerView.size.height) {
        return;
    }
    
    [PYUtile getCurrentController].view.frame = rectCurView;

}

-(void) dealloc{

}

@end

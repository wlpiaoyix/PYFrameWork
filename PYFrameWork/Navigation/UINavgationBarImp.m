//
//  UINavgationBarImp.m
//  PYFrameWork
//
//  Created by wlpiaoyi on 16/2/17.
//  Copyright © 2016年 wlpiaoyi. All rights reserved.
//

#import "UINavgationBarImp.h"
#import "PYNavigationBarTools.h"
#import <Utile/PYUtile.h>
#import <Utile/PYHook.h>

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
        
    }
    return self;
}
-(void) beforeExcuteViewDidLoad:(nonnull BOOL *) isExcute target:(nonnull UIViewController *) target{
    (*isExcute) = true;
}
-(void) afterExcuteViewDidLoadWithTarget:(nonnull UIViewController *) target{
    
    if (!target.navigationController) {
        return;
    }
    
    [[PYNavigationBarTools new] setDefaultStyle:target.navigationController.navigationBar];
    
    [target.navigationController setNavigationBarHidden:NO];
    
    if (IOS7_OR_LATER) {
        [[UIApplication sharedApplication] setStatusBarStyle:[target preferredStatusBarStyle] animated:NO];
    }
    
    if (self.blockSetNavationBar) {
        _blockSetNavationBar(target);
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
    
    CGRect rectCurView = CGRectMake(0, rectNavigationBar.origin.y + rectNavigationBar.size.height, rectNavigationBar.size.width, vc.view.frame.size.height - rectNavigationBar.origin.y - rectNavigationBar.size.height - (vc.toolbarHidden ? 0 : rectToolBar.size.height));
    
    CGRect rectPerView = [PYUtile getCurrentController].view.frame;
    if (rectCurView.origin.x == rectPerView.origin.x && rectPerView.origin.y == rectCurView.origin.y && rectCurView.size.width == rectPerView.size.width && rectCurView.size.height == rectPerView.size.height) {
        return;
    }
    
    [PYUtile getCurrentController].view.frame = rectCurView;

}

@end

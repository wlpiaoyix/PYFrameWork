//
//  PYViewControllerLoadedOrientationImp.m
//  PYFrameWork
//
//  Created by wlpiaoyi on 16/2/2.
//  Copyright © 2016年 wlpiaoyi. All rights reserved.
//

#import "PYViewControllerLoadedOrientationImp.h"
#import "UIViewController(piofo).h"
#import <Utile/PYOrientationListener.h>



@implementation PYViewControllerLoadedOrientationImp

-(void) beforeExcuteViewDidLoad:(nonnull BOOL *) isExcute target:(nonnull UIViewController *) target{
    *isExcute = true;
}
-(void) afterExcuteViewDidLoadWithTarget:(nonnull UIViewController *) target{
    target.currentInterfaceOrientation = UIDeviceOrientationUnknown;
}

-(void) beforeExcuteViewWillAppear:(nonnull BOOL *) isExcute target:(nonnull UIViewController *) target{
    *isExcute = true;
}

-(void) afterExcuteViewWillAppearWithTarget:(nonnull UIViewController *) target{
    if ([target shouldAutorotate]) {
        UIDeviceOrientation orientation = UIDeviceOrientationUnknown;
        UIInterfaceOrientation currentInterfaceOrientation = [target preferredInterfaceOrientationForPresentation];
        if (target.currentInterfaceOrientation != UIDeviceOrientationUnknown) {
            currentInterfaceOrientation = target.currentInterfaceOrientation;
        }
        switch (currentInterfaceOrientation) {
            case UIInterfaceOrientationPortrait:{
                orientation = UIDeviceOrientationPortrait;
            }
                break;
            case UIInterfaceOrientationLandscapeLeft:{
                orientation = UIDeviceOrientationLandscapeLeft;
            }
                break;
            case UIInterfaceOrientationLandscapeRight:{
                orientation = UIDeviceOrientationLandscapeRight;
            }
                break;
            case UIInterfaceOrientationPortraitUpsideDown:{
                orientation = UIDeviceOrientationPortraitUpsideDown;
            }
                break;
            default:
                break;
        }
        if ([PYOrientationListener isSupportOrientation:orientation targetController:target]) {
            [[PYOrientationListener instanceSingle] attemptRotationToDeviceOrientation:orientation completion:self.blockCompletion];
        }
    }
}


/**
 是否支持旋转到当前方向
 */
+(BOOL) isSupportOrientation:(UIDeviceOrientation) orientation targetController:(nonnull UIViewController *) targetController{
    
    UIInterfaceOrientationMask supportedOrientations = [[UIApplication sharedApplication].keyWindow.rootViewController supportedInterfaceOrientations];
    
    NSInteger currentOrientation = 1 << (orientation - 1);
    if (!(supportedOrientations & currentOrientation)) {
        return false;
    }
    
    supportedOrientations = [targetController supportedInterfaceOrientations];
    if (!(supportedOrientations & currentOrientation)) {
        return false;
    }
    
    return true;
}

//-(void) beforeExcuteViewDidAppear:(nonnull BOOL *) isExcute target:(nonnull UIViewController *) target{
//    *isExcute = true;
//}
//
//-(void) afterExcuteViewDidAppearWithTarget:(nonnull UIViewController *) target{
//}
//
//-(void) beforeExcuteViewWillDisappear:(nonnull BOOL *) isExcute target:(nonnull UIViewController *) target{
//    *isExcute = true;
//}
//
//-(void) afterExcuteViewWillDisappearWithTarget:(nonnull UIViewController *) target{
//}
//
//-(void) beforeExcuteViewDidDisappear:(nonnull BOOL *) isExcute target:(nonnull UIViewController *) target{
//    *isExcute = true;
//}
//
//-(void) afterExcuteViewDidDisappearWithTarget:(nonnull UIViewController *) target{
//}
//
//-(void) beforeExcuteViewDidLayoutSubviews:(nonnull BOOL *) isExcute target:(nonnull UIViewController *) target{
//    *isExcute = true;
//}
//
//-(void) afterExcuteViewDidLayoutSubviewsWithTarget:(nonnull UIViewController *) target{
//}

@end

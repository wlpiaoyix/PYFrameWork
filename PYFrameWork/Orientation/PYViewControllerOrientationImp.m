//
//  PYViewControllerOrientationImp.m
//  PYFrameWork
//
//  Created by wlpiaoyi on 16/2/2.
//  Copyright © 2016年 wlpiaoyi. All rights reserved.
//

#import "PYViewControllerOrientationImp.h"
#import "UIViewController(piofo).h"
#import <Utile/PYOrientationListener.h>
#import <Utile/PYUtile.h>

@implementation PYViewControllerOrientationImp
-(instancetype) init{
    if (self = [super init]) {
        self.supportedInterface = UIInterfaceOrientationMaskAllButUpsideDown;
        self.preferredInterfaceOrientation = UIInterfaceOrientationPortrait;
    }
    return self;
}
//重写父类方法判断是否可以旋转
-(void) beforeExcuteShouldAutorotate:(nonnull BOOL *) isExcute target:(nonnull UIViewController *) target{
    *isExcute = true;
}
-(BOOL) aftlerExcuteShouldAutorotateWithTarget:(nonnull UIViewController *) target{
    
    if ([target isKindOfClass:[UINavigationController class]]) {
        UIViewController *vc = ((UINavigationController*)target).viewControllers.lastObject;
        return [vc shouldAutorotate];
    }
    return true;
}

//重写父类方法判断支持的旋转方向
-(void) beforeExcuteSupportedInterfaceOrientations:(nonnull BOOL *) isExcute target:(nonnull UIViewController *) target{
    *isExcute = true;
}
-(NSUInteger) afterExcuteSupportedInterfaceOrientationsWithTarget:(nonnull UIViewController *) target{
    if ([target isKindOfClass:[UINavigationController class]]) {
        UIViewController *vc = ((UINavigationController*)target).viewControllers.lastObject;
        return [vc supportedInterfaceOrientations];
    }
    return self.supportedInterface;
}

//重写父类方法返回当前方向
-(void) beforeExcutePreferredInterfaceOrientationForPresentation:(nonnull BOOL *) isExcute target:(nonnull UIViewController *) target{
    *isExcute = false;
}
-(UIInterfaceOrientation) afterExcutePreferredInterfaceOrientationForPresentationWithTarget:(nonnull UIViewController *) target{
    if ([target isKindOfClass:[UINavigationController class]]) {
        UIViewController *vc = ((UINavigationController*)target).viewControllers.lastObject;
        return [vc preferredInterfaceOrientationForPresentation];
    }
    return self.preferredInterfaceOrientation;
}

//⇒ 重写父类方法旋转开始和结束
-(void) beforeExcuteWillRotateToInterfaceOrientation:(UIInterfaceOrientation) toInterfaceOrientation duration:(NSTimeInterval)duration isExcute:(nonnull BOOL *) isExcute target:(nonnull UIViewController *) target{
    *isExcute = false;
}
-(void) afterExcuteWillRotateToInterfaceOrientation:(UIInterfaceOrientation) toInterfaceOrientation duration:(NSTimeInterval)duration target:(nonnull UIViewController *) target{
    if ([target isKindOfClass:[UINavigationController class]]) {
        UIViewController *vc = [PYUtile getCurrentController];
        [vc willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
        return;
    }
    self.timeIntervalOrientation = [NSDate timeIntervalSinceReferenceDate];
    
    UIDeviceOrientation orientation = UIDeviceOrientationUnknown;
    switch (toInterfaceOrientation) {
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
    
    if ([PYOrientationListener isSupportOrientation:orientation  targetController:target]) {
        target.currentInterfaceOrientation = toInterfaceOrientation;
    }
}

-(void) beforeExcuteDidRotateFromInterfaceOrientation:(UIInterfaceOrientation) fromInterfaceOrientation isExcute:(nonnull BOOL *) isExcute target:(nonnull UIViewController *) target{
}
-(void) afterExcuteDidRotateFromInterfaceOrientation:(UIInterfaceOrientation) fromInterfaceOrientation target:(nonnull UIViewController *) target{
    if ([target isKindOfClass:[UINavigationController class]]) {
        UIViewController *vc = ((UINavigationController*)target).viewControllers.lastObject;
        [vc didRotateFromInterfaceOrientation:fromInterfaceOrientation];
        return;
    }
    self.timeIntervalOrientation = [NSDate timeIntervalSinceReferenceDate] - self.timeIntervalOrientation;
    [PYOrientationListener instanceSingle].duration = self.timeIntervalOrientation;
}
@end

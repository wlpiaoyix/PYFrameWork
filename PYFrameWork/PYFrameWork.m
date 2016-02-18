//
//  PYFrameWork.m
//  PYFrameWork
//
//  Created by wlpiaoyi on 16/1/20.
//  Copyright © 2016年 wlpiaoyi. All rights reserved.
//

#import "PYFrameWork.h"
#import "PYViewControllerLoadedOrientationImp.h"
#import "PYViewControllerOrientationImp.h"
#import "UINavigationControllerMenusImp.h"
#import "UINavgationBarImp.h"



static id<UIViewcontrollerHookOrientationDelegate>xPYViewControllerOrientationImp;
static id<UIViewcontrollerHookViewDelegate> xPYViewControllerLoadedOrientationImp;

static id<UIViewcontrollerHookViewDelegate> xUINavigationControllerMenusImp;

static id<UIViewcontrollerHookViewDelegate> xUINavigationBarImp;

@implementation PYFrameWork

+(void) initialize{
    [UIViewController hookMethodOrientation];
    [UIViewController hookMethodView];
}

+(void) orientationWithSupportedInterface:(NSUInteger) supportedInterface preferredInterfaceOrientation:(UIInterfaceOrientation) preferredInterfaceOrientation{
    
    xPYViewControllerOrientationImp =[PYViewControllerOrientationImp new];
    ((PYViewControllerOrientationImp *)xPYViewControllerLoadedOrientationImp).supportedInterface = supportedInterface;
    ((PYViewControllerOrientationImp *)xPYViewControllerLoadedOrientationImp).preferredInterfaceOrientation = preferredInterfaceOrientation;
    
    xPYViewControllerLoadedOrientationImp = [PYViewControllerLoadedOrientationImp new];
    
    [UIViewController addDelegateOrientation:xPYViewControllerOrientationImp];
    [UIViewController addDelegateView:xPYViewControllerLoadedOrientationImp];
    
}

+(void) toolBarWithMenusInfo:(NSArray<NSDictionary<NSString *, NSString *> *> * _Nonnull)menusInfo menusAction:(NSDictionary<NSNumber *,NSDictionary<NSString *,NSString *> *> * _Nonnull)menusAction{
    xUINavigationControllerMenusImp =[UINavigationControllerMenusImp new];
    [UIViewController addDelegateView:xUINavigationControllerMenusImp];

    ((UINavigationControllerMenusImp*)xUINavigationControllerMenusImp).menusInfo = menusInfo;
    ((UINavigationControllerMenusImp*)xUINavigationControllerMenusImp).menusAction = menusAction;
}

+(void) navigatonBarWithBlock:(void (^_Nonnull) (UIViewController * _Nonnull curVc, PYNavigationBarTools * _Nonnull ntbTools)) blok{
    xUINavigationBarImp = [UINavgationBarImp new];
    ((UINavgationBarImp*)xUINavigationBarImp).blockSetNavationBar = blok;
    [UIViewController addDelegateView:xUINavigationBarImp];
}

@end




//
//  PYFrameWork.h
//  PYFrameWork
//
//  Created by wlpiaoyi on 16/1/20.
//  Copyright © 2016年 wlpiaoyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PYFrameWorkParam.h"
#import "PYNavigationBarTools.h"

@interface PYFrameWork : NSObject

+(void) orientationWithSupportedInterface:(NSUInteger) supportedInterface preferredInterfaceOrientation:(UIInterfaceOrientation) preferredInterfaceOrientation;

+(void) toolBarWithMenusInfo:(NSArray<NSDictionary<NSString *, NSString *> *> * _Nonnull)menusInfo menusAction:(NSDictionary<NSNumber *,NSDictionary<NSString *,NSString *> *> * _Nonnull)menusAction;

+(void) navigatonBarWithBlock:(void (^_Nonnull) (UIViewController * _Nonnull curVc, PYNavigationBarTools * _Nonnull ntbTools)) blok;

@end

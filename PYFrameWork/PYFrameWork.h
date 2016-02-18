//
//  PYFrameWork.h
//  PYFrameWork
//
//  Created by wlpiaoyi on 16/1/20.
//  Copyright © 2016年 wlpiaoyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PYFrameWorkParam.h"

@interface PYFrameWork : NSObject

+(void) orientationWithSupportedInterface:(NSUInteger) supportedInterface preferredInterfaceOrientation:(UIInterfaceOrientation) preferredInterfaceOrientation;

+(void) toolBarWithMenusInfo:(NSArray<NSDictionary<NSString *, NSString *> *> *)menusInfo menusAction:(NSDictionary<NSNumber *,NSDictionary<NSString *,NSString *> *> *)menusAction;

+(void) navigatonBar;

@end

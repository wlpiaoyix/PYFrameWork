//
//  UINavigationControllerMenusImp.h
//  PYFrameWork
//
//  Created by wlpiaoyi on 16/2/3.
//  Copyright © 2016年 wlpiaoyi. All rights reserved.
//

#import "UIViewController+HookView.h"
#import "PYFrameWorkParam.h"

@interface UINavigationControllerMenusImp : NSObject<UIViewcontrollerHookViewDelegate>

@property (nonatomic) NSUInteger showIndex;

@property (nonatomic, copy, nullable) NSDictionary<NSNumber *, NSDictionary<NSString *, id> *> * menusAction;

@property (nonatomic, copy, nullable) NSArray<NSDictionary<NSString *, NSString *> *> * menusInfo;
@end

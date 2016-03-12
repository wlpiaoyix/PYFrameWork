//
//  UINavgationBarImp.h
//  PYFrameWork
//
//  Created by wlpiaoyi on 16/2/17.
//  Copyright © 2016年 wlpiaoyi. All rights reserved.
//

#import "UIViewController+HookView.h"
#import "PYNavigationBarTools.h"

@interface UINavgationBarImp : NSObject<UIViewcontrollerHookViewDelegate>
@property (nonatomic, copy, nullable) void (^blockSetNavationBar) (UIViewController * _Nonnull curVc, PYNavigationBarTools * _Nonnull ntbTools);
@end

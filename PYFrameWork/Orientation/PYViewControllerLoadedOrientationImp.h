//
//  PYViewControllerLoadedOrientationImp.h
//  PYFrameWork
//
//  Created by wlpiaoyi on 16/2/2.
//  Copyright © 2016年 wlpiaoyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Utile/UIViewController+HookView.h>
/**
 UIViewController 加载成功后检查旋转
 */
@interface PYViewControllerLoadedOrientationImp : NSObject<UIViewcontrollerHookViewDelegate>
/**
 旋转成功后的回调
 */
@property (nonatomic, copy, nullable) void (^blockCompletion)(void);

@end

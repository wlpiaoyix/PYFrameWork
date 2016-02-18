//
//  PYViewControllerOrientationImp.h
//  PYFrameWork
//
//  Created by wlpiaoyi on 16/2/2.
//  Copyright © 2016年 wlpiaoyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Utile/UIViewController+HookOrientation.h>

@interface PYViewControllerOrientationImp : NSObject<UIViewcontrollerHookOrientationDelegate>
@property (nonatomic) NSTimeInterval timeIntervalOrientation;
@property (nonatomic) NSUInteger supportedInterface;
@property (nonatomic) UIInterfaceOrientation preferredInterfaceOrientation;
@end

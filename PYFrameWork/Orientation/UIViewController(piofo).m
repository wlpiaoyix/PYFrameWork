//
//  UIViewController(piofo).m
//  PYFrameWork
//
//  Created by wlpiaoyi on 16/2/2.
//  Copyright © 2016年 wlpiaoyi. All rights reserved.
//

#import "UIViewController(piofo).h"
#import <objc/runtime.h>


void * preferredInterfaceOrientationForPresentationPointer;

@implementation UIViewController(piofo)

-(UIInterfaceOrientation) currentInterfaceOrientation{
    NSNumber * number = objc_getAssociatedObject(self, &preferredInterfaceOrientationForPresentationPointer);
    return [number integerValue];
}
-(void) setCurrentInterfaceOrientation:(UIInterfaceOrientation)currentInterfaceOrientation{
    objc_setAssociatedObject(self, &preferredInterfaceOrientationForPresentationPointer, @(currentInterfaceOrientation), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

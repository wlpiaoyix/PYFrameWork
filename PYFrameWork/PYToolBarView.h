//
//  PYToolBarView.h
//  PYFrameWork
//
//  Created by wlpiaoyi on 16/2/3.
//  Copyright © 2016年 wlpiaoyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PYButton.h"

@interface PYToolBarView : UIView

@property (nonatomic, strong, nullable) NSArray<PYButton *> * buttonMenus;

@property (nonatomic) NSUInteger maxShow;

@end

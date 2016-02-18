//
//  PYNavigationBarTools.h
//  PYFrameWork
//
//  Created by wlpiaoyi on 16/2/3.
//  Copyright © 2016年 wlpiaoyi. All rights reserved.
//

#import <UIKit/UIKit.h>

extern CGSize GlobleNavigationBarShadowOffset;

extern UIColor * _Nonnull GlobleNavigationBarShadowColor;
extern UIColor * _Nonnull GlobleNavigationBarTitleColor;
extern UIColor * _Nonnull GlobleNavigationBarTintColor;

extern UIFont * _Nonnull GlobleNavigationBarTitleFont;

@interface PYNavigationBarTools : NSObject
/**
 删除style
 */
-(void) removeStyle:(nonnull UINavigationBar *) navigationBar;
/**
 设置默认的style
 */
-(void) setDefaultStyle:(nonnull UINavigationBar *) navigationBar;

/*>>========================各个属性的设置==========================*/
-(nonnull instancetype) setShadowColor:(nonnull UIColor *) color navigationBar:(nonnull UINavigationBar *) navigationBar;
-(nonnull instancetype) setShadowOffset:(CGSize) offset navigationBar:(nonnull UINavigationBar *) navigationBar;
-(nonnull instancetype) setTitleColor:(nonnull UIColor *) color navigationBar:(nonnull UINavigationBar *) navigationBar;
-(nonnull instancetype) setTitleFont:(nonnull UIFont *) font navigationBar:(nonnull UINavigationBar *) navigationBar;
-(nonnull instancetype) setBackgourndColor:(nonnull UIColor *) color navigationBar:(nonnull UINavigationBar *) navigationBar;
-(nonnull instancetype) setBackgourndImage:(nonnull UIImage *) image navigationBar:(nonnull UINavigationBar *) navigationBar;
/*========================各个属性的设置==========================<<*/
@end

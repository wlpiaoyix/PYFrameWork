//
//  PYNavigationBarTools.m
//  PYFrameWork
//
//  Created by wlpiaoyi on 16/2/3.
//  Copyright © 2016年 wlpiaoyi. All rights reserved.
//

#import "PYNavigationBarTools.h"
#import <Utile/UIImage+Expand.h>

CGSize GlobleNavigationBarShadowOffset;

UIColor *GlobleNavigationBarShadowColor;
UIColor *GlobleNavigationBarTitleColor;
UIColor *GlobleNavigationBarBackgroundColor;;
UIColor *GlobleNavigationBarTintColor;

UIFont *GlobleNavigationBarTitleFont;

@implementation PYNavigationBarTools
+(void) initialize{
    
    GlobleNavigationBarShadowOffset = CGSizeMake(1, 1);
    
    GlobleNavigationBarTitleColor = [UIColor whiteColor];
    GlobleNavigationBarShadowColor = [UIColor grayColor];
    GlobleNavigationBarBackgroundColor = [UIColor colorWithRed:0.008 green:0.392 blue:0.878 alpha:1];
    GlobleNavigationBarTintColor = [UIColor whiteColor];
    
    GlobleNavigationBarTitleFont = [UIFont systemFontOfSize:16];
}

/**
 删除style
 */
-(void) removeStyle:(nonnull UINavigationBar *) navigationBar{
    [navigationBar setTitleTextAttributes:@{}];
    [navigationBar setTintColor:[UIColor clearColor]];
    [self setBackgourndColor:[UIColor clearColor] navigationBar:navigationBar];
}

/**
 设置默认的style
 */
-(void) setDefaultStyle:(nonnull UINavigationBar *) navigationBar{
    
    NSMutableDictionary *titleTextAttributes = [NSMutableDictionary dictionaryWithDictionary:[navigationBar titleTextAttributes]];
    
    NSShadow *shadow = titleTextAttributes[NSShadowAttributeName];
    if (!shadow) {
        shadow = [[NSShadow alloc] init];
        shadow.shadowOffset = GlobleNavigationBarShadowOffset;
    }
    shadow.shadowColor = GlobleNavigationBarShadowColor;
    titleTextAttributes[NSShadowAttributeName] = shadow;
    titleTextAttributes[NSForegroundColorAttributeName] = GlobleNavigationBarTitleColor;
    titleTextAttributes[NSFontAttributeName] = GlobleNavigationBarTitleFont;
    
    [navigationBar setTitleTextAttributes:titleTextAttributes];
    
    [navigationBar setTintColor:GlobleNavigationBarTintColor];
    
    [self setBackgourndColor:GlobleNavigationBarBackgroundColor navigationBar:navigationBar];
}

/*>>========================各个属性的设置==========================*/
-(nonnull instancetype) setShadowColor:(nonnull UIColor *) color navigationBar:(nonnull UINavigationBar *) navigationBar{
    
    NSMutableDictionary *titleTextAttributes = [NSMutableDictionary dictionaryWithDictionary:[navigationBar titleTextAttributes]];
    
    NSShadow *shadow = titleTextAttributes[NSShadowAttributeName];
    if (!shadow) {
        shadow = [[NSShadow alloc] init];
        shadow.shadowOffset = GlobleNavigationBarShadowOffset;
    }
    
    shadow.shadowColor = color;
    titleTextAttributes[NSShadowAttributeName] = shadow;
    
    [navigationBar setTitleTextAttributes:titleTextAttributes];
    
    return self;
}
-(nonnull instancetype) setShadowOffset:(CGSize) offset navigationBar:(nonnull UINavigationBar *) navigationBar{
    
    NSMutableDictionary *titleTextAttributes = [NSMutableDictionary dictionaryWithDictionary:[navigationBar titleTextAttributes]];
    
    NSShadow *shadow = titleTextAttributes[NSShadowAttributeName];
    if (!shadow) {
        shadow = [[NSShadow alloc] init];
        shadow.shadowColor = GlobleNavigationBarShadowColor;
    }
    shadow.shadowOffset = offset;
    titleTextAttributes[NSShadowAttributeName] = shadow;
    
    [navigationBar setTitleTextAttributes:titleTextAttributes];
    
    return self;
}
-(nonnull instancetype) setTitleColor:(nonnull UIColor *) color navigationBar:(nonnull UINavigationBar *) navigationBar{
    
    NSMutableDictionary *titleTextAttributes = [NSMutableDictionary dictionaryWithDictionary:[navigationBar titleTextAttributes]];
    titleTextAttributes[NSForegroundColorAttributeName] = color;
    
    [navigationBar setTitleTextAttributes:titleTextAttributes];
    
    return self;
}
-(nonnull instancetype) setTitleFont:(nonnull UIFont *) font navigationBar:(nonnull UINavigationBar *) navigationBar{
    
    NSMutableDictionary *titleTextAttributes = [NSMutableDictionary dictionaryWithDictionary:[navigationBar titleTextAttributes]];
    titleTextAttributes[NSFontAttributeName] = font;
    
    [navigationBar setTitleTextAttributes:titleTextAttributes];
    
    return self;
}
-(nonnull instancetype) setBackgourndColor:(nonnull UIColor *) color navigationBar:(nonnull UINavigationBar *) navigationBar{
    
    [self setBackgourndImage:[UIImage imageWithColor:color] navigationBar:navigationBar];
    
    return self;
}
-(nonnull instancetype) setBackgourndImage:(nonnull UIImage *) image navigationBar:(nonnull UINavigationBar *) navigationBar{
    
    [navigationBar setBackgroundImage:image forBarPosition:UIBarPositionTop barMetrics:UIBarMetricsDefault];
    
    return self;
}
/*========================各个属性的设置==========================<<*/

@end

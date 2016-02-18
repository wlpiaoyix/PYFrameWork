//
//  PYButton.h
//  PYFrameWork
//
//  Created by wlpiaoyi on 16/2/11.
//  Copyright © 2016年 wlpiaoyi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    PYButtonEnumNormal,
    PYButtonEnumSelected,
    PYButtonEnumHighlight,
} PYButtonEnum;

@interface PYButton : UIView
@property (nonatomic) NSUInteger index;
@property (nonatomic) PYButtonEnum status;
@property (nonatomic) NSUInteger notifyNum;
@property (nonatomic, strong, nonnull) UIFont * fontText;

-(void) setBgImage:(nullable UIImage *) image status:(PYButtonEnum) status;
-(void) setImage:(nullable UIImage *) image status:(PYButtonEnum) status;
-(void) setTitle:(nullable NSString *) title status:(PYButtonEnum) status;
-(void) setColor:(nullable UIColor *) color status:(PYButtonEnum) status;

-(void) addTarget:(nullable id) target action:(nonnull SEL)action;

@end

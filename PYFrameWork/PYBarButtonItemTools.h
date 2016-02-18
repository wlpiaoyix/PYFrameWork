//
//  PYBarButtonItemTools.h
//  PYFrameWork
//
//  Created by wlpiaoyi on 16/2/3.
//  Copyright © 2016年 wlpiaoyi. All rights reserved.
//

#import <UIKit/UIKit.h>

extern CGSize GlobleBarButtonItemShadowOffset;

extern UIColor * _Nonnull GlobleBarButtonItemShadowColor;
extern UIColor * _Nonnull GlobleBarButtonItemNameColor;

extern UIFont * _Nonnull GlobleBarButtonItemNameFont;

@interface PYBarButtonItemTools : NSObject
@property (nonatomic) UIControlState currentState;
/**
 删除style
 */
-(void) removeStyle:(nonnull UIBarButtonItem *) barButtonItem;
/**
 设置默认的style
 */
-(void) setDefaultStyle:(nonnull UIBarButtonItem *) barButtonItem;

/*>>========================各个属性的设置==========================*/
-(nonnull instancetype) setColorShadow:(nonnull UIColor *) colorShadow Item:(nonnull UIBarButtonItem *) barButtonItem;
-(nonnull instancetype) setColorName:(nonnull UIColor *) colorName Item:(nonnull UIBarButtonItem *) barButtonItem;
-(nonnull instancetype) setOffsetShadow:(CGSize) offsetShadow Item:(nonnull UIBarButtonItem *) barButtonItem;
-(nonnull instancetype) setFontName:(nonnull UIFont *) fontName Item:(nonnull UIBarButtonItem *) barButtonItem;
/*========================各个属性的设置==========================<<*/

@end

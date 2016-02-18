//
//  PYBarButtonItemTools.m
//  PYFrameWork
//
//  Created by wlpiaoyi on 16/2/3.
//  Copyright © 2016年 wlpiaoyi. All rights reserved.
//

#import "PYBarButtonItemTools.h"

CGSize GlobleBarButtonItemShadowOffset;

UIColor * _Nonnull GlobleBarButtonItemShadowColor;
UIColor * _Nonnull GlobleBarButtonItemNameColor;

UIFont * _Nonnull GlobleBarButtonItemNameFont;

@implementation PYBarButtonItemTools

+(void) initialize{
    
    GlobleBarButtonItemShadowOffset = CGSizeMake(1, 1);
    
    GlobleBarButtonItemNameColor = [UIColor whiteColor];
    GlobleBarButtonItemShadowColor = [UIColor grayColor];
    
    GlobleBarButtonItemNameFont = [UIFont systemFontOfSize:16];
}
-(instancetype) init{
    if (self = [super init]) {
        self.currentState = UIControlStateNormal;
    }
    return self;
}
/**
 删除style
 */
-(void) removeStyle:(nonnull UIBarButtonItem *) barButtonItem{
    
    [barButtonItem setTitleTextAttributes:@{} forState:self.currentState];
    
}
/**
 设置默认的style
 */
-(void) setDefaultStyle:(nonnull UIBarButtonItem *) barButtonItem{
    
    NSMutableDictionary *titleTextAttributes = [NSMutableDictionary dictionaryWithDictionary:[barButtonItem titleTextAttributesForState:self.currentState]];
    
    NSShadow *shadow = titleTextAttributes[NSShadowAttributeName];
    if (!shadow) {
        shadow = [[NSShadow alloc] init];
        shadow.shadowOffset = GlobleBarButtonItemShadowOffset;
    }
    shadow.shadowColor = GlobleBarButtonItemShadowColor;
    titleTextAttributes[NSShadowAttributeName] = shadow;
    titleTextAttributes[NSForegroundColorAttributeName] = GlobleBarButtonItemNameColor;
    titleTextAttributes[NSFontAttributeName] = GlobleBarButtonItemNameFont;
    
    [barButtonItem setTitleTextAttributes:titleTextAttributes forState:self.currentState];
}

/*>>========================各个属性的设置==========================*/
-(nonnull instancetype) setColorShadow:(nonnull UIColor *) colorShadow Item:(nonnull UIBarButtonItem *) barButtonItem{
    
    NSMutableDictionary *titleTextAttributes = [NSMutableDictionary dictionaryWithDictionary:[barButtonItem titleTextAttributesForState:self.currentState]];
    
    NSShadow *shadow = titleTextAttributes[NSShadowAttributeName];
    if (!shadow) {
        shadow = [[NSShadow alloc] init];
        shadow.shadowOffset = GlobleBarButtonItemShadowOffset;
    }
    shadow.shadowColor = colorShadow;
    titleTextAttributes[NSShadowAttributeName] = shadow;
    
    [barButtonItem setTitleTextAttributes:titleTextAttributes forState:self.currentState];
    
    return self;
}
-(nonnull instancetype) setColorName:(nonnull UIColor *) colorName Item:(nonnull UIBarButtonItem *) barButtonItem{
    
    NSMutableDictionary *titleTextAttributes = [NSMutableDictionary dictionaryWithDictionary:[barButtonItem titleTextAttributesForState:self.currentState]];
    
    titleTextAttributes[NSForegroundColorAttributeName] = colorName;
    
    [barButtonItem setTitleTextAttributes:titleTextAttributes forState:self.currentState];
    
    return self;
}

-(nonnull instancetype) setOffsetShadow:(CGSize) offsetShadow Item:(nonnull UIBarButtonItem *) barButtonItem{
    
    NSMutableDictionary *titleTextAttributes = [NSMutableDictionary dictionaryWithDictionary:[barButtonItem titleTextAttributesForState:self.currentState]];
    
    NSShadow *shadow = titleTextAttributes[NSShadowAttributeName];
    if (!shadow) {
        shadow = [[NSShadow alloc] init];
        shadow.shadowColor = GlobleBarButtonItemShadowColor;
    }
    shadow.shadowOffset = offsetShadow;
    titleTextAttributes[NSShadowAttributeName] = shadow;
    
    [barButtonItem setTitleTextAttributes:titleTextAttributes forState:self.currentState];
    
    return self;
}

-(nonnull instancetype) setFontName:(nonnull UIFont *) fontName Item:(nonnull UIBarButtonItem *) barButtonItem{
    
    NSMutableDictionary *titleTextAttributes = [NSMutableDictionary dictionaryWithDictionary:[barButtonItem titleTextAttributesForState:self.currentState]];
    titleTextAttributes[NSFontAttributeName] = fontName;
    
    [barButtonItem setTitleTextAttributes:titleTextAttributes forState:self.currentState];
    
    return self;
}
/*========================各个属性的设置==========================<<*/
@end

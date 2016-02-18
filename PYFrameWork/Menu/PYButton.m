//
//  PYButton.m
//  PYFrameWork
//
//  Created by wlpiaoyi on 16/2/11.
//  Copyright © 2016年 wlpiaoyi. All rights reserved.
//

#import "PYButton.h"
#import <Utile/UILable+Expand.h>
#import <Utile/UIView+Expand.h>
#import <Utile/PYUtile.h>
#import <Utile/PYReflect.h>

NSString * PYButtonStatusInfoImageKey = @"df";
NSString * PYButtonStatusInfoTitleKey = @"dg";
NSString * PYButtonStatusInfoBgImageKey = @"bgi";
NSString * PYButtonStatusInfoColorKey = @"dc";

@interface PYButton()
@property (nonatomic, strong, nonnull) NSMutableDictionary<NSNumber *, NSMutableDictionary<NSString *, id> *> * dictStatusInfo;
@property (nonatomic, strong, nonnull) UILabel * lableTitle;
@property (nonatomic, strong, nonnull) UIImageView * imageShow;
@property (nonatomic, strong, nonnull) UIImageView * imageBg;

@property (nonatomic, strong, nonnull) NSMutableDictionary<NSString *, NSLayoutConstraint *> * dictContaints;

@property (nonatomic, assign, nullable) id target;
@property (nonatomic, nullable) SEL action;


@property (nonatomic) PYButtonEnum curstatus;

@end


@implementation PYButton

-(instancetype) init{
    if (self = [super init]) {
        self.dictStatusInfo = [NSMutableDictionary new];
        self.dictContaints = [NSMutableDictionary new];
        
        UILabel * l = [UILabel new];
        l.backgroundColor = [UIColor clearColor];
        l.numberOfLines = 0;
        l.textAlignment = NSTextAlignmentCenter;
        self.lableTitle = l;
        self.fontText = [UIFont systemFontOfSize:14];
        
        UIImageView * iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.contentMode = UIViewContentModeScaleToFill;
        self.imageBg = iv;
        
        iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        self.imageShow = iv;
        
        
        [self addSubview:self.imageBg];
        [self addSubview:self.lableTitle];
        [self addSubview:self.imageShow];
    }
    return self;
}
-(void) setStatus:(PYButtonEnum)status{
    _status = status;
    self.curstatus = status;
    [self reFreshData];
}
-(void) setFontText:(UIFont *)fontText{
    _fontText = fontText;
    self.lableTitle.font = fontText;
}

-(void) setBgImage:(nullable UIImage *) image status:(PYButtonEnum) status{
    
    NSMutableDictionary<NSString *, id> * info = [self.dictStatusInfo objectForKey:@(status)];
    if (!info) {
        info = [NSMutableDictionary new];
        self.dictStatusInfo[@(status)] = info;
    }
    info[PYButtonStatusInfoBgImageKey] = image;

}
-(void) setImage:(nullable UIImage *) image status:(PYButtonEnum) status{
    NSMutableDictionary<NSString *, id> * info = [self.dictStatusInfo objectForKey:@(status)];
    if (!info) {
        info = [NSMutableDictionary new];
        self.dictStatusInfo[@(status)] = info;
    }
    info[PYButtonStatusInfoImageKey] = image;
}
-(void) setTitle:(nullable NSString *) title status:(PYButtonEnum) status{
    NSMutableDictionary<NSString *, id> * info = [self.dictStatusInfo objectForKey:@(status)];
    if (!info) {
        info = [NSMutableDictionary new];
        self.dictStatusInfo[@(status)] = info;
    }
    info[PYButtonStatusInfoTitleKey] = title;
}
-(void) setColor:(nullable UIColor *) color status:(PYButtonEnum) status{
    NSMutableDictionary<NSString *, id> * info = [self.dictStatusInfo objectForKey:@(status)];
    if (!info) {
        info = [NSMutableDictionary new];
        self.dictStatusInfo[@(status)] = info;
    }
    info[PYButtonStatusInfoColorKey] = color;
}

-(void) reFreshData{
    
    NSMutableDictionary<NSString *, id> * info = [self.dictStatusInfo objectForKey:@(self.curstatus)];
    if (!info) {
        return;
    }
    
    NSString * title = info[PYButtonStatusInfoTitleKey];
    UIColor * color = info[PYButtonStatusInfoColorKey];
    UIImage * bgimage = info[PYButtonStatusInfoBgImageKey];
    UIImage * image = info[PYButtonStatusInfoImageKey];
    
    CGRect rectLable = CGRectMake(0, 0, 0, 0);
    CGRect rectImage = CGRectMake(0, 0, 0, 0);
    if (bgimage) {
        self.imageBg.image = bgimage;
        self.imageBg.frame = self.bounds;
    }else{
        self.imageBg.image = nil;
    }
    
    if (image) {
        self.imageShow.image = image;
        rectImage.size = image.size;
        rectImage.origin = CGPointMake((self.frameWidth - rectImage.size.width) / 2, (self.frameHeight - rectImage.size.height) / 2);
    }
    
    if (title) {
        self.lableTitle.text = title;
        self.lableTitle.textColor = color;
        
        self.lableTitle.frameHeight = [PYUtile getFontHeightWithSize:self.lableTitle.font.pointSize fontName:self.lableTitle.font.fontName];
        [self.lableTitle automorphismHeight];
        [self.lableTitle automorphismWidth];
        
        rectLable.size = self.lableTitle.frameSize;
        
        if (image) {
            CGFloat offset =self.frameHeight - rectImage.size.height - rectLable.size.height;
            if (offset > 0) {
                rectLable.size.width = MIN(self.frameWidth, rectLable.size.width);
                rectLable.origin.x = (self.frameWidth - rectLable.size.width) / 2;
                rectImage.origin.y = offset / 3;
                rectLable.origin.y = rectImage.size.height + offset * 2 / 3;
            }else{
                offset = self.frameWidth - rectLable.size.width - rectImage.size.width;
                rectImage.origin.x = offset / 3;
                
                rectLable.origin.y = (self.frameHeight - rectLable.size.height) / 2;
                rectLable.origin.x = rectImage.size.height + offset * 2 / 3;
            }
        }else{
            rectLable.origin = CGPointMake((self.frameWidth - rectLable.size.width) / 2, (self.frameHeight - rectLable.size.height) / 2);
        }
    }
    
    self.imageShow.frame = rectImage;
    self.lableTitle.frame = rectLable;
    
}

-(void) addTarget:(nullable id) target action:(nonnull SEL)action{
    self.target = target;
    self.action = action;
}

-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSMutableDictionary<NSString *, id> * info = [self.dictStatusInfo objectForKey:@(PYButtonEnumHighlight)];
    if (!info) {
        return;
    }
    self.curstatus = PYButtonEnumHighlight;
    [self reFreshData];
}

-(void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    __block __weak typeof(self) bwself = self;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        double delayInSeconds = .25;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        __block __weak typeof(bwself) bwbwself = bwself;
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            bwbwself.status = bwbwself.status;
        });
    });
    if (self.target && self.action) {
        NSInvocation * invoke = [PYReflect startInvoke:self.target action:self.action];
        
        if (invoke.methodSignature.numberOfArguments > 2) {
            id idself = self;
            [PYReflect setInvoke:&idself index:2 invocation:invoke];
        }
        [PYReflect excuInvoke:nil returnType:nil invocation:invoke];
    }
}

-(void) touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.status = self.status;
}

-(void) layoutSubviews{
    [self reFreshData];
}


@end

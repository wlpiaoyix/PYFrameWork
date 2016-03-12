//
//  UINavigationControllerMenusImp.m
//  PYFrameWork
//
//  Created by wlpiaoyi on 16/2/3.
//  Copyright © 2016年 wlpiaoyi. All rights reserved.
//

#import "UINavigationControllerMenusImp.h"
#import <objc/runtime.h>
#import "PYToolBarView.h"
#import <Utile/EXTScope.h>
#import <Utile/UIView+Expand.h>
#import <Utile/PYUtile.h>
#import "PYButton.h"

@interface UINavigationControllerMenusImp()

@property (nonatomic, assign, nonnull) UINavigationController *navigationRoot;

@property (nonatomic, readonly, nonnull) PYToolBarView * toolBarView;
@property (nonatomic, strong, nonnull) NSMutableDictionary<NSNumber *, NSArray<__kindof UIViewController *> *> * dictControllers;

@property (nonatomic, strong, nullable) NSArray<PYButton *> * buttons;

@end

@implementation UINavigationControllerMenusImp
-(instancetype) init{
    if (self = [super init]) {
        _toolBarView = [PYToolBarView new];
        self.dictControllers = [NSMutableDictionary new];
    }
    return self;
}

-(void) beforeExcuteViewWillAppear:(nonnull BOOL *) isExcute target:(nonnull UIViewController *) target{
    *isExcute = true;
}
-(void) afterExcuteViewWillAppearWithTarget:(nonnull UIViewController *) target{
    if (![target isKindOfClass:[UINavigationController class]]) {
        return;
    }
    
    [self.toolBarView removeFromSuperview];
    
    self.navigationRoot = (UINavigationController*)target;
    
    ((UINavigationController*)target).toolbarHidden = NO;
    [((UINavigationController*)target).toolbar addSubview:self.toolBarView];
    
    self.toolBarView.maxShow = 4;
}

-(void) beforeExcuteViewDidLayoutSubviews:(nonnull BOOL *) isExcute target:(nonnull UIViewController *) target{
    *isExcute = true;
}
-(void) afterExcuteViewDidLayoutSubviewsWithTarget:(nonnull UIViewController *) target{
    if (![target isKindOfClass:[UINavigationController class]]) {
        return;
    }
    
    self.toolBarView.frame = ((UINavigationController*)target).toolbar.bounds;
}

-(void) setMenusAction:(NSDictionary<NSNumber *,NSDictionary<NSString *,NSString *> *> *)menusAction{
    
    _menusAction = menusAction;
    
    if (![self createButton]) {
        return;
    }
    
    self.toolBarView.buttonMenus = self.buttons;
    
}


-(void) setMenusInfo:(NSArray<NSDictionary<NSString *,NSString *> *> *)menusInfo{
    
    _menusInfo = menusInfo;
    
    if (![self createButton]) {
        return;
    }
    
    self.toolBarView.buttonMenus = self.buttons;
    
}

-(void) setShowIndex:(NSUInteger)showIndex{
    
    if ([self.buttons count] <= showIndex) {
        return;
    }
    
    _showIndex = showIndex;
    
    [self onclickMenu:self.buttons[showIndex]];
    
}
-(BOOL) createButton{
    
    if (!self.menusAction || !self.menusInfo) {
        return false;
    }
    
    if ([self.menusInfo count] != [[self.menusAction allKeys] count]) {
        return false;
    }
    
    NSMutableArray<PYButton *> * buttons = [NSMutableArray new];
    
    @weakify(self);
    PYButton * (^blockCreateButton)(NSDictionary<NSString *, NSString *> * info , NSDictionary<NSString *, id> * action) = ^PYButton*(NSDictionary<NSString *, NSString *> * info , NSDictionary<NSString *, id> * action){
        @strongify(self);
        
        NSString * menuTitle = action[(NSString*)NCHVMenuTitle];
        UIFont * menuFont = action[(NSString*)NCHVMenuFont];
        
        UIColor * menuColorNormal = action[(NSString*)NCHVMenuColorNormal];
        UIColor * menuColorSelected = action[(NSString*)NCHVMenuColorSelected];
        UIColor * menuColorHighlight = action[(NSString*)NCHVMenuColorHighlight];
        
        UIImage * menuBgImageNormal = action[(NSString*)NCHVMenuBgimageNormal];
        UIImage * menuBgImageSelected = action[(NSString*)NCHVMenuBgimageSelected];
        UIImage * menuBgImageHighlight = action[(NSString*)NCHVMenuBgimageHighlight];
        
        UIImage * menuImageNormal = action[(NSString*)NCHVMenuImageNormal];
        UIImage * menuImageSelected = action[(NSString*)NCHVMenuImageSelected];
        UIImage * menuImageHighlight = action[(NSString*)NCHVMenuImageHighlight];
        
        
        PYButton * button = [PYButton new];
        [button setBgImage:menuBgImageNormal status:PYButtonEnumNormal];
        [button setBgImage:menuBgImageSelected status:PYButtonEnumSelected];
        [button setBgImage:menuBgImageHighlight status:PYButtonEnumHighlight];
        
        if (menuTitle) {
            
            [button setTitle:menuTitle status:PYButtonEnumNormal];
            [button setTitle:menuTitle status:PYButtonEnumSelected];
            [button setTitle:menuTitle status:PYButtonEnumHighlight];
            
            [button setFontText:menuFont];
            
            [button setColor:menuColorNormal status:PYButtonEnumNormal];
            [button setColor:menuColorSelected status:PYButtonEnumSelected];
            [button setColor:menuColorHighlight status:PYButtonEnumHighlight];
            
        }
        
        if(menuImageNormal){
            
            [button setImage:menuImageNormal status:PYButtonEnumNormal];
            [button setImage:menuImageSelected status:PYButtonEnumSelected];
            [button setImage:menuImageHighlight status:PYButtonEnumHighlight];
            
        }
        if(!menuTitle && !menuImageNormal){
            NSString * log = [NSString stringWithFormat:@"%@ createButton no action info at index %lu",NSStringFromClass([UINavigationControllerMenusImp class]), (unsigned long)index];
            NSAssert(false, log);
        }
        [button addTarget:self action:@selector(onclickMenu:)];
        
        return button;
    };
    
    NSUInteger index = 0;
    for (NSDictionary<NSString *, NSString *> * info in self.menusInfo) {
        
        PYButton * button = blockCreateButton(info,self.menusAction[@(index)]);
        button.index = index;
        [buttons addObject:button];
        
        index++;
        
    }
    
    self.buttons = [NSArray arrayWithArray:buttons];
    
    return true;
}

-(void) onclickMenu:(PYButton *) button{
    
    NSNumber * currentIndex = @(button.index);
    NSNumber * currentNaindex = @(button.index + 100);
    
    for (NSNumber * key in self.dictControllers.allKeys) {
        NSArray<__kindof UIViewController *> * _showControllers_ = self.dictControllers[key];
        if (_showControllers_.firstObject == self.navigationRoot.viewControllers.firstObject) {
            NSInteger perIndex = key.integerValue;
            self.dictControllers[key] = self.navigationRoot.viewControllers;
            self.dictControllers[@(perIndex + 100)] = @[self.navigationRoot];
            break;
        }
    }

    
    NSArray<__kindof UIViewController *> * showControllers = self.dictControllers[currentIndex];
    if (self.dictControllers[currentNaindex].firstObject) {
        self.navigationRoot = self.dictControllers[currentNaindex].firstObject;
    }
    if (!showControllers) {
        
        NSDictionary<NSString *, NSString *> * info = self.menusInfo[currentIndex.integerValue];
        
        NSString * interfaceBuilderName = info[(NSString*)NCHVMenuInterfaceBuilderName];
        NSString * className = info[(NSString*)NCHVMenuClassName];
        NSString * storyBoardName = info[(NSString*)NCHVMenuStoryBoardName];
        NSString * storyBoardIdentify = info[(NSString*)NCHVMenuStoryBoardIdentify];
        
        NSString * actionName = nil;
        
        if (interfaceBuilderName) {
            actionName = interfaceBuilderName;
        }else if(className){
            actionName = className;
        }else if(storyBoardName){
            actionName = [NSString stringWithFormat:@"%@_%@",storyBoardName, storyBoardIdentify ? storyBoardIdentify : @"defaultId"];
        }
        if (actionName) {
            
            if (interfaceBuilderName) {
                
                Class actionClass = NSClassFromString(actionName);
                showControllers = @[[[actionClass alloc] initWithNibName:actionName bundle:nil]];
                
            }else if(className){
                
                Class actionClass = NSClassFromString(actionName);
                showControllers = @[[actionClass new]];
                
            }else if(storyBoardName){
                
                UIStoryboard * storyboard = [UIStoryboard storyboardWithName:storyBoardName bundle:[NSBundle mainBundle]];
                UIViewController * vc;
                if (storyBoardIdentify) {
                    vc  = [storyboard instantiateViewControllerWithIdentifier:storyBoardIdentify];
                }else{
                    vc = [storyboard instantiateInitialViewController];
                }
                if (vc) {
                    showControllers = @[vc];
                }
            }
        }
    }
    
    
    if (showControllers && [showControllers count]) {
        
        if (!showControllers || showControllers.count == 0) {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有要显示的Controler" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
            return;
        }
        
        if (![showControllers.firstObject isKindOfClass:[UIViewController class]]) {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"不能显示非Controller的数据" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
            return;
        }
        
        if ([showControllers.firstObject isKindOfClass:[UINavigationController class]]) {
            self.navigationRoot = showControllers.firstObject;
            showControllers = self.navigationRoot.viewControllers;
        }
        
        [UIApplication sharedApplication].keyWindow.rootViewController = self.navigationRoot;
        [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];
        
        [UIView setAnimationDuration:1];
        [self.navigationRoot setViewControllers:showControllers];        for (PYButton * btn in self.buttons) {
            [btn setStatus:btn == button ? PYButtonEnumSelected : PYButtonEnumNormal];
        }
        self.dictControllers[currentIndex] = showControllers;
        self.dictControllers[currentNaindex] = @[self.navigationRoot];
    }

}


@end

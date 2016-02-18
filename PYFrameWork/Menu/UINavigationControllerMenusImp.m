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

-(void) beforeExcuteViewDidLoad:(nonnull BOOL *) isExcute target:(nonnull UIViewController *) target{
    *isExcute = true;
}
-(void) afterExcuteViewDidLoadWithTarget:(nonnull UIViewController *) target{
    if (![target isKindOfClass:[UINavigationController class]]) {
        return;
    }
    self.navigationRoot = (UINavigationController*)target;
    
    ((UINavigationController*)target).toolbarHidden = NO;
    [((UINavigationController*)target).toolbar addSubview:self.toolBarView];
    self.toolBarView.maxShow = 4;
}

-(void) beforeExcuteViewWillAppear:(nonnull BOOL *) isExcute target:(nonnull UIViewController *) target{
    *isExcute = true;
}
-(void) afterExcuteViewWillAppearWithTarget:(nonnull UIViewController *) target{
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
    
    NSDictionary<NSString *, NSString *> * info = self.menusInfo[button.index];
    
    NSString * interfaceBuilderName = info[(NSString*)NCHVMenuInterfaceBuilderName];
    NSString * className = info[(NSString*)NCHVMenuClassName];
    NSString * storyBoardName = info[(NSString*)NCHVMenuStoryBoardName];
    NSString * storyBoardIdentify = info[(NSString*)NCHVMenuStoryBoardIdentify];
    
    NSArray<__kindof UIViewController *> * showControllers = nil;
    
    NSString * actionName = nil;
    
    if (interfaceBuilderName) {
        actionName = interfaceBuilderName;
    }else if(className){
        actionName = className;
    }else if(storyBoardName){
        actionName = [NSString stringWithFormat:@"%@_%@",storyBoardName, storyBoardIdentify ? storyBoardIdentify : @"defaultId"];
    }
    
    if (actionName && !(showControllers = self.dictControllers[@(button.index)])) {
        
        if (interfaceBuilderName) {
            
            Class actionClass = NSClassFromString(actionName);
            showControllers = @[[[actionClass alloc] initWithNibName:actionName bundle:nil]];
            
        }else if(className){
            
            Class actionClass = NSClassFromString(actionName);
            showControllers = @[[actionClass new]];
            
        }else if(storyBoardName){
            
            UIStoryboard * storyboard = [UIStoryboard storyboardWithName:storyBoardName bundle:[NSBundle mainBundle]];
            
            if (storyBoardIdentify) {
                showControllers = @[[storyboard instantiateViewControllerWithIdentifier:storyBoardIdentify]];
            }else{
                showControllers = @[storyboard.instantiateInitialViewController];
            }

        }
        
    }
    
    if (showControllers && [showControllers count] && actionName) {
        
        for (NSNumber * key in self.dictControllers.allKeys) {
            NSArray<__kindof UIViewController *> * _showControllers_ = self.dictControllers[key];
            if (_showControllers_.firstObject == self.navigationRoot.viewControllers.firstObject) {
                self.dictControllers[key] = self.navigationRoot.viewControllers;
                self.buttons[key.intValue].status = PYButtonEnumNormal;
                break;
            }
        }
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.navigationRoot.view cache:NO];
        
        [self.navigationRoot setViewControllers:showControllers];
        
        [UIView commitAnimations];
        
        self.dictControllers[@(button.index)] = showControllers;
        [button setStatus:PYButtonEnumSelected];
    }

}


@end

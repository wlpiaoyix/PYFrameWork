//
//  AppDelegate.m
//  PYFrameWork
//
//  Created by wlpiaoyi on 16/1/15.
//  Copyright © 2016年 wlpiaoyi. All rights reserved.
//

#import "AppDelegate.h"
#import "PYFrameWork.h"
#import <Utile/UIImage+Expand.h>
#import "PYNavigationBarTools.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [PYFrameWork orientationWithSupportedInterface:UIInterfaceOrientationMaskAllButUpsideDown preferredInterfaceOrientation:UIInterfaceOrientationPortrait];
    id a = @[
             @{NCHVMenuStoryBoardName:@"Main"},
             @{NCHVMenuStoryBoardName:@"Main", NCHVMenuStoryBoardIdentify:@"vc02"},
             @{NCHVMenuStoryBoardName:@"Main"},
             @{NCHVMenuStoryBoardName:@"Main", NCHVMenuStoryBoardIdentify:@"vc02"},
             @{NCHVMenuStoryBoardName:@"Main", NCHVMenuStoryBoardIdentify:@"vc"}
             ];
    UIImage * image1 = [UIImage imageNamed:@"1.png"];
    UIImage * image2 = [UIImage imageNamed:@"2.png"];
    UIImage * image3 = [UIImage imageNamed:@"3.png"];
    
    UIImage * image11 = [UIImage imageWithColor:[UIColor yellowColor]];
    UIImage * image22 = [UIImage imageWithColor:[UIColor blueColor]];
    UIImage * image33 = [UIImage imageWithColor:[UIColor greenColor]];
    UIFont * font = [UIFont boldSystemFontOfSize:8];
    
    id b = @{
             @(0):@{NCHVMenuTitle:@"1",NCHVMenuFont:font,NCHVMenuColorNormal:[UIColor grayColor],NCHVMenuColorSelected:[UIColor orangeColor],NCHVMenuImageNormal:image1,NCHVMenuImageHighlight:image2,NCHVMenuImageSelected:image3,NCHVMenuBgimageNormal:image11,NCHVMenuBgimageSelected:image33,NCHVMenuBgimageHighlight:image22},
             @(1):@{NCHVMenuTitle:@"2",NCHVMenuFont:font,NCHVMenuColorNormal:[UIColor grayColor],NCHVMenuColorSelected:[UIColor orangeColor],NCHVMenuImageNormal:image1,NCHVMenuImageHighlight:image2,NCHVMenuImageSelected:image3,NCHVMenuBgimageNormal:image11,NCHVMenuBgimageSelected:image33,NCHVMenuBgimageHighlight:image22},
             @(2):@{NCHVMenuTitle:@"3",NCHVMenuFont:font,NCHVMenuColorNormal:[UIColor grayColor],NCHVMenuColorSelected:[UIColor orangeColor],NCHVMenuImageNormal:image1,NCHVMenuImageHighlight:image2,NCHVMenuImageSelected:image3,NCHVMenuBgimageNormal:image11,NCHVMenuBgimageSelected:image33,NCHVMenuBgimageHighlight:image22},
             @(3):@{NCHVMenuTitle:@"4",NCHVMenuFont:font,NCHVMenuColorNormal:[UIColor grayColor],NCHVMenuColorSelected:[UIColor orangeColor],NCHVMenuImageNormal:image1,NCHVMenuImageHighlight:image2,NCHVMenuImageSelected:image3,NCHVMenuBgimageNormal:image11,NCHVMenuBgimageSelected:image33,NCHVMenuBgimageHighlight:image22},
             @(4):@{NCHVMenuTitle:@"5",NCHVMenuFont:font,NCHVMenuColorNormal:[UIColor grayColor],NCHVMenuColorSelected:[UIColor orangeColor],NCHVMenuImageNormal:image1,NCHVMenuImageHighlight:image2,NCHVMenuImageSelected:image3,NCHVMenuBgimageNormal:image11,NCHVMenuBgimageSelected:image33,NCHVMenuBgimageHighlight:image22},
             };
    
    [PYFrameWork toolBarWithMenusInfo:a menusAction:b];
    
    [PYFrameWork navigatonBarWithBlock:^(UIViewController * _Nonnull curVc, PYNavigationBarTools * _Nonnull ntbTools) {
        if (!curVc.navigationController) {
            return;
        }
        [ntbTools setBackgourndColor:[UIColor blueColor] navigationBar:curVc.navigationController.navigationBar];
    }];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

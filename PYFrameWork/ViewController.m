//
//  ViewController.m
//  PYFrameWork
//
//  Created by wlpiaoyi on 16/1/15.
//  Copyright © 2016年 wlpiaoyi. All rights reserved.
//

#import "ViewController.h"
#import <Utile/Utile.Framework.h>
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lableAuto;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutBottom;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"第一个";
    [self.view setCornerRadiusAndBorder:1 borderWidth:1 borderColor:[UIColor redColor]];
    UIView * view = [UIView new];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    
    [PYViewAutolayoutCenter persistConstraint:view centerPointer:CGPointMake(-50, DisableConstrainsValueMAX)];
    [PYViewAutolayoutCenter persistConstraint:view relationmargins:UIEdgeInsetsMake(DisableConstrainsValueMAX, DisableConstrainsValueMAX, 0, DisableConstrainsValueMAX) relationToItems:PYEdgeInsetsItemNull()];
    [PYViewAutolayoutCenter persistConstraint:view size:CGSizeMake(40, 40)];
    
    id a = self.layoutBottom.firstItem;
    UIView * b = self.layoutBottom.secondItem;
    [b removeConstraint:self.layoutBottom];
    [PYViewAutolayoutCenter persistConstraint:self.lableAuto relationmargins:UIEdgeInsetsMake(DisableConstrainsValueMAX, DisableConstrainsValueMAX, 0, DisableConstrainsValueMAX) relationToItems:PYEdgeInsetsItemNull()];
    NSLog(@"sdfsdf");
    
}
- (IBAction)OnclickNext:(id)sender {
    [self performSegueWithIdentifier:@"show01" sender:nil];
    CGRect r = self.view.frame;
    CGRect r2 = [UIApplication sharedApplication].keyWindow.bounds;
    NSLog(@"");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)shouldAutorotate{
    return true;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown;
}
// Returns interface orientation masks.
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}

@end

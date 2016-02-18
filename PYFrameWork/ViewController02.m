//
//  ViewController02.m
//  PYFrameWork
//
//  Created by wlpiaoyi on 16/1/18.
//  Copyright © 2016年 wlpiaoyi. All rights reserved.
//

#import "ViewController02.h"
#import "PYBarButtonItemTools.h"
#import "PYNavigationBarTools.h"
#import <Utile/Utile.Framework.h>

@interface ViewController02 ()
@property (nonatomic) BOOL isHidden;

@end

@implementation ViewController02

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"第二个";
    UIBarButtonItem * bbi = [[UIBarButtonItem alloc] initWithTitle:@"右边" style:UIBarButtonItemStylePlain target:self action:@selector(setIsHiddenEnd)];
    [[PYBarButtonItemTools new] setDefaultStyle:bbi];
    self.navigationItem.rightBarButtonItem = bbi;
    [self.view setCornerRadiusAndBorder:1 borderWidth:1 borderColor:[UIColor redColor]];
}
-(void) setIsHiddenEnd{
    _isHidden = !_isHidden;
    [self.navigationController setToolbarHidden:_isHidden animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate{
    return true;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskLandscapeLeft| UIInterfaceOrientationMaskPortraitUpsideDown;
}
// Returns interface orientation masks.
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationLandscapeLeft;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

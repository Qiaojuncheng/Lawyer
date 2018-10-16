//
//  QJAboutAppViewController.m
//  Lawyer
//
//  Created by MYMAc on 2017/4/12.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJAboutAppViewController.h"

@interface QJAboutAppViewController ()

@end

@implementation QJAboutAppViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCenterLabelWithTitle:@"关于汇融法" titleColor:[UIColor whiteColor]];
//    [Utile makeCorner:25 view:self.IconView];
    
    self.VersionLB.text  =[NSString stringWithFormat:@"版本号：%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    self.view.backgroundColor = [UIColor whiteColor];
      // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

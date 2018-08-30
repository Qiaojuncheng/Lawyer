//
//  LawRemainingViewController.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/14.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawRemainingViewController.h"
#import "LawMoneyDetailViewController.h"
#import "LawRemainingwithdrawalVC.h"
@interface LawRemainingViewController ()

@end

@implementation LawRemainingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCenterLabelWithTitle:@"账户余额" titleColor:[UIColor blackColor]];
    MJWeakSelf;
    [self addRightButtonWithTitle:@"明细" titleColor:[UIColor colorWithHex:0x3181fe] actionBlock:^{
        LawMoneyDetailViewController * detail = [[LawMoneyDetailViewController alloc] init];
        [weakSelf.navigationController pushViewController:detail animated:YES];
    }];
    
    [self.TixianLB whenTapped:^{
       
        LawRemainingwithdrawalVC * lawTixanVC =[[LawRemainingwithdrawalVC alloc]init];
        [self.navigationController pushViewController:lawTixanVC animated:YES];
    }];
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

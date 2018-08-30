//
//  LawRemainingwithdrawalVC.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/20.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawRemainingwithdrawalVC.h"
#import "LawWthDeawalViewController.h"

@interface LawRemainingwithdrawalVC ()

@end

@implementation LawRemainingwithdrawalVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCenterLabelWithTitle:@"余额提现" titleColor:nil];
    [Utile makeCorner:self.TiXianBtn.height/2 view:self.TiXianBtn];
    [Utile makeCorner:4 view:self.BackView];

    
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

- (IBAction)Btnaction:(id)sender {
    LawWthDeawalViewController *  law  =[[LawWthDeawalViewController alloc ]init];
    [self.navigationController pushViewController:law animated:YES];
}
@end

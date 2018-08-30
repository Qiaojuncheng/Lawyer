//
//  LawAddCardViewController.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/24.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawAddCardViewController.h"
#import "LawCardInfoViewController.h"
@interface LawAddCardViewController ()

@end

@implementation LawAddCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCenterLabelWithTitle:@"添加银行卡" titleColor:nil];
    [Utile makeCorner:23 view:self.NextBtn];
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

- (IBAction)NextBtnAction:(id)sender {
    LawCardInfoViewController  * cardInfo =[[LawCardInfoViewController alloc]init];
    [self.navigationController pushViewController:cardInfo animated:YES];
}
@end

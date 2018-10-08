//
//  LawWthDeawalViewController.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/20.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawWthDeawalViewController.h"

@interface LawWthDeawalViewController ()

@end

@implementation LawWthDeawalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self  addCenterLabelWithTitle:@"结果详情" titleColor:nil];
    [self.SuccessBtn createBordersWithColor:[UIColor colorWithHex:0x3181FE] withCornerRadius:self.SuccessBtn.height/2 andWidth:1];
    self.PriceLB.text = [NSString stringWithFormat:@"￥ %@",self.price];
    self.CardNaem.text = self.cardName;
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

- (IBAction)SuccesssAction:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end

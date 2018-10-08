//
//  LawRemainingwithdrawalVC.h
//  TheLawyer
//
//  Created by MYMAc on 2018/8/20.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "BaseViewController.h"

@interface LawRemainingwithdrawalVC : BaseViewController

@property (strong ,nonatomic ) NSString * AllMoney;
@property (weak, nonatomic) IBOutlet UIView *BackView;

@property (weak, nonatomic) IBOutlet UILabel *CardLB;

@property (weak, nonatomic) IBOutlet UITextField *PriceTextField;

@property (weak, nonatomic) IBOutlet UILabel *TipLabel;

@property (weak, nonatomic) IBOutlet UILabel *AllTiXianLB;


@property (weak, nonatomic) IBOutlet UIButton *TiXianBtn;
- (IBAction)Btnaction:(id)sender;




@end

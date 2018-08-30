//
//  QJTiXianViewController.h
//  Lawyer
//
//  Created by MYMAc on 2017/4/11.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "BaseViewController.h"

@interface QJTiXianViewController : BaseViewController
@property (nonatomic,strong)NSString *moneyString;
@property (weak, nonatomic) IBOutlet UILabel *yueMoneyLab;
@property (weak, nonatomic) IBOutlet UITextField *tiMoneyText;
@property (weak, nonatomic) IBOutlet UITextField  *    Cardname  ;// 持卡人名字
@property (weak, nonatomic) IBOutlet UITextField  *  bank_name  ; // 所属银行
@property (weak, nonatomic) IBOutlet UITextField  *  bank_card  ; // 银行卡号
@property (weak, nonatomic) IBOutlet UITextField  *  bank_address  ; //  开户行地址

@property (weak, nonatomic) IBOutlet UIButton *tixianBtn;
- (IBAction)didTixian:(id)sender;
- (IBAction)SelectAction:(id)sender;

@end

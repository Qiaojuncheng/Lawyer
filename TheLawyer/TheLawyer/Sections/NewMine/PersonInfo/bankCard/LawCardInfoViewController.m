//
//  LawCardInfoViewController.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/24.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawCardInfoViewController.h"
#import "LawCardSMSViewController.h"
@interface LawCardInfoViewController ()

@end

@implementation LawCardInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCenterLabelWithTitle:@"验证银行卡信息" titleColor:nil];
    [Utile makeCorner:23 view:self.AgreeBtn];
    self.whatImage.userInteractionEnabled = YES;
    [self.whatImage whenTapped:^{
        [self showPhoneMessage];
    }];
    self.CardName.text  = self.cardNamestr;
    self.CardNumberLB.text = self.cardnumber;
    // Do any additional setup after loading the view from its nib.
}
-(void)showPhoneMessage{
    UIAlertController * alvc =[UIAlertController alertControllerWithTitle:@"手机号" message:@"银行预留手机号是在银行办卡时填写 的手机号，若遗忘、换号可联系银行 客服电话处理" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * sureAction =  [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alvc addAction:sureAction];
    [self presentViewController:alvc animated:YES completion:nil];
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

- (IBAction)AgreeBtnACtion:(id)sender {
    LawCardSMSViewController  * cardSMS  = [[LawCardSMSViewController alloc]init];
    cardSMS.phoneNumber = self.PhoneTextField.text;
    cardSMS.CardNumber = self.cardnumber;
    cardSMS.idcard =self.numberTextfield.text;
    cardSMS.name =self.cardTExtFiled.text;
    cardSMS.bankname = self.cardNamestr;
    [self.navigationController pushViewController:cardSMS animated:YES];
}
@end

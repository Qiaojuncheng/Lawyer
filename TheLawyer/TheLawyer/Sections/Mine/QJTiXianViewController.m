//
//  QJTiXianViewController.m
//  Lawyer
//
//  Created by MYMAc on 2017/4/11.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJTiXianViewController.h"

@interface QJTiXianViewController (){
    NSMutableArray *  bankListArr ;

}

@end

@implementation QJTiXianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bank_name.enabled = NO;
    bankListArr  =[[NSMutableArray alloc]initWithObjects:@"建设银行",@"中国银行",@"农业银行",@"工商银行",@"交通银行",@"邮政银行",@"人民银行",@"广大银行", @"广发银行", @"浦发银行", @"民生银行", @"江苏银行", @"兴业银行", @"中信银行", @"招商银行", @"深圳发展银行", nil];
 
    
    [self addCenterLabelWithTitle:@"提现" titleColor:[UIColor whiteColor]];
//    self.view.backgroundColor = MainBackColor;
   // [self makeBackItem];
    [self getTXinfo];
    self.tixianBtn.layer.masksToBounds = YES;
    self.tixianBtn.layer.cornerRadius = 8;
    
    self.yueMoneyLab.text = [NSString stringWithFormat:@"%@元",self.moneyString];

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
-(void)getTXinfo{
    
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    QJTXINFO
    NSDictionary * valudic  = @{@"user_id":UserId};
     NSString * baseStr = [NSString getBase64StringWithArray:valudic];
    [dic setValue:baseStr forKey:@"value"];
    
    [self showHudInView:self.view hint:nil];
    [HttpAfManager postWithUrlString:BASE_URL parameters:dic success:^(id data) {
         NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
// 提现的信息
            self.Cardname.text = [NSString stringWithFormat:@"%@",data[@"data"][@"name"]];
            self.bank_name.text = [NSString stringWithFormat:@"%@",data[@"data"][@"bank_name"]];
            self.bank_card.text = [NSString stringWithFormat:@"%@",data[@"data"][@"bank_card"]];
            self.bank_address.text = [NSString stringWithFormat:@"%@",data[@"data"][@"bank_address"]];

        }else{
            NSString * msg = [NSString stringWithFormat:@"%@",data[@"msg"]];
            [self showHint:msg];
        }
        [self hideHud];
    } failure:^(NSError *error) {
        [self hideHud];
        
    }];
}

//判断是否银行卡
-(BOOL) checkCardNo:(NSString*) cardNo{
    int oddsum = 0;    //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int cardNoLength = (int)[cardNo length];
    int lastNum = [[cardNo substringFromIndex:cardNoLength-1] intValue];
    
    cardNo = [cardNo substringToIndex:cardNoLength -1];
    for (int i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1,1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1 ) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) ==0)
        return YES;
    else
        return NO;
}
#pragma mark 提现接口
- (IBAction)didTixian:(id)sender {
    
    if ([Utile stringIsNil:self.tiMoneyText.text]) {
        [self showHint:@"请输入提现金额！"];
        return;
    }else if ([Utile stringIsNil:self.Cardname.text]) {
        [self showHint:@"请输入持卡人姓名"];
        return;
    } else if ([Utile stringIsNil:self.bank_name.text]) {
        [self showHint:@"请选择所属银行"];
        return;
    } else if (![self checkCardNo:self.bank_card.text]) {
        [self showHint:@"请输入银行卡号"];
        return;
    } else if ([Utile stringIsNil:self.bank_address.text]) {
        [self showHint:@"请输入开户行地址"];
        return;
    }else if ([self.moneyString floatValue] < [self.tiMoneyText.text floatValue]) {
        [self showHint:@"余额不足！"];
        return;
    }
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    UserdoCash
    NSDictionary * valudic  = @{@"user_id":UserId,@"money":self.tiMoneyText.text,@"name":self.Cardname.text,@"bank_name":self.bank_name.text,@"bank_card":self.bank_card.text,@"bank_address":self.bank_address.text};
    
    NSString * baseStr = [NSString getBase64StringWithArray:valudic];
    [dic setValue:baseStr forKey:@"value"];
    
    [self showHudInView:self.view hint:nil];
    [HttpAfManager postWithUrlString:BASE_URL parameters:dic success:^(id data) {
        NSLog(@"提现接口%@",data);
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            [self.navigationController popViewControllerAnimated:NO];
            
        }else{
            NSString * msg = [NSString stringWithFormat:@"%@",data[@"msg"]];
            [self showHint:msg];
        }
        [self hideHud];
    } failure:^(NSError *error) {
        [self hideHud];
        [self showHint:@"失败，请稍后重试！"];
        NSLog(@"提现接口%@",error);
    }];

}

- (IBAction)SelectAction:(id)sender {
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    for (int i = 0; i<bankListArr.count; i ++) {
        UIAlertAction *firstAction = [UIAlertAction actionWithTitle:bankListArr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.bank_name.text = bankListArr[i];
        }];
        //            [firstAction setValue:RGBColor(255, 117, 0, 1) forKey:@"_titleTextColor"];
        [alertC addAction:firstAction];
    }
    alertC.view.backgroundColor =[UIColor whiteColor];
    alertC.view.tintColor = [UIColor colorWithHex:0x333333];
    
    UIAlertAction *thiredAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    //        [thiredAction setValue:SetColor(0x666666) forKey:@"_titleTextColor"];
    [alertC addAction:thiredAction];
    [self presentViewController:alertC animated:YES completion:^{
        
    }];

}
@end

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
       
        if([_PriceLB.text integerValue] < 100){
            
            [self showHint:@"少于100不能提现"];
            return  ;
        }
        
        LawRemainingwithdrawalVC * lawTixanVC =[[LawRemainingwithdrawalVC alloc]init];
        lawTixanVC.AllMoney = _PriceLB.text;
        [self.navigationController pushViewController:lawTixanVC animated:YES];
        
    }];
    [self makeYUE];
    // Do any additional setup after loading the view from its nib.
}
-(void)makeYUE{
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    QJAddvicegetMoney
    if( [UserId length] < 1){
        return ;
    }
    NSDictionary * valudic  = @{@"id":UserId,@"type":@"2"};
    NSString * baseStr = [NSString getBase64StringWithArray:valudic];
    [dic setValue:baseStr forKey:@"value"];
    
    [self showHudInView:self.view hint:nil];
    
    
    [HttpAfManager postWithUrlString:BASE_URL parameters:dic success:^(id data) {
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            NSString * moneyStr =[NSString stringWithFormat:@"%@",data[@"data"][@"money"]];
            _PriceLB.text = moneyStr;
        }
        [self hideHud];
    } failure:^(NSError *error) {
        [self hideHud];
        NSLog(@"%@",error);
    }];
    

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

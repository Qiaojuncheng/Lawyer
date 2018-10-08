//
//  LawRemainingwithdrawalVC.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/20.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawRemainingwithdrawalVC.h"
#import "LawWthDeawalViewController.h"
#import "LawBankCardViewController.h"
@interface LawRemainingwithdrawalVC ()<UITextFieldDelegate>{
    NSMutableArray * dataArrray;
    NSString * bid ;
    NSString * showStr ;
}

@end

@implementation LawRemainingwithdrawalVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCenterLabelWithTitle:@"余额提现" titleColor:nil];
    [Utile makeCorner:self.TiXianBtn.height/2 view:self.TiXianBtn];
    [Utile makeCorner:4 view:self.BackView];
    [self makeData];
    self.PriceTextField.delegate = self ;
    self.TipLabel.textColor= TintColor;
    self.TipLabel.text = [NSString stringWithFormat:@"可提现金额：%@",self.AllMoney];
    [self.CardLB whenTapped:^{
        [self getCrad];
    }];
    
    [self.AllTiXianLB whenTapped:^{
    self.PriceTextField.text = [NSString stringWithFormat:@"%@",self.AllMoney];
    }];
    [self.PriceTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    // Do any additional setup after loading the view from its nib.
}
-(void)textFieldDidChange:(UITextField *)textField{
    
    if ([textField.text intValue] > [self.AllMoney intValue]) {
        self.TipLabel.text= @"提现金额超出可提现金额";
        self.TipLabel.textColor= [UIColor colorWithHex:0xF3745E];
    }else{
        self.TipLabel.textColor= TintColor;
        self.TipLabel.text = [NSString stringWithFormat:@"可提现金额：%@",self.AllMoney];
    }
    
    
}

-(void)makeData{
    NSMutableDictionary *valuedic =[[NSMutableDictionary alloc]init];
    [valuedic setValue:UserId forKey:@"lawyer_id"];
     NSString * base64String =[NSString getBase64StringWithArray:valuedic];
    NSMutableDictionary  *dic =[[NSMutableDictionary alloc]init] ;
    NewMyBankList ;
    [dic setValue:base64String forKey:@"value"];
    WS(ws);
    [AFManagerHelp POST:BASE_URL parameters:dic success:^(id responseObjeck) {
        // 处理数据
        DLog(@" %@",responseObjeck);
        if ([responseObjeck[@"status"] integerValue] == 0) {
            dataArrray =[[NSMutableArray alloc]
                              initWithArray:responseObjeck[@"data"]];
            if (dataArrray.count > 0) {
                NSDictionary * dicc = dataArrray[0];
                [self showWithDic:dicc];
            }else{
                self.CardLB.text = @"您还没有绑定银行卡，赶快点击绑定吧！" ;

                
            }
        }else{
            [ShowHUD showWYBTextOnly:responseObjeck[@"msg"] duration:2 inView:ws.view];
        }
       
        
         [self hideHud];
    } failure:^(NSError *error) {
         [self hideHud];
    }];
}
-(void)getCrad{
    LawBankCardViewController * card =[[LawBankCardViewController alloc]init];
    card.selectBankCarDic = ^(NSDictionary *BandDic) {
        [self showWithDic:BandDic];
    };
    [self.navigationController pushViewController:card animated:YES];
    
}
-(void)showWithDic:(NSDictionary *)dicc{
    
    NSString * carNumber = [NSString stringWithFormat:@"%@",dicc[@"bankcard"]];
     showStr =[NSString stringWithFormat:@"%@尾号%@%@",dicc[@"bankname"],[carNumber substringFromIndex:carNumber.length- 4],dicc[@"banktype"]];
    bid = dicc[@"id"];
    self.CardLB.text = showStr ;

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
    [self.view endEditing:YES];
    if (!bid) {
        [self showHint:@"请先选择银行卡"];
        return ;
    }
    if([self.PriceTextField.text integerValue] < 100){
        
        [self showHint:@"提现金额不能少于100"];
        return ;
    }
    if([self.PriceTextField.text integerValue]  > [self.AllMoney integerValue]){
        
        [self showHint:@"提现金额超出可提现金额!"];
        return ;
    }
    NSMutableDictionary *valuedic =[[NSMutableDictionary alloc]init];
    [valuedic setValue:UserId forKey:@"lawyer_id"];
    [valuedic setValue:self.PriceTextField.text forKey:@"money"];
    [valuedic setValue:UserId forKey:@"bid"];
     NSString * base64String =[NSString getBase64StringWithArray:valuedic];
    
    
    NSMutableDictionary  *dic =[[NSMutableDictionary alloc]init] ;
     NewMoneyTx ;
    [dic setValue:base64String forKey:@"value"];
     [AFManagerHelp POST:BASE_URL parameters:dic success:^(id responseObjeck) {
        // 处理数据
        DLog(@" %@",responseObjeck);
        if ([responseObjeck[@"status"] integerValue] == 0){
            
            LawWthDeawalViewController *  law  =[[LawWthDeawalViewController alloc ]init];
            law.price = self.PriceTextField.text;
            law.cardName =   showStr  ;
        [self.navigationController pushViewController:law animated:YES];
        }
        
        [self hideHud];
    } failure:^(NSError *error) {
        [self hideHud];
    }];

  
}
@end

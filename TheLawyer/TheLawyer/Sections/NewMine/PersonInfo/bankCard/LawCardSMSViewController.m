//
//  LawCardSMSViewController.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/28.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawCardSMSViewController.h"

@interface LawCardSMSViewController (){
    
    NSString * codeStr;
}

@end

@implementation LawCardSMSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ConcentLB.text = [NSString stringWithFormat:@"请输入手机%@收到的短信验证码",self.phoneNumber];
    [Utile makeCorner:23 view:self.AddCarBtn];
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

- (IBAction)GetCardBtn:(id)sender {
     sender  = (CountButton *)sender ;
 
    
    NSMutableDictionary *valuedic =[[NSMutableDictionary alloc]init];
    [valuedic setValue:self.phoneNumber forKey:@"phone"];
    __weak typeof(sender) weakeBtn = sender;
    NSString * base64String =[NSString getBase64StringWithArray:valuedic];
    NSMutableDictionary  *dic =[[NSMutableDictionary alloc]init] ;
    NewMyBankgetCode ;
    [dic setValue:base64String forKey:@"value"];
    WS(ws);
    [AFManagerHelp POST:BASE_URL parameters:dic success:^(id responseObjeck) {
        // 处理数据
        DLog(@" %@",responseObjeck);
        if ([responseObjeck[@"status"] integerValue] == 0) {
            [weakeBtn startTime];

        }else{
            
        }
        [self showHint:responseObjeck[@"msg"]];

        
         [self hideHud];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [self hideHud];
    }];
    
  
    
}
/**/
- (IBAction)notReviceBtnAction:(id)sender {
    NSString * messageStr =[NSString stringWithFormat:@"1.请确认%@是否是中国建设 银行**%@尾号银行卡的预留手机号码 2.请检查短信是否被手机安全软件拦截",self.phoneNumber,[self.CardNumber substringFromIndex:self.CardNumber.length - 4]];
    UIAlertController * alvc =[UIAlertController alertControllerWithTitle:@"收不到验证码？" message:messageStr preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * sureAction =  [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alvc addAction:sureAction];
    [self presentViewController:alvc animated:YES completion:nil];
    
}

- (IBAction)AddbtnAction:(id)sender {
    
    [self.view endEditing:YES];
    NSMutableDictionary *valuedic =[[NSMutableDictionary alloc]init];
    [valuedic setValue:UserId forKey:@"lawyer_id"];
    [valuedic setValue:self.CardNumber forKey:@"bankcard"];
    [valuedic setValue:self.bankname forKey:@"bankname"];
    [valuedic setValue:self.name forKey:@"name"];
    [valuedic setValue:self.idcard forKey:@"idcard"];
    [valuedic setValue:self.phoneNumber forKey:@"phone"];
    [valuedic setValue:self.CardTextField.text forKey:@"code"];
    [valuedic setValue:@"储蓄卡" forKey:@"banktype"];
    
     NSString * base64String =[NSString getBase64StringWithArray:valuedic];
    NSMutableDictionary  *dic =[[NSMutableDictionary alloc]init] ;
    NewMyBankbindBank ;
    [dic setValue:base64String forKey:@"value"];
    MJWeakSelf;
    [AFManagerHelp POST:BASE_URL parameters:dic success:^(id responseObjeck) {
        // 处理数据
        DLog(@" %@",responseObjeck);
   
        if ([responseObjeck[@"status"] integerValue] == 0) {
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        }else{
            
        }
        [self showHint:responseObjeck[@"msg"]];
        
        
        [self hideHud];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [self hideHud];
    }];
    
    
}
@end

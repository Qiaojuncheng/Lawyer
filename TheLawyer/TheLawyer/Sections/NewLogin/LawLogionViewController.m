//
//  LawLogionViewController.m
//  TheLawyer
//
//  Created by MYMAc on 2018/9/7.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawLogionViewController.h"
#import "QJCXieYiVc.h"
@interface LawLogionViewController (){
    
    BOOL  Type  ; // YES login   NO regisetr
    
}

@end

@implementation LawLogionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addLeftButtonWithImage: @"nav_arrow" preImg:@"nav_arrow" actionBlock:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINSUCCESS object:@(NO)];

    }];
    Type = YES;
    self.XieYiBtn.hidden = YES;
    self.XieLb.hidden =self.XieYiBtn.hidden;
    self.view.backgroundColor =[UIColor whiteColor];
    [Utile makeCorner:self.FirstBtn.height/2 view:self.FirstBtn];
    [Utile makeCorner:self.SecondBtn.height/2 view:self.SecondBtn ];
    [Utile makecorner:self.SecondBtn.height/2 view:self.SecondBtn color:[UIColor colorWithHex:0x3181FE]];
    [Utile makeCorner:10  view:self.iconImaeVeiw];
 
    self.PhoneLB.text= [NSString stringWithFormat:@"客服热线:%@",APPPhone];
    [self.XieLb whenTouchedUp:^{
        //跳转到协议界面
        QJCXieYiVc * xiyivc =[[QJCXieYiVc alloc] init];
        [self.navigationController pushViewController:xiyivc  animated:YES];    }];
    
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

- (IBAction)CodeAction:(id)sender {
    
    
    if(self.PhoneTextField.text.length ==11){
//        获取验证码
        [self  requestCodeData];
        
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请输入正确的手机号" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        
    }

    
}

- (IBAction)FirstBtn:(id)sender {
     if(self.PhoneTextField.text.length !=11){
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请输入正确的手机号" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
         [alert show];
         return  ;
     }
    if (self.PassWorldTextField.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请填写验证码" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        return  ;
    }
    NSMutableDictionary * dic =[[NSMutableDictionary alloc]init];
    NSDictionary * vadic ;
    
    if (Type){
        // 直接调用登录接口
        NewLogin
        NSString * UUid  = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        UUid =[UUid stringByReplacingOccurrencesOfString:@"-" withString:@""];
       UUid =  [UUid stringByAppendingString:self.PhoneTextField.text];
        NSString * md5Str = [UUid MD5];

        vadic = @{@"type":@"2",@"phone":self.PhoneTextField.text,@"code":self.PassWorldTextField.text,@"device":md5Str};
    }else{
        
        if(!self.XieYiBtn.selected){
            [self showHint:@"请阅读并同意协议之后再注册"];
            return ;
        }
        NewRegiste
         vadic = @{@"type":@"2",@"phone":self.PhoneTextField.text,@"code":self.PassWorldTextField.text};
    }
//      验证并登陆
         [self showHudInView:self.view hint:nil];
 
    
        NSString * baseString = [NSString getBase64StringWithArray:vadic];
        [dic setValue:baseString forKey:@"value"];
        [HttpAfManager postWithUrlString:BASE_URL parameters:dic success:^(id data) {
            NSLog(@"%@",data);
            
            NSString * status = [NSString stringWithFormat:@"%@",data[@"status"]];
            if([status isEqualToString:@"0"]){
                if (Type){
             [self showHint:@"登录成功!"];
                }else{
             [self showHint:@"注册成功!"];
                }

                
                 [UD setValue:[NSString stringWithFormat:@"%@",data[@"data"][@"id"]] forKey:@"userid"];
                [UD setValue:[NSString stringWithFormat:@"%@",data[@"data"][@"avatar"]] forKey:@"avatar"];
                [UD setValue:[NSString stringWithFormat:@"%@",data[@"data"][@"money"]] forKey:@"money"];
                [UD setValue:[NSString stringWithFormat:@"%@",data[@"data"][@"phone"]] forKey:@"phone"];
                [UD setValue:[NSString stringWithFormat:@"%@",data[@"data"][@"renzheng"]] forKey:@"renzheng"];
                [UD setValue:[NSString stringWithFormat:@"%@",data[@"data"][@"step"]] forKey:@"step"];

                [UD synchronize];
                if( [[NSString stringWithFormat:@"%@",data[@"data"][@"step"]] isEqualToString:@"1"]){
                    // 完善资料
                    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINSUCCESS object:@(YES)];
                    
                    
                }else{
//                     登录成功
                    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINSUCCESS object:@(YES)];
                    
                }
              
                
            }else{
          [self showHint:data[@"msg"]];

            }
            [self hideHud];
        } failure:^(NSError *error) {
            [self hideHud];
            
        }];

        
  
}

- (IBAction)SecondAction:(id)sender {
    
    if (Type) {
        Type = NO;
        self.XieYiBtn.hidden = NO ;
        self.XieLb.hidden =self.XieYiBtn.hidden;
        [self.FirstBtn setTitle:@"验证并注册" forState:UIControlStateNormal];
        [self.SecondBtn setTitle:@"已有账号直接登录" forState:UIControlStateNormal];

        
    }else{
        Type = YES;
        self.XieYiBtn.hidden = YES;
        self.XieLb.hidden =self.XieYiBtn.hidden;

        [self.FirstBtn setTitle:@"登录" forState:UIControlStateNormal];
        [self.SecondBtn setTitle:@"注册" forState:UIControlStateNormal];
    }
  
}

- (IBAction)XieBtnAction:(id)sender {
    UIButton * button = (UIButton *)sender;
    button.selected = !button.selected;
}
// 获取验证码
-(void)requestCodeData{
 
    NSMutableDictionary * dic =[[NSMutableDictionary alloc]init];
    
    if(Type){
//        登录
      NewLogGetCode
    }else{
       
    

        
//        注册
       NewGetCode
        
    }
    //action、value  type 1 用户 2 律师
    [self showHudInView:self.view hint:nil];

    NSDictionary *dics = @{
                           @"phone":[NSString stringWithFormat:@"%@",self.PhoneTextField.text],@"type":@"2"
                           };
    NSError *dataError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dics options:(NSJSONWritingOptions)0 error:&dataError];
    NSString *body = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    DLog(@"%@",body);
    NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [data base64EncodedStringWithOptions:0];
    DLog(@"%@",base64String);
    [dic setValue:base64String forKey:@"value"];
    
     WS(ws);
    [AFManagerHelp POST:BASE_URL parameters:dic success:^(id responseObjeck) {
        // 处理数据
        DLog(@"%@",responseObjeck);
        [self hideHud];

        if ([responseObjeck[@"status"] integerValue] == 0) {
 
            [self showHint:@"短信已发送，请注意查收"];
            [self.CodeBtn startTime];
        }else{
            [ShowHUD showWYBTextOnly:responseObjeck[@"msg"] duration:2 inView:ws.view];
        }
    } failure:^(NSError *error) {
        [self hideHud];
        [self showHint:@"网络请求失败，请稍后再试"];
     }];
}
    


@end

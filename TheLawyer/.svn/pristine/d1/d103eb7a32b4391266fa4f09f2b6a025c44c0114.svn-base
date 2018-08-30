//
//  RegisteredViewController.m
//  TheLawyer
//
//  Created by yaoyao on 17/8/3.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import "RegisteredViewController.h"
#import "PerfectViewController.h"
#import "QJCXieYiVc.h"

@interface RegisteredViewController ()
@property(nonatomic,strong)NSTimer * timer;
@property(nonatomic,assign)NSInteger  totalTime;
@end

@implementation RegisteredViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if(self.num ==1 ){
        [self addCenterLabelWithTitle:@"注册" titleColor:[UIColor whiteColor]];

    }else{
        [self addCenterLabelWithTitle:@"绑定手机" titleColor:[UIColor whiteColor]];
        
    }
    _xiyiSureButton.selected = YES;
    [Utile makeCorner:10 view: self.CoreView];
    [Utile makeCorner:3 view: self.codeButton];
    [Utile makecorner:2 view: self.CoreView color:[UIColor colorWithHex:0xececec]];
    self.telTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.nextButton.layer.masksToBounds = YES;
    self.nextButton.layer.cornerRadius =5;
    self.nextButton.layer.borderWidth =.5;
    self.nextButton.layer.borderColor = [UIColor clearColor].CGColor;
    if (self.num==1) {
//        [self addCenterLabelWithTitle:@"用户注册" titleColor:[UIColor whiteColor]];
        [self.nextButton setTitle:[NSString stringWithFormat:@"下一步"] forState:UIControlStateNormal];
    }else{
//        [self addCenterLabelWithTitle:@"忘记密码" titleColor:[UIColor whiteColor]];
        [self.nextButton setTitle:[NSString stringWithFormat:@"提交"] forState:UIControlStateNormal];
    }
    
    self.naviBarView.backgroundColor = [UIColor clearColor];
    self.totalTime = 60;
    // Do any additional setup after loading the view from its nib.
}

-(void)requestRegData
{
    
 
    
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:hud];
    [self.view bringSubviewToFront:hud];
    hud.labelText = @"拼命加载中";
    hud.removeFromSuperViewOnHide = YES;
    [hud show:YES];
    //action、value
    NSDictionary *dic = @{
                          @"phone":[NSString stringWithFormat:@"%@",self.telTextField.text],
                          @"password":[NSString stringWithFormat:@"%@",self.passwordField.text],
                          @"code":[NSString stringWithFormat:@"%@",self.codeTextField.text]
                          };
    
    NSError *dataError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:(NSJSONWritingOptions)0 error:&dataError];
    NSString *body = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    DLog(@"%@",body);
    NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [data base64EncodedStringWithOptions:0];
    DLog(@"%@",base64String);
    
    NSDictionary *parameter= @{
                               @"action":[NSString stringWithFormat:@"Base/User/lawyer_reg"],
                               @"value":base64String
                               };
    
    DLog(@"%@",parameter);
    WS(ws);
    [AFManagerHelp POST:BASE_URL parameters:parameter success:^(id responseObjeck) {
        // 处理数据
        DLog(@"%@",responseObjeck);
        [hud hide:YES];
        if ([responseObjeck[@"status"] integerValue] == 0) {
            
            
            
            if (self.num==1) {
                
//                [UD setValue:[NSString stringWithFormat:@"%@",responseObjeck[@"data"] [@"id"]] forKey:@"userid"];
//                [UD setValue:[NSString stringWithFormat:@"%@",responseObjeck[@"data"] [@"phone"]] forKey:@"phone"];
//                [UD setValue:[NSString stringWithFormat:@"%@",ws.passwordField.text] forKey:@"pass"];
//
                [ShowHUD showWYBTextOnly:@"注册成功" duration:2 inView:ws.view];
                PerfectViewController *perVC = [[PerfectViewController alloc] init];
                perVC.PersonId = [NSString stringWithFormat:@"%@",responseObjeck[@"data"] [@"id"]];
                [self.navigationController pushViewController:perVC animated:YES];
            }else{
                [ShowHUD showWYBTextOnly:@"找回密码成功" duration:2 inView:ws.view];
                [self.navigationController popViewControllerAnimated:YES];
                
            }
            
            
        }else{
            [ShowHUD showWYBTextOnly:responseObjeck[@"msg"] duration:2 inView:ws.view];
        }
    } failure:^(NSError *error) {
        [hud hide:YES];
        [ShowHUD showWYBTextOnly:@"你的网络好像不太给力\n请稍后再试" duration:2 inView:ws.view];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)codeBtnClick:(id)sender {
 
    
    if(self.telTextField.text.length ==11){
        [self  requestCodeData];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请输入正确的手机号" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];

    }
}

-(void)requestCodeData
{
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:hud];
    [self.view bringSubviewToFront:hud];
    hud.labelText = @"拼命加载中";
    hud.removeFromSuperViewOnHide = YES;
    [hud show:YES];
    //action、value
    NSDictionary *dic = @{
                          @"phone":[NSString stringWithFormat:@"%@",self.telTextField.text]
                          };
    
    NSError *dataError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:(NSJSONWritingOptions)0 error:&dataError];
    NSString *body = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    DLog(@"%@",body);
    NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [data base64EncodedStringWithOptions:0];
    DLog(@"%@",base64String);
    
    NSDictionary *parameter= @{
                               @"action":[NSString stringWithFormat:@"Base/User/lawyer_get_code"],
                               @"value":base64String
                               };
    
    DLog(@"%@",parameter);
    WS(ws);
    [AFManagerHelp POST:BASE_URL parameters:parameter success:^(id responseObjeck) {
        // 处理数据
        DLog(@"%@",responseObjeck);
        [hud hide:YES];
        if ([responseObjeck[@"status"] integerValue] == 0) {
            
            
            [ShowHUD showWYBTextOnly:@"发送成功" duration:2 inView:ws.view];
            [self startTime];
            
        }else{
            [ShowHUD showWYBTextOnly:responseObjeck[@"msg"] duration:2 inView:ws.view];
        }
    } failure:^(NSError *error) {
        [hud hide:YES];
        [ShowHUD showWYBTextOnly:@"你的网络好像不太给力\n请稍后再试" duration:2 inView:ws.view];
    }];
}

- (IBAction)xieyiBtnClick:(id)sender {
    //跳转到协议界面
    QJCXieYiVc * xiyivc =[[QJCXieYiVc alloc] init];
    [self.navigationController pushViewController:xiyivc  animated:YES];
}

- (IBAction)xieyiSureBtnClick:(id)sender {
    //同意协议
    self.xiyiSureButton.selected = !self.xiyiSureButton.selected;

}
-(BOOL)checkPassWord
{
    //6-20位数字和字母组成
    NSString *regex = @"(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,}";
    NSPredicate *   pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([pred evaluateWithObject:self.passwordField.text]) {
        return YES ;
    }else
        return NO;
}

-(void)registerAction{
    NSLog(@"===%@",self.passwordField.text);
    if (![self checkPassWord]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"密码至少6位且包含字母和数字！" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }else if (self.telTextField.text.length!=11 || ![self.telTextField.text hasPrefix:@"1"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请输入正确的手机号" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }else if (self.codeTextField.text.length==0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请输入正确的验证码" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }else if(!self.xiyiSureButton.selected){
        [self showHint:@"请阅读协议"];
    }else{
        [self requestRegData];
        
    }
 }
-(void)BangDingAction{
    NSLog(@"%@",self.passwordField.text);
    if (self.telTextField.text.length!=11 || ![self.telTextField.text hasPrefix:@"1"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请输入正确的手机号" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }else if (self.codeTextField.text.length==0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请输入正确的验证码" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }else if (![self checkPassWord]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"密码至少6位且包含字母和数字！" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }else if(!self.xiyiSureButton.selected){
        [self showHint:@"请阅读协议"];
    }else{
        [self requestBangDingData];
        
    }
    
}
-(void)requestBangDingData{
    
    NSMutableDictionary * dic  =[[NSMutableDictionary alloc]init];
    QJTBangDingPhone
    NSMutableDictionary * valueDic =[[NSMutableDictionary alloc]init];
    [valueDic setObject: self.type forKey:@"type"];
    [valueDic setObject: self.openid forKey:@"openid"];
    [valueDic setObject: self.telTextField.text forKey:@"phone"];
    [valueDic setObject: self.passwordField.text forKey:@"password"];
    [valueDic setObject: self.codeTextField.text forKey:@"code"];

    
    NSString * baseStr = [NSString getBase64StringWithArray:valueDic];
    [dic setValue:baseStr forKey:@"value"];
    [HttpAfManager postWithUrlString:BASE_URL parameters:dic success:^(id data) {
        NSLog(@"%@",data);
        NSString * status = [NSString stringWithFormat:@"%@",data[@"status"]];
        if ([status isEqualToString:@"0"]) {
            PerfectViewController *perVC = [[PerfectViewController alloc] init];
            perVC.PersonId = [NSString stringWithFormat:@"%@",data[@"data"] [@"id"]];
            [self.navigationController pushViewController:perVC animated:YES];
            
        }else{
            [self showHint:data[@"msg"]];
        }
        
    } failure:^(NSError *error) {
        
        [self showHint:@"绑定手机号失败"];
        
    }];
    
}
- (IBAction)nextButtonClick:(id)sender {
    
    if (self.num  == 1) {// 注册
        [self registerAction];
    }else{// 绑定手机号
        [self BangDingAction];
        
    }
}


#pragma mark --60秒内只能点击一次---
-(void)startTime
{
    //创建定时器
    self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(time:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    [self.timer fire];
}

//定时器的循环事件
-(void)time:(NSTimer *)timer
{
    _totalTime = _totalTime - 1;
    NSNumber *number = [NSNumber numberWithInteger:_totalTime];
    NSString *text = [NSString stringWithFormat:@"%@重新获取",number];
    [self.codeButton setTitle:text forState:UIControlStateNormal];
    if(_totalTime == 0)
    {
        [timer invalidate];
        timer = nil;
        self.codeButton.userInteractionEnabled = YES;
        _totalTime = 60;
        [self.codeButton setTitle:[NSString stringWithFormat:@"重新获取"] forState:UIControlStateNormal];
        [self.codeButton setTitleColor:[UIColor colorWithRed:146/255.0 green:60/255.0 blue:53/255.0 alpha:1] forState:UIControlStateNormal];

        return;
    }
}

@end

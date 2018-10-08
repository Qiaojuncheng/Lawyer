//
//  LoginViewController.m
//  TheLawyer
//
//  Created by yaoyao on 17/8/3.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//
#import "LoginViewController.h"
#import "MyInfoModel.h"
#import "RegisteredViewController.h"
#import "RPWordController.h"
#import "PerfectViewController.h"
#import <UMSocialCore/UMSocialCore.h>
#import "PerfectViewController.h"
#import "QJCXieYiVc.h"

@interface LoginViewController ()
@property (nonatomic,strong) MyInfoModel *infoModel;
@end
@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [Utile makeCorner:10 view: self.CoreView];
    [Utile makecorner:2 view: self.CoreView color:[UIColor colorWithHex:0xececec]];
    self.naviBarView.hidden = YES;
    self.telTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.loginButton.layer.masksToBounds = YES;
    self.loginButton.layer.cornerRadius =5;
    self.loginButton.layer.borderWidth =.5;
    self.loginButton.layer.borderColor = [UIColor clearColor].CGColor;
    self.navigationController.hidesBottomBarWhenPushed = NO;

}


-(void)requestLoginData
{

 if(self.telTextField.text.length==11&&self.passwordField.text.length>0&&[REGEX evaluateWithObject:self.telTextField.text]) {
        [self requstLogin];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请输入正确的用户名和密码" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }

}

-(void)requstLogin
{
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:hud];
    [self.view bringSubviewToFront:hud];
    hud.labelText = @"拼命加载中";
    hud.removeFromSuperViewOnHide = YES;
    [hud show:YES];
    //action、value
    NSString * UUid  = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    UUid =[UUid stringByReplacingOccurrencesOfString:@"-" withString:@""];
    UUid = [UUid stringByAppendingString:self.telTextField.text];
    NSDictionary *dic = @{
                          @"phone":[NSString stringWithFormat:@"%@",self.telTextField.text],
                          @"password":[NSString stringWithFormat:@"%@",self.passwordField.text]
                          ,
                          @"uuid":UUid
                          };
    
    NSError *dataError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:(NSJSONWritingOptions)0 error:&dataError];
    NSString *body = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    DLog(@"%@",body);
    NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [data base64EncodedStringWithOptions:0];
    DLog(@"%@",base64String);
    
    NSDictionary *parameter= @{
                               @"action":[NSString stringWithFormat:@"Base/User/lawyer_login"],
                               @"value":base64String
                               };
    
    DLog(@"%@",parameter);
    WS(ws);
    [AFManagerHelp POST:BASE_URL parameters:parameter success:^(id responseObjeck) {
        // 处理数据
        DLog(@"%@",responseObjeck);
        [hud hide:YES];
        if ([responseObjeck[@"status"] integerValue] == 0) {
            ws.infoModel = [MyInfoModel mj_objectWithKeyValues:responseObjeck[@"data"]];
            [self SendLocation:[NSString stringWithFormat:@"%@",responseObjeck[@"data"][@"id"]]];
            NSString * step =[NSString stringWithFormat:@"%@",responseObjeck[@"data"][@"step"]];
            [UD setValue:[NSString stringWithFormat:@"%@",responseObjeck[@"data"][@"phone"]] forKey:@"phone"];
            [UD setValue:[NSString stringWithFormat:@"%@",ws.passwordField.text] forKey:@"pass"];

            if ([step isEqualToString:@"1"]) {// 去完善信息
                
                PerfectViewController *perVC = [[PerfectViewController alloc] init];
                perVC.PersonId = [NSString stringWithFormat:@"%@",responseObjeck[@"data"][@"id"]];
                [self.navigationController pushViewController:perVC animated:YES];
 
            }else{
                
                [UD setValue:[NSString stringWithFormat:@"%@",responseObjeck[@"data"][@"id"]] forKey:@"userid"];
                [UD setValue:[NSString stringWithFormat:@"%@",responseObjeck[@"data"][@"lawyer_id"]] forKey:@"lawyer_id"];
                
                [UD synchronize];

                [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINSUCCESS object:@(YES)];

            }
            [UD synchronize];

            
            
        }else{
            [ShowHUD showWYBTextOnly:responseObjeck[@"msg"] duration:2 inView:ws.view];
        }
    } failure:^(NSError *error) {
        [hud hide:YES];
        [ShowHUD showWYBTextOnly:@"你的网络好像不太给力\n请稍后再试" duration:2 inView:ws.view];
    }];
}
-(void)loginSuccessBlock:(void (^)(MyInfoModel *infModel))Block
{
    loginSuccessBlock = [Block copy];
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

- (IBAction)loginBtnClick:(id)sender {
    [self requestLoginData];
}

-(void)SendLocation:(NSString * )personId{
    if ([personId length] > 0) {
        NSMutableDictionary * dic  =[[NSMutableDictionary alloc]init];
        QJCLayerLOCATION
        NSMutableDictionary *   valueDic =[[NSMutableDictionary alloc]init];
        NSString * locataionStr =[NSString stringWithFormat:@"%@,%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"latitude"],[[NSUserDefaults standardUserDefaults]objectForKey:@"longitude"]];
        
        [valueDic setObject:locataionStr forKey:@"position" ];
        [valueDic setObject:personId  forKey:@"user_id" ];
        
        NSString * baseStr = [NSString getBase64StringWithArray:valueDic];
        [dic setValue:baseStr forKey:@"value"];
        [HttpAfManager postWithUrlString:BASE_URL parameters:dic success:^(id data) {
            NSLog(@"%@",data);
            
            
        } failure:^(NSError *error) {
            
        }];
        
    }
    
}



- (IBAction)forgetPasswordBtnClick:(id)sender {
    RPWordController *forgetVC = [[RPWordController alloc] init];
     [self.navigationController pushViewController:forgetVC animated:YES];
}

- (IBAction)reginBtnClick:(id)sender {
    RegisteredViewController *regVC = [[RegisteredViewController alloc] init];
    regVC.num =1;
    [self.navigationController pushViewController:regVC animated:YES];
    
}

- (IBAction)QQlongin:(id)sender {
    [self getUserInfoForPlatform:UMSocialPlatformType_QQ];
}

- (IBAction)WXLogin:(id)sender {
    [self getUserInfoForPlatform:UMSocialPlatformType_WechatSession];

}

- (void)getUserInfoForPlatform:(UMSocialPlatformType)platformType
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:self completion:^(id result, NSError *error) {
        
        UMSocialUserInfoResponse *resp = result;
        
        if ([NSString changeNullString:resp.uid].length ==0) {
            return  ;
        }
        // 第三方登录数据(为空表示平台未提供)
        // 授权数据
        NSLog(@" uid: %@", resp.uid);
        NSLog(@" openid: %@", resp.openid);
        NSLog(@" accessToken: %@", resp.accessToken);
        NSLog(@" refreshToken: %@", resp.refreshToken);
        NSLog(@" expiration: %@", resp.expiration);
        
        // 用户数据
        NSLog(@" name: %@", resp.name);
        NSLog(@" iconurl: %@", resp.iconurl);
        NSLog(@" gender: %@", resp.unionGender);
        
        // 第三方平台SDK原始数据
        NSLog(@" originalResponse: %@", resp.originalResponse);
        if (platformType == UMSocialPlatformType_QQ) {
            [self LoginWith:resp.openid andtype:@"2"];

        }else{
            [self LoginWith:resp.openid andtype:@"1"];
            
        }
        
        
    }];
}
-(void)LoginWith:(NSString *)openId andtype:(NSString * )type{
    NSString * UUid  = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    UUid =[UUid stringByReplacingOccurrencesOfString:@"-" withString:@""];
    UUid = [UUid stringByAppendingString:self.telTextField.text];

    [self showHint:@"正在加载"];
    NSMutableDictionary * dic  =[[NSMutableDictionary alloc]init];
    QJTHREELOGIN
    NSMutableDictionary *   valueDic =[[NSMutableDictionary alloc]init];
    [valueDic setObject:openId forKey:@"openid" ];
    [valueDic setObject:type  forKey:@"type" ];
    [valueDic setObject:UUid  forKey:@"uuid" ];

    NSString * baseStr = [NSString getBase64StringWithArray:valueDic];
    [dic setValue:baseStr forKey:@"value"];
    [HttpAfManager postWithUrlString:BASE_URL parameters:dic success:^(id data) {
        NSLog(@"%@",data);
        if ([data[@"status"] isEqualToString:@"200"]) {// 绑定手机号，
            RegisteredViewController *regVC = [[RegisteredViewController alloc] init];
            regVC.num = 2;
            regVC.type = type;
            regVC.openid = openId;
             [self.navigationController pushViewController:regVC animated:YES];
        }else{
            //            step  // 1 完善  2  登录成功；

            if ([data[@"data"][@"step"] isEqualToString:@"1"]) {// 去完善，
                 PerfectViewController *perVC = [[PerfectViewController alloc] init];
                perVC.PersonId = [NSString stringWithFormat:@"%@",data[@"data"] [@"id"]];
                [self.navigationController pushViewController:perVC animated:YES];
                
            }else{
                [UD setValue:[NSString stringWithFormat:@"%@",data[@"data"][@"phone"]] forKey:@"phone"];
                [UD setValue:[NSString stringWithFormat:@"%@",self.passwordField.text] forKey:@"pass"];
                [UD setValue:[NSString stringWithFormat:@"%@",data[@"data"][@"id"]] forKey:@"userid"];
                [UD setValue:[NSString stringWithFormat:@"%@",data[@"data"][@"lawyer_id"]] forKey:@"lawyer_id"];

                [UD synchronize];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINSUCCESS object:@(YES)];
                
            }
        }
        [self hideHud];
    } failure:^(NSError *error) {
        [self hideHud];

    }];

    
}


@end

//
//  IntegralViewController.m
//  TheLawyer
//
//  Created by yaoyao on 17/7/28.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import "IntegralViewController.h"
#import "JifenModel.h"

@interface IntegralViewController ()
@property (nonatomic,strong) JifenModel *jifenModel;

@end

@implementation IntegralViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        [self addCenterLabelWithTitle:@"积分等级" titleColor:[UIColor whiteColor]];
    [self requstJifenData];
    // Do any additional setup after loading the view from its nib.
}
-(void)requstJifenData
{
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:hud];
    [self.view bringSubviewToFront:hud];
    hud.labelText = @"拼命加载中";
    hud.removeFromSuperViewOnHide = YES;
    [hud show:YES];
    //action、value
    NSDictionary *dic = @{
                          @"user_id":UserId//[UD objectForKey:@"userid"]
                          };
    
    NSError *dataError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:(NSJSONWritingOptions)0 error:&dataError];
    NSString *body = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    DLog(@"%@",body);
    NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [data base64EncodedStringWithOptions:0];
    DLog(@"%@",base64String);
    
    NSDictionary *parameter= @{
                               @"action":[NSString stringWithFormat:@"App/Lawyer/credit"],
                               @"value":base64String
                               };
    
    DLog(@"%@",parameter);
    WS(ws);
    [AFManagerHelp POST:BASE_URL parameters:parameter success:^(id responseObjeck) {
        // 处理数据
        DLog(@"%@",responseObjeck);
        [hud hide:YES];
        if ([responseObjeck[@"status"] integerValue] == 0) {

            ws.jifenModel = [JifenModel mj_objectWithKeyValues:responseObjeck[@"data"]];
            self.jifenLable.text = [NSString stringWithFormat:@"%ld积分",(long)ws.jifenModel.zongjifen];
            self.dengjiL.text = [NSString stringWithFormat:@"%@级",ws.jifenModel.level];
            self.jifenAllLable.text = [NSString stringWithFormat:@"%ld分",(long)ws.jifenModel.zongjifen];
            self.zixunJifenL.text = [NSString stringWithFormat:@"%ld积分",(long)ws.jifenModel.zixunjifen];
            self.yuyueLable.text = [NSString stringWithFormat:@"%ld积分",(long)ws.jifenModel.yuyuejifen];
            self.pinglunLable.text = [NSString stringWithFormat:@"%ld积分",(long)ws.jifenModel.pinlunjifen];
            
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

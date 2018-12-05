//
//  MineViewController.m
//  TheLawyer
//
//  Created by yaoyao on 17/7/24.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import "MineViewController.h"
#import "HeaderCell.h"
#import "MidddleCell.h"
#import "BottomCell.h"
#import "SetViewController.h"
#import "QJAboutAppViewController.h"
#import "LevelViewController.h"
#import "IntegralViewController.h"//积分
#import "RecordViewController.h"
#import "LoginViewController.h"
#import "LawLogionViewController.h"
#import "AppointmentViewController.h"//
#import "MyMessageViewController.h"//
#import "ConsultingViewController.h"//咨询
#import "QJCappointmentVC.h"
#import "QJTiXianViewController.h"


@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate>{
    
    NSUserDefaults * UserDefault;
}
@property(nonatomic,strong) UITableView *tableView;

@property (nonatomic,assign) BOOL ifLogin;
//@property (nonatomic,strong) ShowHUD *hud;

@end

@implementation MineViewController

- (void)initMainViewControllerNavView
{
    [self addCenterLabelWithTitle:@"个人中心" titleColor:[UIColor whiteColor]];

}

- (MyInfoModel *)infoModel {
    if (!_infoModel) {
        _infoModel = [[MyInfoModel alloc] init];
    }
    return _infoModel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UserDefault = [NSUserDefaults standardUserDefaults];
//    self.naviBarView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.tableView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ReloadTv) name:@"UPMINEUI" object:nil];
    [self addLeftButtonWithImage:@"nav_share" preImg:@"nav_share" actionBlock:^{
        [self showShare];
    }];

    [self initMainViewControllerNavView];
}
//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    NSString *userId = [UD objectForKey:@"userid"];
//    DLog(@"%@",userId);
//    if (userId) {
//        self.ifLogin = YES;
//        [self requestData];
//    }else{
//        self.ifLogin = NO;
//        self.tableView.hidden = NO;
//        [self.tableView reloadData];
//    }
//}
-(void)ReloadTv{
    [_tableView reloadData];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    [_tableView reloadData];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *uid =[user objectForKey:@"userid"];//userID
    if (uid.length == 0) {
//        self.tableView.hidden = YES;
//        LoginViewController *view = [LoginViewController new];
//        UINavigationController * na= [[UINavigationController alloc]initWithRootViewController:view];
//        [UIApplication sharedApplication].delegate.window.rootViewController = na;
        LawLogionViewController *view = [LawLogionViewController new];
        UINavigationController * na= [[UINavigationController alloc]initWithRootViewController:view];
        [UIApplication sharedApplication].delegate.window.rootViewController = na;
        
    }else{
        
        [self requestData];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
// TableView
- (UITableView *)tableView {
    if (!_tableView) {
        if (SCREENWIDTH>375) {
            _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,NavStatusBarHeight, SCREENWIDTH, SCREENHEIGHT-NavTabBarHeight - NavStatusBarHeight) style:UITableViewStyleGrouped];
        }else{
            _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,NavStatusBarHeight, SCREENWIDTH, SCREENHEIGHT-NavTabBarHeight -NavStatusBarHeight ) style:UITableViewStyleGrouped];
        }
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
         _tableView.hidden = YES;
        // 设置代理对象
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        // 注册
         [_tableView registerClass:[MidddleCell class] forCellReuseIdentifier:@"MidddleCell"];
        [_tableView registerClass:[BottomCell class] forCellReuseIdentifier:@"BottomCell"];
    }
    
    return _tableView;
}

#pragma mark 数据处理
//1058
- (void)requestData {
 
    
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:hud];
    [self.view bringSubviewToFront:hud];
    hud.labelText = @"拼命加载中";
    hud.removeFromSuperViewOnHide = YES;
    [hud show:YES];
    
      //action、value
    NSDictionary *dic = @{
                          @"user_id":UserId,
                           };
    NSError *dataError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:(NSJSONWritingOptions)0 error:&dataError];
    NSString *body = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    DLog(@"%@",body);
    NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [data base64EncodedStringWithOptions:0];
    DLog(@"%@",base64String);
    
    NSDictionary *parameter= @{
                               @"action":[NSString stringWithFormat:@"App/Lawyer/ziliao"],
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
            ws.tableView.hidden  = NO;
            [ws.tableView reloadData];
            
        }else{
            [ShowHUD showWYBTextOnly:responseObjeck[@"msg"] duration:2 inView:ws.view];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [hud hide:YES];
        [ShowHUD showWYBTextOnly:@"你的网络好像不太给力\n请稍后再试" duration:2 inView:ws.view];
    }];
}
#pragma mark -- UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else   {
        return 4;
    }
 }
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0&&indexPath.row ==0) {
        return 230;
    } else{
        return 44;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.001;
    }
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0&&indexPath.row == 0) {
        HeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HeaderCell"];
        if (cell == nil) {
            cell  =[[[NSBundle mainBundle]loadNibNamed:@"HeaderCell" owner:self options:nil]lastObject];
        }
        cell.infoModel = self.infoModel;
        WS(ws);

#pragma mark  我的咨询  预约  服务列表
//        我的咨询
        [cell.ConsultView whenTapped:^{
            NSLog(@"我的咨询");
            [UserDefault setObject:@"no" forKey:@"MyCounsment"];
           

            ConsultingViewController *consult  = [[ConsultingViewController alloc] init];
            [ws.navigationController pushViewController:consult animated:YES];
        }];
        [cell.ReservationView whenTapped:^{
            [UserDefault setObject:@"no" forKey:@"MyAppoinment"];
//            NSLog(@"我的预约");
//             AppointmentViewController *apit  = [[AppointmentViewController alloc] init];
//            [ws.navigationController pushViewController:apit animated:YES];
#pragma mark  我的预约

            QJCappointmentVC * avc =[[QJCappointmentVC alloc]init];
            avc.TitleStr =@"我的预约";
            avc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:avc animated:YES];
        
        }];
//        我的服务
        [cell.ServiceView whenTapped:^{
            RecordViewController *record  = [[RecordViewController alloc] init];
            record.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:record animated:YES];
            [UserDefault setObject:@"no" forKey:@"MyService"];

            NSLog(@"我的服务");
         }];
        [cell.TiXianLB whenTapped:^{
            QJTiXianViewController * tx =[[QJTiXianViewController alloc]initWithNibName:@"QJTiXianViewController" bundle:[NSBundle mainBundle]];
            tx.moneyString =  self.infoModel.money;
            tx.hidesBottomBarWhenPushed=  YES;
            [self.navigationController pushViewController:tx animated:nil];
        }];
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
         return cell;
    }else {
        BottomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BottomCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row==0) {
            cell.NameLabel.text = @"我的消息";
            cell.leftImage.image = [UIImage imageNamed:@"我的消息"];
        }else if (indexPath.row ==1){
            cell.NameLabel.text = @"积分等级";
            cell.leftImage.image = [UIImage imageNamed:@"好评积分"];
           
        } else if (indexPath.row ==2){
            cell.NameLabel.text = @"关于汇融法";
            cell.leftImage.image = [UIImage imageNamed:@"关于汇融法"];
        }else{
            cell.NameLabel.text = @"设置";
            cell.leftImage.image = [UIImage imageNamed:@"设置"];
        }
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [PublicMethod jumpLoginViewControllerBlock:^{
        if (indexPath.section == 1 ) {
            // 设置选中动画
            //        [tableView deselectRowAtIndexPath:indexPath animated:NO];
            
            if (indexPath.row == 0) {
                self.tabBarController.selectedIndex = 1;
            
            }else if (indexPath.row ==1){
                IntegralViewController *integ = [[IntegralViewController alloc]init];
                [self.navigationController pushViewController:integ animated:YES];

             
            } else if (indexPath.row ==2){
                QJAboutAppViewController * about= [[QJAboutAppViewController alloc] initWithNibName:@"QJAboutAppViewController" bundle:[NSBundle mainBundle]];
                [self.navigationController pushViewController:about animated:YES];
                
            }else{
                SetViewController *setVc= [[SetViewController alloc] init];
                [self.navigationController pushViewController:setVc animated:YES];
            }
        }
//    }];
}






-(void)showShare{
    
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine)]];
    
    //    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_Sina),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_WechatSession)]];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        [self shareWitType:platformType];
    }];
    
    
}
-(void)shareWitType:(UMSocialPlatformType *)platformType{
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"汇融法律师端"  descr:@"汇融法致力于打造“互联网新生态”律师，平台利用先进的O2O方法，将分散、繁杂的线下法律服务需求及资源整合至线上，为当事人及律师搭建在线沟通、文件传输、公证签约、款项支付以及争端解决等全方位服务的桥梁。" thumImage:[UIImage imageNamed:@"1024icon"]];
    //设置网页地址
    shareObject.webpageUrl = [NSString stringWithFormat:@"http://www.huirongfa.com/Wap/Index/down_app.html"];
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
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

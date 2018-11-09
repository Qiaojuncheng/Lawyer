//
//  AppDelegate.m
//  TheLawyer
//
//  Created by yaoyao on 17/7/18.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//



#import "AppDelegate.h"
#import "IQKeyboardManager.h"
#import "LoginViewController.h"
#import "LawLogionViewController.h"
 #import <UMSocialCore/UMSocialCore.h>
#import <UShareUI/UShareUI.h>
#import "LawMineVc.h"
//AVCaptureDevice
//#import <AVFoundation/AVAudioSession.h>

#import "LawMainPageViewController.h"
#import "LawSquarSrviceViewController.h"
#import "LawCaseAppreciateViewController.h"
// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
   #import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
  #import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件

#import <AudioToolbox/AudioServices.h>
#import <AudioToolbox/AudioToolbox.h>

// 高德地图
#import "AMapServices.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>





static SystemSoundID shake_sound_male_id = 0;



@interface AppDelegate ()<AMapLocationManagerDelegate,JPUSHRegisterDelegate>{
//    BMKMapManager *  _mapManager  ;
//    //初始化BMKLocationService
//    BMKLocationService *  _locService ;
    NSUserDefaults * UserDefaults;
    AMapLocationManager * _locationManager;

}

@end

@implementation AppDelegate

-(void)newTabBarViewController
{
    
    //首页
    UITabBarItem *homeItem=[[UITabBarItem alloc]initWithTitle:@"首页" image:[[UIImage imageNamed:@"bar_my_grey"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"bar_home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [self unSelectedTapTabBarItems:homeItem];
    [self selectedTapTabBarItems:homeItem];
    
    BaseNavigationController *homeNav=[[BaseNavigationController alloc]initWithRootViewController:[[LawMainPageViewController alloc]init]];
    homeNav.tabBarItem = homeItem;
    [homeNav setNavigationBarHidden:YES];
    
 
        UITabBarItem *ServiceItem=[[UITabBarItem alloc]initWithTitle:@"服务广场" image:[[UIImage imageNamed:@"bar_square_grey"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"bar_square"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [self unSelectedTapTabBarItems:ServiceItem];
        [self selectedTapTabBarItems:ServiceItem];
    
    LawSquarSrviceViewController * adsListVc =[[LawSquarSrviceViewController alloc]init];
    BaseNavigationController *serviceNav=[[BaseNavigationController alloc]initWithRootViewController:adsListVc];
    adsListVc.ServiceTitle = @"服务广场";

    serviceNav.tabBarItem = ServiceItem;
    [serviceNav setNavigationBarHidden:YES];
    
    
    //wode
    UITabBarItem *centerItem=[[UITabBarItem alloc]initWithTitle:@"案件欣赏" image:[[UIImage imageNamed:@"bar_case_grey"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"bar_case"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [self unSelectedTapTabBarItems:centerItem];
    [self selectedTapTabBarItems:centerItem];

    BaseNavigationController *mineNav=[[BaseNavigationController alloc]initWithRootViewController:[[LawCaseAppreciateViewController alloc]init]];
    mineNav.tabBarItem = centerItem;
    [mineNav setNavigationBarHidden:YES];
    
    
    
    
    //wode
    UITabBarItem *MineItem=[[UITabBarItem alloc]initWithTitle:@"我的" image:[[UIImage imageNamed:@"bar_my_grey"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"bar_my"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [self unSelectedTapTabBarItems:MineItem];
    [self selectedTapTabBarItems:MineItem];
    
    BaseNavigationController *MineNav=[[BaseNavigationController alloc]initWithRootViewController:[[LawMineVc alloc]init]];
    MineNav.tabBarItem = MineItem;
    [MineNav setNavigationBarHidden:YES];
    
    
    
    //设置tabBarController
    _tabBarController=[[UITabBarController alloc]init];
    _tabBarController.viewControllers=@[homeNav,serviceNav,mineNav,MineNav];
    _tabBarController.selectedIndex = 0;
    //    _tabBarController.tabBar.backgroundColor=WKColor(250, 250, 250);//tabBarBackgroundColor;
//    _tabBarController.delegate = self;
    //[self.tabBar setClipsToBounds:YES];
    
    
    [_tabBarController.tabBar setClipsToBounds:YES];    
    self.window.rootViewController = _tabBarController;
    //注册登录状态监听

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginStateChange:)
                                                 name:KNOTIFICATION_LOGINSUCCESS
                                               object:nil];

#pragma    mark   判断是不是 第一次登陆
    BOOL  isFirst =  YES;
    isFirst =( BOOL )[[NSUserDefaults standardUserDefaults]  boolForKey:@"MMIsFirst"];
 
    if (!isFirst) {
        
             [UserDefaults setBool:YES forKey:@"constultN"];
             [UserDefaults setBool:YES  forKey:@"headerN"];
             [UserDefaults setBool:YES  forKey:@"phoneN"];
             [UserDefaults setBool:YES  forKey:@"meetN"];
             [UserDefaults setBool:YES  forKey:@"servicN"];
        [UserDefaults synchronize];
        GuideViewController * gvc =[[GuideViewController alloc]init];
        self.window.rootViewController  = gvc;
    }else{
//        if (IsLogin) {
//            MtabBatrC *Tab =[[MtabBatrC alloc]init];
            //    UINavigationController *MainNavi =[[UINavigationController alloc]initWithRootViewController:Tab];
            self.window.rootViewController = _tabBarController;
//        }else{
////            LoginViewController *view = [[LoginViewController alloc]init];
////            UINavigationController * na= [[UINavigationController alloc]initWithRootViewController:view];
//            LawLogionViewController *view = [LawLogionViewController new];
//            UINavigationController * na= [[UINavigationController alloc]initWithRootViewController:view];
// 
//            self.window.rootViewController = na;
//        }
}}

- (void)loginStateChange:(NSNotification *)notification{
//    [_locService startUserLocationService];
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];

    self.window.rootViewController = _tabBarController;
}
-(void)locationAction{
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];

    
//    [_locService startUserLocationService];

}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
 
 
   


    NSString * UUid  =   [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    UUid =[UUid stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    UUid =  [UUid stringByAppendingString:UserPhone];
    [JPUSHService getAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        NSLog(@"-- iAlias = %@ ",iAlias);
    } seq:[UUid integerValue]];
    
    [self getPhone];
    [AMapServices sharedServices].apiKey =@"f30884433ae0b3dad45ee35344d0c73f";
//    [AMapLocationServices sharedServices].apiKey =@"03007e10d3a5591475445e5b4ee45e64";
    _locationManager = [[AMapLocationManager alloc] init];
    _locationManager.delegate = self;

    [_locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];

    
    [_locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
            if (error.code == AMapLocationErrorLocateFailed)
            {
                return;
            }
        }
        
//        上传位置
        if ([UserId length] > 0) {
            NSString *locationstr  = [NSString stringWithFormat:@"%f,%f",location.coordinate.latitude,location.coordinate.longitude];
        NSMutableDictionary * dic =[[NSMutableDictionary alloc]init];
        NewGetLocation
        
        NSMutableDictionary * valueDic =[[NSMutableDictionary alloc]init];
            [valueDic setValue:UserId forKey:@"lawyer_id"];
            [valueDic setValue:locationstr forKey:@"position"];
         NSString * baseStr = [NSString getBase64StringWithArray:valueDic];
        [dic setValue:baseStr forKey:@"value"];
        
        [HttpAfManager postWithUrlString:BASE_URL parameters:dic success:^(id data) {
            NSLog(@"%@",data);
            
           
        } failure:^(NSError *error) {
            
        }];
            
    }

        
        NSLog(@"location:%@", location);
        
//        if (regeocode)
//        {
//            NSLog(@"reGeocode:%@", regeocode);
//        }
    }];
    
//    //初始化BMKLocationService
//    _locService = [[BMKLocationService alloc]init];
//    _locService.delegate = self;
//    //启动LocationService
//    [_locService startUserLocationService];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(locationAction) name:@"LOCATIONACTION" object:nil];

    UserDefaults = [NSUserDefaults standardUserDefaults];
    
 
//    _mapManager = [[BMKMapManager alloc]init];
//    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
//    BOOL ret = [_mapManager start:@"17OEhdYrbCtovNHqCjV8yBhHwmzd2Fyh"  generalDelegate:nil];
//    if (!ret) {
//        NSLog(@"manager start failed!");
//    }
  
   
    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"59f97029f29d981fc9000104"];
    NSLog(@"%@",[UMSocialGlobal umSocialSDKVersion]);
    [self configUSharePlatforms];
    
    [self makeJpushWithApplication:application WithOptions:launchOptions];
    
    
    //关闭设置为NO, 默认值为NO.
    [IQKeyboardManager sharedManager].enable = YES;
    //点击背景收起键盘
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;

    // 版本更新
//    [self checkAppUpdate];
//    
//    // 资源版本
//    [self getResourceVersion];
    
    // 监控网络状态
    [[AFManagerHelp shareAFManagerHelp] openMonitoringNetwork];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self newTabBarViewController];
    
    
    UserDefaults =[NSUserDefaults standardUserDefaults];
    
    NSString * SoundsStr = [UserDefaults  objectForKey:@"Sounds"];
    
    if(SoundsStr == nil){
        [UserDefaults  setObject:@"YES" forKey:@"Sounds"];
        [UserDefaults  setObject:@"YES" forKey:@"vibration"];
        
        [UserDefaults synchronize];
    }

    
    
    
    return YES;
}

#pragma mark - TabBar字体颜色
-(void)unSelectedTapTabBarItems:(UITabBarItem *)tabBarItem
{
    [tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -3)];
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIFont fontWithName:@"Helvetica-Bold" size:10],
                                        NSFontAttributeName,grayTextColor,NSForegroundColorAttributeName,
                                        nil] forState:UIControlStateNormal];
}

-(void)selectedTapTabBarItems:(UITabBarItem *)tabBarItem
{
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIFont fontWithName:@"Helvetica-Bold" size:10],
                                        NSFontAttributeName,MAINCOLOR,NSForegroundColorAttributeName,
                                        nil] forState:UIControlStateSelected];
}
#pragma mark   更新位置
-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    return YES;
}

//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    //NSLog(@"heading is %@",userLocation.heading);
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"%f,%f",userLocation.location.coordinate.longitude,userLocation.location.coordinate.latitude);
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude] forKey:@"latitude"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude] forKey:@"longitude"];
    [[NSUserDefaults standardUserDefaults] synchronize];

//    [_locService stopUserLocationService];
    [self SendLocation];
    //NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
}

-(void)SendLocation{
    if ([UserId length] > 0) {
        NSMutableDictionary * dic  =[[NSMutableDictionary alloc]init];
        QJCLayerLOCATION
        NSMutableDictionary *   valueDic =[[NSMutableDictionary alloc]init];
        NSString * locataionStr =[NSString stringWithFormat:@"%@,%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"latitude"],[[NSUserDefaults standardUserDefaults]objectForKey:@"longitude"]];
        
        [valueDic setObject:locataionStr forKey:@"position" ];
        [valueDic setObject:UserId  forKey:@"user_id" ];
        
        NSString * baseStr = [NSString getBase64StringWithArray:valueDic];
        [dic setValue:baseStr forKey:@"value"];
        [HttpAfManager postWithUrlString:BASE_URL parameters:dic success:^(id data) {
            NSLog(@"%@",data);
            
            
        } failure:^(NSError *error) {
            
        }];
        
    }
    
}
- (void)configUSharePlatforms
{
    /*
     设置微信的appKey和appSecret
     [微信平台从U-Share 4/5升级说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_1
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx11085892ff09693b" appSecret:@"d44da300010fb6bafbb39510979fd223" redirectURL:nil];
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     100424468.no permission of union id
     [QQ/QZone平台集成说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_3
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"101437408"/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    
 
}
// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

-(void)makeJpushWithApplication:(UIApplication *)application  WithOptions:(NSDictionary *)launchOptions {
    //Required
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
   
    
    // Required
    // init Push
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
//
    [JPUSHService setupWithOption:launchOptions appKey:@"d8410e73b0c3c2f5705c1b4c"
                          channel:@"123123"
                 apsForProduction:YES  // 0 (默认值)表示采用的是开发证书，1 表示采用生产证书发布应用。
            advertisingIdentifier:@""];
    
   
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
    //     登录状态改变， 更新alisa 别名
    [defaultCenter addObserver:self selector:@selector(setalias) name:KNOTIFICATION_LOGINSUCCESS object:nil];
    
  }
#pragma mark 设置别名
-(void)setalias{
//    NSString * userid =[[NSUserDefaults standardUserDefaults] objectForKey:@"lawyer_id"];
    NSString * UUid  =   [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    UUid =[UUid stringByReplacingOccurrencesOfString:@"-" withString:@""];
  
   UUid =  [UUid stringByAppendingString:UserPhone];
    NSString * md5Str = [UUid MD5];
 
     [JPUSHService setAlias:md5Str completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        NSLog(@" iResCode = %ld, iAlias = %@  seq = %ld",(long)iResCode,iAlias,(long)seq);
    } seq:[UUid integerValue]];
    
 
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
    [self NOtificationWithDic:userInfo];
    // 如果是在应用内收到通知 就在通知栏清除本条通知  避免在导航栏收到通知后在执行一次
    [[UNUserNotificationCenter currentNotificationCenter] removeDeliveredNotificationsWithIdentifiers:@[notification.request.identifier]];
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
     // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
    [self NOtificationWithDic:userInfo];

}
#pragma mark  极光通知处理
-(void)NOtificationWithDic:(NSDictionary *)userInfo{
    NSString *customizeField1 = [userInfo valueForKey:@"stateNumber"]; //服务端传递的Extras附加字段，key是自己定义的
   
    // 1 咨询回复被采纳 2 收到送心意 3 收到见面预约/电话咨询 4 审核


    
// abcb26fbb93db8c72d4d94ec
//
//
//    if ([customizeField1 isEqualToString:@"1"])//
//    {
//        [UserDefaults setValue:@"yes" forKey:@"MyCounsment"];
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"UPMESSAGEDATA" object:nil];
//    }else if ([customizeField1 isEqualToString:@"2"]){
//        [UserDefaults setValue:@"yes" forKey:@"MyAppoinment"];
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"UPMESSAGEDATA" object:nil];
//    }else if ([customizeField1 isEqualToString:@"3"]){
//        [UserDefaults setValue:@"yes" forKey:@"MyService"];
//    }else if ([customizeField1 isEqualToString:@"4"]){
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"UPGARAT" object:nil];
//    }
//    [UserDefaults synchronize];
//
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"UPMINEUI" object:nil];
//
    

    
}
#pragma mark  极光在线消息处理
- (void)networkDidReceiveMessage:(NSNotification *)notification {
//      437c6ef2430734aca42b27335eec6ae9
    NSDictionary * userInfo = [notification userInfo];
    //    NSString *content = [userInfo valueForKey:@"content"];
    NSDictionary *extras = [userInfo valueForKey:@"extras"];
    NSString *customizeField1 = [extras valueForKey:@"stateNumber"]; //服务端传递的Extras附加字段，key是自己定义的
 
    //  stateNumber    // 1 咨询回复被采纳 2 收到送心意  3 电话咨询  4 收到见面预约 5法律服务 6审核
    if ([customizeField1 isEqualToString:@"1"]) {
        [UserDefaults setBool:NO forKey:@"constultN"];
    }else if ([customizeField1 isEqualToString:@"2"]){
        [UserDefaults setBool:NO  forKey:@"headerN"];
    }else if ([customizeField1 isEqualToString:@"3"]){
        [UserDefaults setBool:NO  forKey:@"phoneN"];
    }else if ([customizeField1 isEqualToString:@"4"]){
        [UserDefaults setBool:NO  forKey:@"meetN"];
    }else if ([customizeField1 isEqualToString:@"5"]){
        [UserDefaults setBool:NO  forKey:@"servicN"];
    }
    
    
    [UserDefaults setValue:customizeField1 forKey:@"stateNumber"];
    
    [UserDefaults synchronize];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PushMessage" object:customizeField1];

    [self playSoundAndVibration];

    
//   暂时不处理 1001 其他设备登录
//    if ([customizeField1 isEqualToString:@"1"])//
//    {
//        [UserDefaults setValue:@"yes" forKey:@"MyCounsment"];
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"UPMESSAGEDATA" object:nil];
//
//    }else if ([customizeField1 isEqualToString:@"2"]){
//        [UserDefaults setValue:@"yes" forKey:@"MyAppoinment"];
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"UPMESSAGEDATA" object:nil];
//
//    }else if ([customizeField1 isEqualToString:@"3"]){
//        [UserDefaults setValue:@"yes" forKey:@"MyService"];
//    }
//    else if ([customizeField1 isEqualToString:@"4"]){
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"UPGARAT" object:nil];
//      }
//    [UserDefaults synchronize];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"UPMINEUI" object:nil];
//
//
//        // 其他设备登录   先清除别名
//        if ([customizeField1 isEqualToString:@"1001"]) {
//            NSLog(@"其他设备登录请 清除别名清除本地数据退出登录");
//            NSUserDefaults * userdefa =[NSUserDefaults standardUserDefaults];
//            [userdefa removeObjectForKey:@"id"];
//            [userdefa removeObjectForKey:@"phone"];
//            [userdefa removeObjectForKey:@"avatar"];
//            [userdefa synchronize];
//            [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
//
//            } seq:[UserId integerValue]];
//
//            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您的账号已在其他设备上登录！" preferredStyle:UIAlertControllerStyleAlert];
//            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                LawLogionViewController *view = [LawLogionViewController new];
//                UINavigationController * na= [[UINavigationController alloc]initWithRootViewController:view];
//
//                self.window.rootViewController = na;
//                NSLog(@"OK Action");
//            }];
//            [alertController addAction:okAction];
//            [self.window.rootViewController presentViewController:alertController animated:YES completion:nil];
//        }
//    NSLog(@"自定义消息  = %@",userInfo);
}


- (void)playSoundAndVibration{
    NSTimeInterval timeInterval = [[NSDate date]
                                   timeIntervalSinceDate:self.lastPlaySoundDate];
    if (timeInterval < kDefaultPlaySoundInterval) {
        //如果距离上次响铃和震动时间太短, 则跳过响铃
        NSLog(@"skip ringing & vibration %@, %@", [NSDate date], self.lastPlaySoundDate);
        return;
    }
    //保存最后一次响铃时间
    self.lastPlaySoundDate = [NSDate date];
    
    NSString * SoundsStr = [UserDefaults  objectForKey:@"Sounds"];
    NSString * Vibrate  =  [UserDefaults  objectForKey:@"vibration"];
    if ([SoundsStr isEqualToString:@"YES"] || SoundsStr == nil) {
        // 收到消息时，播放音频
        [self playNewMessageSound];
    }
    if ([Vibrate isEqualToString:@"YES"] || Vibrate == nil) {
        // 收到消息时，震动
        [self playVibration];
    }
    
}

- (void)playNewMessageSound
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"in" ofType:@"caf"];
    // Path for the audio file
    NSLog(@"path== %@",path);
    if (path) {
        //注册声音到系统
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&shake_sound_male_id);
        AudioServicesPlaySystemSound(shake_sound_male_id);

        AudioServicesPlaySystemSound(shake_sound_male_id);//如果无法再下面播放，可以尝试在此播放
    }

    AudioServicesPlaySystemSound(shake_sound_male_id);   //播放注册的声音，（此句代码，可以在本类中的任意位置调用，不限于本方法中）

}
-(void)playVibration{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);   //让手机震动
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {

 
 
    [UIApplication sharedApplication].applicationIconBadgeNumber = -1;
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [[UIApplication sharedApplication] cancelAllLocalNotifications];

    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
-(void)getPhone{
    
   
    NSMutableDictionary  *dic =[[NSMutableDictionary alloc]init] ;
    NewGetPhone ;
    
    [UserDefaults  setObject:@"400-6400-661" forKey:@"400Phone"];
    [UserDefaults synchronize];

     [AFManagerHelp POST:BASE_URL parameters:dic success:^(id responseObjeck) {
        // 处理数据
         if ([responseObjeck[@"status"] integerValue] == 0){
            [UserDefaults  setObject:[NSString stringWithFormat:@"%@",responseObjeck[@"data"][@"tel"]] forKey:@"400Phone"];

            [UserDefaults synchronize];
        }
        
     } failure:^(NSError *error) {
     }];
}

@end

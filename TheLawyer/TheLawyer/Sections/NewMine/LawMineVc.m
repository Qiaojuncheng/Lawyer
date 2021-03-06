//
//  LawMineVc.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/11.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawMineVc.h"
#import "LawMineCollectCell.h"
#import "LawMineTopView.h"
#import "LawNewSettingViewController.h"
#import "LoginViewController.h"
#import "LawLogionViewController.h"
#import "LawRemainingViewController.h"

#import "LawConSultViewController.h"
#import "LawMeetingViewController.h"
#import "LawSquarSrviceViewController.h"
#import "LawNewHeZuoViewController.h"

#import "LawHeartViewController.h"
#import "LawPackageViewController.h"
#import "LawCollectViewController.h"
#import "LawPersonInfoViewController.h"

#import "QJAboutAppViewController.h"
#import "LawIWantPublicVC.h"
@interface LawMineVc ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    NSMutableArray * CollectitemArray;
    NSMutableArray * CollectitemImageArray;

    CGFloat Topheight;// Top View 的高度
    CGFloat CollectSpace; // 左侧的距离
    
    BOOL showHud; //第一次显示加载框 其他都不显示了
    
}
@property (strong ,nonatomic) UICollectionView * collectionView;
@property (strong ,nonatomic) LawMineTopView * collectionTopView;
@end

@implementation LawMineVc

- (void)viewDidLoad {
    [super viewDidLoad];
    CollectSpace =  0;
    Topheight = 172;
    showHud = YES;
    CollectitemArray = [[NSMutableArray alloc]initWithArray:@[@[@"咨询",@"电话预约",@"见面预约",@"法律服务"],@[@"收藏",@"我要发布",@"客服中心",@"关于汇融法",@"我要合作"]]];
   
    CollectitemImageArray = [[NSMutableArray alloc]initWithArray:@[@[@"main_consult",@"main_telephone",@"main_order",@"main_service"],@[@"my_collect",@"my_release",@"my_customeservice",@"my_about",@"my_cooperation"]]];
    
     self.view.backgroundColor = [UIColor whiteColor];
    MJWeakSelf
 
    [self addRightButtonWithImage:@"nav_setup" preImg:@"nav_setup" actionBlock:^{
        [weakSelf  Pushsetting];
    }];
    
    [self addLeftButtonWithImage:@"nav_share" preImg:@"nav_share" actionBlock:^{
        [self showShare];
    }];

    [self initCollectionView];
//    [self addCenterLabelWithTitle:@"个人中心" titleColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
//     NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSString *uid =[user objectForKey:@"userid"];//userID
//    if (uid.length == 0) {

//        self.tableView.hidden = YES;
//        LoginViewController *view = [LoginViewController new];
//        UINavigationController * na= [[UINavigationController alloc]initWithRootViewController:view];
//        [UIApplication sharedApplication].delegate.window.rootViewController = na;
    
//        LawLogionViewController *view = [LawLogionViewController new];
//        UINavigationController * na= [[UINavigationController alloc]initWithRootViewController:view];
//        [UIApplication sharedApplication].delegate.window.rootViewController = na;
//
//
//
//
//
//    }else{
    if(IsLogin){
        [self requestData];
    }else{
        
        self.infoModel = [[MyInfoModel alloc]init];
        [self.collectionView reloadData];

    }
//    }
}
- (void)requestData {
    
 
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
    if (showHud) {

    [self.view addSubview:hud];
    [self.view bringSubviewToFront:hud];
    hud.labelText = @"拼命加载中";
    hud.removeFromSuperViewOnHide = YES;

    [hud show:YES];
        showHud = NO ;
    }
    
    //action、value
    NSDictionary *valuedic = @{
                          @"lawyer_id":UserId,
                          };
    
   NSString * base64String =[NSString getBase64StringWithArray:valuedic];
 
    NSMutableDictionary  *dic =[[NSMutableDictionary alloc]init] ;
    NewGetInfor ;
    [dic setValue:base64String forKey:@"value"];
     WS(ws);
    [AFManagerHelp POST:BASE_URL parameters:dic success:^(id responseObjeck) {
        // 处理数据
        DLog(@" %@",responseObjeck);
        [hud hide:YES];
        if ([responseObjeck[@"status"] integerValue] == 0) {
            ws.infoModel = [MyInfoModel mj_objectWithKeyValues:responseObjeck[@"data"]];
            [self.collectionView reloadData];
        }else{
            [ShowHUD showWYBTextOnly:responseObjeck[@"msg"] duration:2 inView:ws.view];
        }
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [hud hide:YES];
        [ShowHUD showWYBTextOnly:@"你的网络好像不太给力\n请稍后再试" duration:2 inView:ws.view];
    }];
}

-(void)Pushsetting{
    
    NSLog(@"进入设置");
    if(!IsLogin){
        [self  JumpLoginVIewController];
    }else{
    LawNewSettingViewController  * setting =[[LawNewSettingViewController alloc]init];
    [self.navigationController pushViewController:setting animated:YES];
    }
}

#pragma mark  设置CollectionView的的参数
- (void) initCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.headerReferenceSize = CGSizeMake(0,Topheight);
//    flowLayout.minimumInteritemSpacing =  5 * (SCREENWIDTH/375);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.sectionInset=  UIEdgeInsetsMake(0, 20, 0, 20);
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    //设置CollectionView的属性
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(CollectSpace, NavStatusBarHeight, SCREENWIDTH - CollectSpace*2, SCREENHEIGHT - TabBarHeight- NavStatusBarHeight) collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.dataSource = self;
    self.collectionView.scrollEnabled = YES;
    
    [self.view addSubview:self.collectionView];
    //注册Cell
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([LawMineCollectCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"cell"];
//    注册头视图
   
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
}
//  返回头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    //如果是头视图
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *header=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        [header removeAllSubviews];
        MJWeakSelf
        if (indexPath.section == 0) {
            
            self.collectionTopView.infoModel = self.infoModel;
            //     41 编辑 42 余额  43  券 44 爱心 100 未登录点击 登录注册跳转登录页面
            self.collectionTopView.TouchBtnBlock = ^(NSInteger index) {
                if(!IsLogin){
                    [weakSelf  JumpLoginVIewController];
                }else{
                
                if(index == 41){
                    
                    LawPersonInfoViewController * lawrevc =  [[LawPersonInfoViewController alloc]init];
//                  lawrevc.infoModel  =  weakSelf.infoModel ;
                    
                    [weakSelf.navigationController pushViewController:lawrevc animated:YES];
                }
                else if (index ==42) {
                    LawRemainingViewController * lawrevc =  [[LawRemainingViewController alloc]init];
                [weakSelf.navigationController pushViewController:lawrevc animated:YES];
                }else if (index ==43){
                     LawPackageViewController * lawrevc =  [[LawPackageViewController alloc]init];
                    [weakSelf.navigationController pushViewController:lawrevc animated:YES];
                    
                }else if (index ==44){
 
                    LawHeartViewController * lawrevc =  [[LawHeartViewController alloc]init];
                    [weakSelf.navigationController pushViewController:lawrevc animated:YES];
                }
                }
                
            };
            [header addSubview:self.collectionTopView];
            
            UILabel * titleLb =[[UILabel alloc]initWithFrame:CGRectMake(0, Topheight +10, SCREENWIDTH, 45)];
            titleLb.text = @"      服务记录";
             [titleLb setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
            titleLb.textColor = [UIColor colorWithHex:0x333333];
            titleLb.backgroundColor = [UIColor whiteColor];
            [header addSubview:titleLb];

        } else if (indexPath.section ==1){
            UILabel * titleLb =[[UILabel alloc]initWithFrame:CGRectMake(0, 10, SCREENWIDTH,  45)];
            titleLb.text = @"      其他";
            titleLb.backgroundColor = [UIColor whiteColor];

            [titleLb setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
            
            titleLb.textColor = [UIColor colorWithHex:0x333333];
            [header addSubview:titleLb];
            
        }else{
     

        }
        header.backgroundColor = [UIColor colorWithHex:0xf5f5f5];
        
         return header;
    }
    
    return nil;
}
-(LawMineTopView *)collectionTopView{
    if (!_collectionTopView) {
    _collectionTopView =[[[NSBundle mainBundle]loadNibNamed:@"LawMineTopView" owner:self options:nil]lastObject];
        _collectionTopView.frame = CGRectMake(0, 0,self.collectionView.width, Topheight);
        _collectionTopView.backgroundColor = [UIColor whiteColor];
        _collectionTopView.autoresizingMask = UIViewAutoresizingFlexibleWidth;

    }
    
    return _collectionTopView;
}
// 设置section头视图的参考大小，与tableheaderview类似
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section {
    
    
    if (section == 0) {
    return CGSizeMake(self.collectionView.width, Topheight + 55 );
     }else {
        return CGSizeMake(self.collectionView.width, 55);
    }
}


#pragma mark  设置CollectionView的组数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return CollectitemArray.count;
}

#pragma mark  设置CollectionView每组所包含的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 4;
    }else{
        return 5;
    }
    
}

#pragma mark  设置CollectionCell的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    LawMineCollectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    if (cell == nil) {
        
    }
    cell.CellImage.image = [UIImage imageNamed:CollectitemImageArray[indexPath.section][indexPath.row]];
    cell.CellLabel.text = CollectitemArray[indexPath.section][indexPath.row];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section ==0) {
        if(!IsLogin){
            [self  JumpLoginVIewController];
            return;
        }

       
        if(indexPath.row == 0){
         

            LawConSultViewController * adsListVc = [[LawConSultViewController alloc]init];
            [self.navigationController pushViewController:adsListVc animated:YES];
        }else if (indexPath.row ==1 || indexPath.row ==2){
        
            LawMeetingViewController * adsListVc = [[LawMeetingViewController alloc]init];
            if (indexPath.row==1) {
                adsListVc.meetTing =@"电话预约";
            }else{
                adsListVc.meetTing =@"见面预约";
            }
            [self.navigationController pushViewController:adsListVc animated:YES];
            
        }else if (indexPath.row==3){
            
            LawSquarSrviceViewController * adsListVc = [[LawSquarSrviceViewController alloc]init];
            adsListVc.ServiceTitle = @"法律服务";
            [self.navigationController pushViewController:adsListVc animated:YES];
        }
        
 
    }
    else{
        
        if (  indexPath.row == 0) {
            if(!IsLogin){
                [self  JumpLoginVIewController];
                return ;
            }

            LawCollectViewController *  collec =[[LawCollectViewController alloc]init];
            [self.navigationController pushViewController:collec animated:YES];
        }else  if (  indexPath.row == 1) {
            if(!IsLogin){
                [self  JumpLoginVIewController];
                return ;

            }

            LawIWantPublicVC * about= [[LawIWantPublicVC alloc] initWithNibName:@"LawIWantPublicVC" bundle:[NSBundle mainBundle]];
            [self.navigationController pushViewController:about animated:YES];
        
        }
       else  if (  indexPath.row == 2) {
           
            [self Callkefu];
       }else if(indexPath.row == 3){
           QJAboutAppViewController * about= [[QJAboutAppViewController alloc] initWithNibName:@"QJAboutAppViewController" bundle:[NSBundle mainBundle]];
           [self.navigationController pushViewController:about animated:YES];
           

       }else if (indexPath.row ==4){
           LawNewHeZuoViewController * hezuo  =[[LawNewHeZuoViewController alloc]init];
           [self.navigationController pushViewController:hezuo animated:YES];
       }
        
    }
    
    
}
#pragma mark  定义每个UICollectionView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return  CGSizeMake(75 ,90);
}



#pragma  mark   客服电话
-(void)Callkefu{
    
    UIAlertController * AlertVC =[UIAlertController alertControllerWithTitle:@"联系客服" message:[NSString stringWithFormat:@"\n%@\n(工作时间9:00-17:00)\n",APPPhone] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancal =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }] ;
    [cancal setValue:[UIColor colorWithHex:0x999999] forKey:@"_titleTextColor"];
    UIAlertAction * sure  =[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"4006400661"];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self.view addSubview:callWebview];
        
       
    }];
    [AlertVC addAction:cancal];
    [AlertVC addAction:sure];
    [self presentViewController:AlertVC animated:YES completion:nil];
}
-(void)JumpLoginVIewController{
    
    LawLogionViewController *view = [LawLogionViewController new];
    UINavigationController * na= [[UINavigationController alloc]initWithRootViewController:view];
    [UIApplication sharedApplication].delegate.window.rootViewController = na;
    return ;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"汇融法"  descr:@"汇融法致力于打造“互联网新生态”律师，平台利用先进的O2O方法，将分散、繁杂的线下法律服务需求及资源整合至线上，为当事人及律师搭建在线沟通、文件传输、公证签约、款项支付以及争端解决等全方位服务的桥梁。" thumImage:[UIImage imageNamed:@"1024icon"]];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

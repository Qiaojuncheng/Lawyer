//
//  AppointmentViewController.m
//  TheLawyer
//
//  Created by yaoyao on 17/7/27.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import "AppointmentViewController.h"
#import "AppointmentCell.h"
#import "AppointmentModel.h"
static int PageNumber = 1;
@interface AppointmentViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSMutableArray *dataSource;

@property (nonatomic,strong) UITableView *listTab;

@property(nonatomic,assign)  NSInteger Pcount;

@property (nonatomic,assign) int  RedStaue;

@property(strong,nonatomic) UIView *bgView;

@property (nonatomic,strong) UILabel *nodataL;

@end

@implementation AppointmentViewController

-(UILabel *)nodataL
{
    if (!_nodataL) {
        _nodataL = [[UILabel alloc] initWithFrame:CGRectMake(20, SCREENHEIGHT/2-100, SCREENWIDTH-40, 40)];
        _nodataL.text = [NSString stringWithFormat:@"暂无数据"];
        _nodataL.hidden = YES;
        _nodataL.textColor = RGBCOLOR(102, 102, 102);
        _nodataL.font = [UIFont systemFontOfSize:18];
        _nodataL.textAlignment = NSTextAlignmentCenter;
    }
    return _nodataL;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBCOLOR(242, 242, 242);
    [self addCenterLabelWithTitle:@"我的预约" titleColor:[UIColor whiteColor]];
    PageNumber = 1;
    [self makeData];
    [self mkeTv];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}


-(void)makeData
{
    //App/Lawyer/yuyue
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:hud];
    [self.view bringSubviewToFront:hud];
    hud.labelText = @"拼命加载中";
    hud.removeFromSuperViewOnHide = YES;
    [hud show:YES];
    //action、value
    NSDictionary *dic = @{
                          @"user_id":UserId
                          };
    
    NSError *dataError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:(NSJSONWritingOptions)0 error:&dataError];
    NSString *body = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    DLog(@"%@",body);
    NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [data base64EncodedStringWithOptions:0];
    DLog(@"%@",base64String);
    
    NSDictionary *parameter= @{
                               @"action":[NSString stringWithFormat:@"App/Lawyer/yuyue"],
                               @"value":base64String
                               };
    
    DLog(@"%@",parameter);
    WS(ws);
    [AFManagerHelp POST:BASE_URL parameters:parameter success:^(id responseObjeck) {
        // 处理数据
        DLog(@"%@",responseObjeck);
        [hud hide:YES];
        if ([responseObjeck[@"status"] integerValue] == 0) {
            self.listTab.hidden = NO;
            ws.dataSource = (NSMutableArray *)[AppointmentModel mj_objectArrayWithKeyValuesArray:responseObjeck[@"data"]];
            [ws.listTab reloadData];
            [ws.listTab.mj_header endRefreshing];
            [ws.listTab.mj_footer resetNoMoreData];
            [ws.listTab.mj_footer endRefreshing];
        }else{
            [ShowHUD showWYBTextOnly:responseObjeck[@"msg"] duration:2 inView:ws.view];
        }
    } failure:^(NSError *error) {
        [hud hide:YES];
        [ShowHUD showWYBTextOnly:@"你的网络好像不太给力\n请稍后再试" duration:2 inView:ws.view];
    }];
    
}
- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}
-(void)mkeTv
{
    self.listTab = [[UITableView alloc]initWithFrame:CGRectMake(0, NavStatusBarHeight, SCREENWIDTH, SCREENHEIGHT-NavStatusBarHeight) style:UITableViewStylePlain];
    self.listTab.dataSource= self;
    self.listTab.delegate  = self;
    self.listTab.backgroundColor = RGBCOLOR(242, 242, 242);
    self.listTab.showsVerticalScrollIndicator = NO;
    self.listTab.tableFooterView  =[[UIView alloc]init];

    self.listTab.mj_footer.automaticallyHidden = NO;
    self.listTab.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(RrefreshMethord)];
    self.listTab.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(RrefreshMethordTwo)];

    [self.view addSubview:self.listTab];
    [self.listTab  addSubview:self.nodataL];
    
    
}
#pragma mark -RefreshMethord

-(void)RrefreshMethord
{
    [self.listTab.mj_header endRefreshing];
}

-(void)RrefreshMethordTwo
{
    //    self.currentPage ++;
    [self.listTab.mj_footer endRefreshing];
    //    [self requestGrabData];
}


#pragma mark UITableViewDelege
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPat{
    DLog(@"暂不跳转");
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.dataSource.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AppointmentCell  *cell2 =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell2 == nil) {
        cell2 =[[[NSBundle mainBundle]loadNibNamed:@"AppointmentCell" owner:self options:nil]lastObject];
    }
    cell2.commentsModel = self.dataSource[indexPath.row];
    [cell2 agreeCancelBlock:^{
        [self  agreeButtonRequest:cell2.commentsModel.commentsId];
    }];
    [cell2 refusedCancelBlock:^{
        [self refusedButtonRequest:cell2.commentsModel.commentsId];
    }];
    cell2.selectionStyle= UITableViewCellSeparatorStyleNone;
    return cell2;
}
- (void)agreeButtonRequest:(NSInteger )agreeId {
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:hud];
    [self.view bringSubviewToFront:hud];
    hud.labelText = @"拼命加载中";
    hud.removeFromSuperViewOnHide = YES;
    [hud show:YES];
    //action、value
    NSDictionary *dic = @{
                          @"user_id":UserId,
                          @"id":[NSString stringWithFormat:@"%ld",(long)agreeId],
                          @"status":@2
                          };
    
    NSError *dataError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:(NSJSONWritingOptions)0 error:&dataError];
    NSString *body = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    DLog(@"%@",body);
    NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [data base64EncodedStringWithOptions:0];
    DLog(@"%@",base64String);
    
    NSDictionary *parameter= @{
                               @"action":[NSString stringWithFormat:@"App/Lawyer/changYuyueStatus"],
                               @"value":base64String
                               };
    
    DLog(@"%@",parameter);
    WS(ws);
    [AFManagerHelp POST:BASE_URL parameters:parameter success:^(id responseObjeck) {
        // 处理数据
        DLog(@"%@",responseObjeck);
        [hud hide:YES];
        if ([responseObjeck[@"status"] integerValue] == 0) {
            [ShowHUD showWYBTextOnly:@"同意预约成功" duration:2 inView:ws.view];
        }else{
            [ShowHUD showWYBTextOnly:responseObjeck[@"msg"] duration:2 inView:ws.view];
        }
    } failure:^(NSError *error) {
        [hud hide:YES];
        [ShowHUD showWYBTextOnly:@"你的网络好像不太给力\n请稍后再试" duration:2 inView:ws.view];
    }];

}
- (void)refusedButtonRequest:(NSInteger )refused {
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:hud];
    [self.view bringSubviewToFront:hud];
    hud.labelText = @"拼命加载中";
    hud.removeFromSuperViewOnHide = YES;
    [hud show:YES];
    //action、value
    NSDictionary *dic = @{
                          @"user_id":@26,
                          @"id":[NSString stringWithFormat:@"%ld",(long)refused],
                          @"status":@3
                          };
    
    NSError *dataError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:(NSJSONWritingOptions)0 error:&dataError];
    NSString *body = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    DLog(@"%@",body);
    NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [data base64EncodedStringWithOptions:0];
    DLog(@"%@",base64String);
    
    NSDictionary *parameter= @{
                               @"action":[NSString stringWithFormat:@"App/Lawyer/changYuyueStatus"],
                               @"value":base64String
                               };
    
    DLog(@"%@",parameter);
    WS(ws);
    [AFManagerHelp POST:BASE_URL parameters:parameter success:^(id responseObjeck) {
        // 处理数据
        DLog(@"%@",responseObjeck);
        [hud hide:YES];
        if ([responseObjeck[@"status"] integerValue] == 0) {
            [ShowHUD showWYBTextOnly:@"拒绝预约成功" duration:2 inView:ws.view];
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

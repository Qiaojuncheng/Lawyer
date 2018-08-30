//
//  MainViewController.m
//  TheLawyer
//
//  Created by yaoyao on 17/7/18.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import "MainViewController.h"
#import "GrabCell.h"
#import "GrabModel.h"
 #import "MainDetailViewController.h"
#import "LoginViewController.h"

@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
 }
@property(nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,assign) NSInteger currentPage;
@property (nonatomic,strong) NSMutableArray *dataSource;
//tempArray
@property (nonatomic,strong) NSMutableArray *tempArray;
@property (nonatomic, assign) BOOL isRequest;

@end

@implementation MainViewController


// tempArray
- (NSMutableArray *)tempArray
{
    if (!_tempArray) {
        _tempArray = [[NSMutableArray alloc] init];
    }
    return _tempArray;
}
- (UITableView *)tableView {
 
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavStatusBarHeight, SCREENWIDTH, SCREENHEIGHT  - NavTabBarHeight - NavStatusBarHeight ) style:UITableViewStylePlain];

        //         _tableView.showsVerticalScrollIndicator = NO;
        
        // 设置代理对象
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc]init];
         _tableView.backgroundColor = DEFAULTBGCOLOR;
 //        //加载
        WS(ws);
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
             ws.currentPage = 1;
             [ws requestGrabData];
        }];
        
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            ws.currentPage ++;
            [ws requestGrabData];
        }];
    }
    
    return _tableView;
}

#pragma mark -RefreshMethord


- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"StatusBarHeight = %f",StatusBarHeight);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UpDataGrabData) name:@"UPGARAT" object:nil];
    [self initMainViewControllerNavView];
    [self.view addSubview:self.tableView];
    self.currentPage = 1;
    [self requestGrabData];
}
-(void)UpDataGrabData{
    self.currentPage =1;
    [self requestGrabData];
}
 -(void)requestGrabData
{
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:hud];
    [self.view bringSubviewToFront:hud];
    hud.labelText = @"拼命加载中";
    hud.removeFromSuperViewOnHide = YES;
    [hud show:YES];
    //action、value
    
    NSDictionary *dic = @{
                          @"user_id":UserId,
                          @"p":[NSString stringWithFormat:@"%ld",(long)_currentPage]};
    
     NSError *dataError = nil;
     NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:(NSJSONWritingOptions)0 error:&dataError];
    NSString *body = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    DLog(@"%@",body);
    NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [data base64EncodedStringWithOptions:0];
    DLog(@"%@",base64String);
    
    NSDictionary *parameter= @{
                          @"action":[NSString stringWithFormat:@"App/Lawyer/law"],
                          @"value":base64String
                          };

    DLog(@"%@",parameter);
    WS(ws);
    [AFManagerHelp POST:BASE_URL parameters:parameter success:^(id responseObjeck) {
        // 处理数据
        DLog(@"%@",responseObjeck);
        [hud hide:YES];
        NSString * status =[NSString stringWithFormat:@"%@",responseObjeck[@"status"]];
          if (self.currentPage == 1) {
            [ws.tempArray  removeAllObjects];
        }
        if ([status isEqualToString:@"0"]) {
             [ws.tempArray addObjectsFromArray:(NSMutableArray *)[GrabModel mj_objectArrayWithKeyValuesArray:responseObjeck[@"data"]]];
 
        }else if([status isEqualToString:@"1003"]){
             [ShowHUD showWYBTextOnly:@"登陆已失效请重新登陆！" duration:2 inView:ws.view];
            LoginViewController *view = [LoginViewController new];
            UINavigationController * na= [[UINavigationController alloc]initWithRootViewController:view];
        [UIApplication sharedApplication].delegate.window.rootViewController  = na;
        }else{
            [ShowHUD showWYBTextOnly:responseObjeck[@"msg"] duration:2 inView:ws.view];

        }
        if (ws.tempArray.count == 0) {
            [self ShowNoDataViewWithStr:@"暂无抢单数据" yOffset:0];
        }else{
            [self hintNodataView];
        }
        [ws.tableView reloadData];
      [_tableView.mj_footer  endRefreshing];
        [_tableView.mj_header  endRefreshing];
     } failure:^(NSError *error) {
        [hud hide:YES];
        if (ws.tempArray.count == 0) {
            [self ShowNoDataViewWithStr:@"数据访问失败" yOffset:0];
        }else{
                [self hintNodataView];
        }

        [_tableView.mj_footer  endRefreshing];
        [_tableView.mj_header  endRefreshing];
        [ShowHUD showWYBTextOnly:@"你的网络好像不太给力\n请稍后再试" duration:2 inView:ws.view];
    }];
}
#pragma mark  _TableView 的代理方法
#pragma mark - UITableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.tempArray.count;
    
}
 -(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GrabCell *cell=[tableView dequeueReusableCellWithIdentifier:@"GrabCell"];
    if (cell == nil) {
        cell  = [[[NSBundle mainBundle]loadNibNamed:@"GrabCell" owner:self options:nil]lastObject];
    }
    
    GrabModel *model = self.tempArray[indexPath.row];
        //model赋值
    cell.commentsModel = model;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
 -(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    GrabModel *model  =self.tempArray[indexPath.row];
    MainDetailViewController*joke = [[MainDetailViewController alloc] init];
     joke.type = [NSString stringWithFormat:@"%ld",(long)model.type];
    joke.typeId = model.id;
    joke.titleType = 1;
    [self.navigationController pushViewController:joke animated:YES];
}
- (void)initMainViewControllerNavView
{
    [self addCenterLabelWithTitle:@"抢单" titleColor:[UIColor whiteColor]];
}

-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LOCATIONACTION" object:nil];

    
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

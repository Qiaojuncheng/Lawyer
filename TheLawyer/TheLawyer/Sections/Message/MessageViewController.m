//
//  MessageViewController.m
//  TheLawyer
//
//  Created by yaoyao on 17/7/24.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import "MessageViewController.h"
#import "QJMessageCellCell.h"
#import "MessageModel.h"
#import "MessageDetailController.h"
#import "MainDetailViewController.h"
#import "QJCappointmentVC.h"

@interface MessageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *tableView;
@property (nonatomic,assign) NSInteger currentPage;
@property (nonatomic,strong) NSMutableArray *dataSource;
//tempArray
@property (nonatomic,strong) NSMutableArray *tempArray;
@property (nonatomic, assign) BOOL isRequest;

@end

@implementation MessageViewController


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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavStatusBarHeight, SCREENWIDTH, SCREENHEIGHT - NavStatusBarHeight  - TabBarHeight) style:UITableViewStylePlain];
        NSLog(@"mainheight = %f  - %f = %F",SCREENHEIGHT ,NavStatusBarHeight,SCREENHEIGHT - NavStatusBarHeight );
         _tableView.showsVerticalScrollIndicator = NO;
        
        // 设置代理对象
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView =[[UIView alloc]init];
//        _tableView.hidden = YES;
        _tableView.backgroundColor = DEFAULTBGCOLOR;
        // 注册
 
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _currentPage = 1;
            [self requestMessageData];
        }];
                                 
        _tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
            
            _currentPage++;
            [self requestMessageData];
        }];
        
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight= 0;
        _tableView.estimatedSectionFooterHeight= 0;
        
        
        

        
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
    [self initMainViewControllerNavView];
    [self.view addSubview:self.tableView];
    self.currentPage = 1;
    [self requestMessageData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UpDataMessageData) name:@"UPMESSAGEDATA" object:nil];

}
-(void)UpDataMessageData{
    self.currentPage = 1;
    [self requestMessageData];
}
-(void)requestMessageData
{
    if(_currentPage==1){
        [self showHudInView:self.view hint:nil];
    }
    //action、value
    NSDictionary *dic = @{
                          @"user_id":UserId,
                          @"p":[NSString stringWithFormat:@"%ld",_currentPage]
                          };
     NSError *dataError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:(NSJSONWritingOptions)0 error:&dataError];
    NSString *body = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    DLog(@"%@",body);
    NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [data base64EncodedStringWithOptions:0];
    DLog(@"%@",base64String);
    
    NSDictionary *parameter= @{
                               @"action":[NSString stringWithFormat:@"App/Lawyer/xiaoxi"],
                               @"value":base64String
                               };
        DLog(@"%@",parameter);
    WS(ws);
    [AFManagerHelp POST:BASE_URL parameters:parameter success:^(id responseObjeck) {
        // 处理数据
        DLog(@"%@",responseObjeck);
        if (_currentPage == 1) {
            [ws.dataSource removeAllObjects];
        }
        [self hideHud];
        if ([responseObjeck[@"status"] integerValue] == 0) {
            _tableView.hidden = NO;
        [ws.dataSource  addObjectsFromArray:(NSMutableArray *)[MessageModel mj_objectArrayWithKeyValuesArray:responseObjeck[@"data"]]];
            [ws.tableView reloadData];
        }else{
            [ShowHUD showWYBTextOnly:responseObjeck[@"msg"] duration:2 inView:ws.view];
        }
        if (ws.dataSource.count == 0) {
            [self ShowNoDataViewWithStr:@"暂无新消息" yOffset:0];
        }else{
            
            [self hintNodataView];
        }

        [ws.tableView.mj_header endRefreshing];
         [ws.tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        if (ws.dataSource.count == 0) {
            [self ShowNoDataViewWithStr:@"数据访问失败" yOffset:0];
        }else{
            [self hintNodataView];
        }

        [ws.tableView.mj_header endRefreshing];
         [ws.tableView.mj_footer endRefreshing];
        [self hideHud];
        [ShowHUD showWYBTextOnly:@"你的网络好像不太给力\n请稍后再试" duration:2 inView:ws.view];
    }];
}
#pragma mark  _TableView 的代理方法
#pragma mark - UITableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
 -(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QJMessageCellCell *cell=(QJMessageCellCell *)[tableView dequeueReusableCellWithIdentifier:@"QJMessageCellCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"QJMessageCellCell" owner:self options:nil]lastObject];
    }
    MessageModel *model = self.dataSource[indexPath.row];
    //model赋值
    cell.model = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageModel *model = self.dataSource[indexPath.row];

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([model.type isEqualToString:@"1"]) {
        MessageDetailController *joke = [[MessageDetailController alloc] initWithNibName:@"MessageDetailController" bundle:[NSBundle mainBundle]];
        joke.zixunID = model.commentsId;
        [self.navigationController pushViewController:joke animated:YES];

    }else{
        QJCappointmentVC * Cvc = [[QJCappointmentVC alloc] init];
        Cvc.appointId = model.commentsId;
        Cvc.TitleStr = @"预约详情";
        [self.navigationController pushViewController:Cvc animated:YES];
        
    }
  
    
}


















- (void)initMainViewControllerNavView
{
    [self addCenterLabelWithTitle:@"消息" titleColor:[UIColor whiteColor]];
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

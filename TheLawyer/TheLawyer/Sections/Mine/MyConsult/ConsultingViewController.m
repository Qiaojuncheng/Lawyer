//
//  ConsultingViewController.m
//  TheLawyer
//
//  Created by yaoyao on 17/7/27.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import "ConsultingViewController.h"
#import "ConsultingModel.h"
#import "ConsultingCell.h"
#import "MessageDetailController.h"

@interface ConsultingViewController ()<UITableViewDataSource,UITableViewDelegate>{
    
    NSInteger   PageNumber ;
}

@property(nonatomic,strong)NSMutableArray *dataSource;

@property (nonatomic,strong) UITableView *listTab;

@property(nonatomic,assign)  NSInteger Pcount;

@property (nonatomic,assign) int  RedStaue;

@property(strong,nonatomic) UIView *bgView;

@property (strong,nonatomic) NSMutableArray *likeArray;

@property (nonatomic,strong) UILabel *nodataL;

@end

@implementation ConsultingViewController



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
    self.dataSource = [[NSMutableArray alloc]init];
    self.view.backgroundColor = RGBCOLOR(242, 242, 242);
    [self addCenterLabelWithTitle:@"我的咨询" titleColor:[UIColor whiteColor]];
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
    if(PageNumber==1){
        [self showHudInView:self.view hint:nil];
        
    }

    //action、value
    
    NSDictionary *dic = @{
                          @"user_id":UserId,
                          @"p":[NSString stringWithFormat:@"%ld",PageNumber]
                          };
    
    NSError *dataError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:(NSJSONWritingOptions)0 error:&dataError];
    NSString *body = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    DLog(@"%@",body);
    NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [data base64EncodedStringWithOptions:0];
    DLog(@"%@",base64String);
    
    NSDictionary *parameter= @{
                               @"action":[NSString stringWithFormat:@"App/Lawyer/zixun"],
                               @"value":base64String
                               };
    
    DLog(@"%@",parameter);
    WS(ws);
    [AFManagerHelp POST:BASE_URL parameters:parameter success:^(id responseObjeck) {
        // 处理数据
        DLog(@"%@",responseObjeck);
        [self hideHud];        if (PageNumber == 1) {
            [ws.dataSource removeAllObjects];
        }
        if ([responseObjeck[@"status"] integerValue] == 0) {
            self.listTab.hidden = NO;
            [ws.dataSource addObjectsFromArray:(NSMutableArray *)[ConsultingModel mj_objectArrayWithKeyValuesArray:responseObjeck[@"data"]]];
            [ws.listTab reloadData];
            [ws.listTab.mj_header endRefreshing];
            [ws.listTab.mj_footer resetNoMoreData];
            [ws.listTab.mj_footer endRefreshing];
        }else{
            [ShowHUD showWYBTextOnly:responseObjeck[@"msg"] duration:2 inView:ws.view];
        }
        [ws.listTab.mj_footer endRefreshing];
        [ws.listTab.mj_header  endRefreshing];
    } failure:^(NSError *error) {
      [self hideHud];
        [ws.listTab.mj_footer endRefreshing];
        [ws.listTab.mj_header  endRefreshing];
        [ShowHUD showWYBTextOnly:@"你的网络好像不太给力\n请稍后再试" duration:2 inView:ws.view];
    }];
    
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
    self.listTab.mj_header = [MJRefreshNormalHeader  headerWithRefreshingBlock:^{
        PageNumber =1 ;
        [self makeData];

    }];
    
    self.listTab.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        PageNumber ++;
        [self makeData];
    }];
    self.listTab.estimatedRowHeight = 0;
    self.listTab.estimatedSectionHeaderHeight= 0;
    self.listTab.estimatedSectionFooterHeight= 0;
    
    
    

    [self.view addSubview:self.listTab];
    [self.listTab  addSubview:self.nodataL];
}

#pragma mark UITableViewDelege
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPat{
    ConsultingModel * model  = self.dataSource[indexPat.row];

    MessageDetailController *joke = [[MessageDetailController alloc] initWithNibName:@"MessageDetailController" bundle:[NSBundle mainBundle]];
    joke.zixunID = model.commentsId;
    WS(ws);
    joke.reloadDataBlock = ^{
        model.flag = @"1";
        [ws.dataSource replaceObjectAtIndex:indexPat.row withObject:model];
        [ws.listTab reloadData];
    };
    [self.navigationController pushViewController:joke animated:YES];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.dataSource.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ConsultingCell  *cell2 =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell2 == nil) {
        cell2 =[[[NSBundle mainBundle]loadNibNamed:@"ConsultingCell" owner:self options:nil]lastObject];
    }
    cell2.commentsModel = self.dataSource[indexPath.row];
    cell2.selectionStyle= UITableViewCellSeparatorStyleNone;
    return cell2;
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

//
//  MyMessageViewController.m
//  TheLawyer
//
//  Created by yaoyao on 17/7/27.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import "MyMessageViewController.h"
#import "MyMessageTableCell.h"
#import "MessageModel.h"
#import "QJMessageCellCell.h"
static int PageNumber = 1;
@interface MyMessageViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSMutableArray *dataSource;

@property (nonatomic,strong) UITableView *listTab;

@property(nonatomic,assign)  NSInteger Pcount;

@property (nonatomic,assign) int  RedStaue;

@property(strong,nonatomic) UIView *bgView;

@property (strong,nonatomic) NSMutableArray *likeArray;

@property (nonatomic,strong) UILabel *nodataL;

@end

@implementation MyMessageViewController
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
    [self addCenterLabelWithTitle:@"我的消息" titleColor:[UIColor whiteColor]];
    PageNumber = 1;
    //    [self makeData];
    [self mkeTv];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}


-(void)makeData
{
    NSDictionary *dic = @{
                          @"param":@{
                                  @"UserId":[UD valueForKey:@"userID"],
                                  @"Status":[NSString stringWithFormat:@"%d",self.RedStaue]
                                  }
                          };
    ShowHUD *hud = [ShowHUD showCustomLoadingInView:self.view];
    __weak typeof(self) weakSelf = self;
    [AFManagerHelp POST:@"sdfghjkl" parameters:dic success:^(id responseObjeck) {
        DLog(@"%@",responseObjeck);
        if ([responseObjeck[@"errorCode"] integerValue] == 0) {
            [hud hide];
            weakSelf.dataSource = (NSMutableArray *)[MessageModel mj_objectArrayWithKeyValuesArray:responseObjeck[@"result"]];
            
        }else{
            //弹出失败信息
            [hud hide];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:responseObjeck[@"errorMessage"] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
        }
        if (!weakSelf.dataSource.count) {
            self.nodataL.hidden = NO;
        }else{
            self.nodataL.hidden = YES;
            [weakSelf.listTab reloadData];
            
        }
        
    } failure:^(NSError *error) {
        [hud hide];
        
        [weakSelf showHint:@"网络请求失败"];
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
    self.listTab.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(RrefreshMethord)];
    self.listTab.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(RrefreshMethordTwo)];
    //    self.listTab.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
    //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //            [self.listTab.mj_header endRefreshing];
    //        });
    //
    //    }];
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
    return 100;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyMessageTableCell  *cell2 =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell2 == nil) {
        cell2 =[[[NSBundle mainBundle]loadNibNamed:@"MyMessageTableCell" owner:self options:nil]lastObject];
    }
    //    cell2.myModel = self.dataSource[indexPath.row];
    cell2.selectionStyle= UITableViewCellSeparatorStyleNone;
    return cell2;
    

//    MessageCell *cell=(MessageCell *)[tableView dequeueReusableCellWithIdentifier:@"CommentsCell" forIndexPath:indexPath];
//    MessageModel *model = self.dataSource[indexPath.section];
//    //model赋值
//    cell.commentsModel = model;
//    
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    return cell;
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

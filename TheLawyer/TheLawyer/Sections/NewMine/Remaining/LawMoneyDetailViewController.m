//
//  LawMoneyDetailViewController.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/14.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawMoneyDetailViewController.h"
#import "LawMondetaulCell.h"
#import "LawMoneyDetailModel.h"
@interface LawMoneyDetailViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSInteger Page ;
}

@property (strong , nonatomic) UITableView * tableView ;
@property (strong , nonatomic) NSMutableArray * dataArray;
@end

@implementation LawMoneyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Page =1 ;
    self.dataArray =[[NSMutableArray alloc] init];
    [self addCenterLabelWithTitle:@"余额明细" titleColor:nil];
    self.view.backgroundColor = BackViewColor;
    [self addtableview];
    [self makeData];
    // Do any additional setup after loading the view.
}
-(void)makeData{
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    NewMoneydetailed
    if( [UserId length] < 1){
        return ;
    }
    NSDictionary * valudic  = @{@"lawyer_id":UserId,@"p":[NSString stringWithFormat:@"%ld",Page]};
    NSString * baseStr = [NSString getBase64StringWithArray:valudic];
    [dic setValue:baseStr forKey:@"value"];
    
    if(Page==1){
        [self showHudInView:self.view hint:nil];
     }

    MJWeakSelf
    [HttpAfManager postWithUrlString:BASE_URL parameters:dic success:^(id data) {
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            if (Page == 1) {
                [weakSelf.dataArray removeAllObjects];
            }
            for (NSDictionary * dicc in data[@"data"]) {
                LawMoneyDetailModel * model = [LawMoneyDetailModel yy_modelWithJSON:dicc];
                [self.dataArray addObject:model];
            }
            [_tableView reloadData];
        }
        [self hideHud];
        [_tableView.mj_footer endRefreshing];
        [_tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [_tableView.mj_footer endRefreshing];
        [_tableView.mj_header endRefreshing];
        [self hideHud];
        NSLog(@"%@",error);
    }];
    
}
-(void)addtableview{
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, NavStatusBarHeight, SCREENWIDTH, SCREENHEIGHT - NavStatusBarHeight )];
    self.tableView.clipsToBounds = YES;
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
//    __weak typeof(self) weakSelf = self;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight= 0;
    _tableView.estimatedSectionFooterHeight= 0;
    self.tableView.mj_header  = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        Page = 1;
        [self makeData];
     }];
    self.tableView.mj_footer =[MJRefreshAutoFooter footerWithRefreshingBlock:^{
        Page ++;
        [self makeData];
    }];
    [self.view addSubview:self.tableView];
    
}
#pragma mark - UITableViewDelegate & UITableViewDataSource
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LawMondetaulCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"LawMondetaulCell" owner:self options:nil]lastObject];
    }
    cell.modle = self.dataArray[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

#pragma mark - TableView 占位图

- (UIImage *)xy_noDataViewImage {
    return [UIImage imageNamed:@"tips_nocollect"];
}

- (NSString *)xy_noDataViewMessage {
    return @"暂无明细";
}

- (UIColor *)xy_noDataViewMessageColor {
    return ShallowTintColor;
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

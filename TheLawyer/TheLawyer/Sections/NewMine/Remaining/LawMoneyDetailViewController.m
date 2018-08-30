//
//  LawMoneyDetailViewController.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/14.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawMoneyDetailViewController.h"
#import "LawMondetaulCell.h"
@interface LawMoneyDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong , nonatomic) UITableView * tableView ;
@property (copy , nonatomic) NSArray * dataArray;
@end

@implementation LawMoneyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray =[[NSArray alloc] initWithObjects:@"13",@"sdfa",@"adsf",nil];
    [self addCenterLabelWithTitle:@"余额明细" titleColor:nil];
    self.view.backgroundColor = BackViewColor;
    [self addtableview];
    // Do any additional setup after loading the view.
}
-(void)addtableview{
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, NavStatusBarHeight, SCREENWIDTH, SCREENHEIGHT - NavStatusBarHeight )];
    self.tableView.clipsToBounds = YES;
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
//    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header  = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [weakSelf loadData];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
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

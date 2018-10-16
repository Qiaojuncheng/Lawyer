//
//  LawPackageViewController.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/20.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawPackageViewController.h"
#import "LawTPackageCell.h"
#import "LawMyTicketModel.h"
@interface LawPackageViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * dataArrray ;
    UITableView * _tableView;
    UILabel * heaerNumberLB;
    NSInteger page ;
}
@property (strong ,nonatomic) UIView * HeaderView;
@end

@implementation LawPackageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    page = 1;
    dataArrray =[[NSMutableArray alloc]init];
    [self addCenterLabelWithTitle:@"套餐券" titleColor:nil];
    [self addView];
    [self makeData];
    // Do any additional setup after loading the view.
}
-(void)makeData{
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    NewMyticket
    if( [UserId length] < 1){
        return ;
    }
    NSDictionary * valudic  = @{@"lawyer_id":UserId,@"p":[NSString stringWithFormat:@"%ld",page]};
    NSString * baseStr = [NSString getBase64StringWithArray:valudic];
    [dic setValue:baseStr forKey:@"value"];
    
    if(page==1){
        [self showHudInView:self.view hint:nil];
        
    }
    
    [HttpAfManager postWithUrlString:BASE_URL parameters:dic success:^(id data) {
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            heaerNumberLB.text = [NSString stringWithFormat:@"累计收到%@张，继续加油!",data[@"data"][@"num"]];
            if (page == 1) {
                [dataArrray removeAllObjects];
            }
            for (NSDictionary * dicc in data[@"data"][@"data"]) {
                LawMyTicketModel * model = [LawMyTicketModel yy_modelWithJSON:dicc];
                [dataArrray addObject:model];
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

-(void)addView{
    
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0,  NavStatusBarHeight , SCREENWIDTH, SCREENHEIGHT  -  NavStatusBarHeight    ) style:UITableViewStylePlain];
    _tableView.delegate=  self;
    _tableView.dataSource = self;
    _tableView.separatorInset = UIEdgeInsetsMake(0,SCREENWIDTH, 0, 0);
    _tableView.backgroundColor =[UIColor whiteColor];
    _tableView.tableHeaderView = self.HeaderView;
    _tableView.mj_header  = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        [self makeData];
    }];
    _tableView.mj_footer =[MJRefreshAutoFooter footerWithRefreshingBlock:^{
        page ++;
        [self makeData];
    }];
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight= 0;
    _tableView.estimatedSectionFooterHeight= 0;
    
    

    _tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:_tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  dataArrray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LawTPackageCell  * cell  =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell  =[[[NSBundle mainBundle ]loadNibNamed:@"LawTPackageCell" owner:self options:nil]lastObject];
    }
        cell.model = dataArrray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell ;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LawMyTicketModel * model =  dataArrray[indexPath.row];
    if ([model.status isEqualToString:@"1"]) {
        return ;
    }
    [self GetTicletWithModel:model withindex:indexPath.row];
 
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 107;
    
}
-(UIView *)HeaderView{
    if (!_HeaderView) {
        _HeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 145)];
        
        UIImageView * ima =[[UIImageView alloc]initWithFrame:_HeaderView.frame];
        ima.height = 135;
        ima.image =[UIImage imageNamed:@"ticket_bg"];
        [_HeaderView addSubview:ima];
        
        UIImageView * PackageIma =[[UIImageView alloc]initWithFrame:CGRectMake(28, 61, 21, 16)];
        PackageIma.image =[UIImage imageNamed:@"ticket"];
        [_HeaderView addSubview:PackageIma];
        
        heaerNumberLB = [[UILabel alloc] init];
        heaerNumberLB.frame = CGRectMake(PackageIma.right + 7,62,200,15.5);
        heaerNumberLB.text = @"累计收到82张，继续加油!";
        heaerNumberLB.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15];
        heaerNumberLB.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
        [_HeaderView addSubview:heaerNumberLB];
        _HeaderView.backgroundColor = [UIColor colorWithHex:0xF7F7F7];
    }
    return _HeaderView;
}
-(void)GetTicletWithModel:(LawMyTicketModel *)model withindex:(NSInteger)index{
    
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    NewticketChange
    if( [UserId length] < 1){
        return ;
    }
    NSDictionary * valudic  = @{@"lawyer_id":UserId,@"id":model.id};
    NSString * baseStr = [NSString getBase64StringWithArray:valudic];
    [dic setValue:baseStr forKey:@"value"];
    
    [self showHudInView:self.view hint:nil];
    
    
    [HttpAfManager postWithUrlString:BASE_URL parameters:dic success:^(id data) {
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            [self showHint:@"兑换成功！"];
            model.status = @"1";
            [dataArrray replaceObjectAtIndex:index withObject:model];
            [_tableView reloadData];
            
        }
        [self hideHud];
        
    } failure:^(NSError *error) {
        
        [self hideHud];
        NSLog(@"%@",error);
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

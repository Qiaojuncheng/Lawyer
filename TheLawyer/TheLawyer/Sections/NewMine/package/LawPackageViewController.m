//
//  LawPackageViewController.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/20.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawPackageViewController.h"
#import "LawTPackageCell.h"
@interface LawPackageViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * dataArrray ;
    UITableView * _tableView;
    UILabel * heaerNumberLB;
}
@property (strong ,nonatomic) UIView * HeaderView;
@end

@implementation LawPackageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCenterLabelWithTitle:@"套餐券" titleColor:nil];
    [self addView];
    // Do any additional setup after loading the view.
}
-(void)addView{
    
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0,  NavStatusBarHeight , SCREENWIDTH, SCREENHEIGHT  -  NavStatusBarHeight    ) style:UITableViewStylePlain];
    _tableView.delegate=  self;
    _tableView.dataSource = self;
    _tableView.separatorInset = UIEdgeInsetsMake(0,SCREENWIDTH, 0, 0);
    _tableView.backgroundColor =[UIColor whiteColor];
    _tableView.tableHeaderView = self.HeaderView;
    _tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:_tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10; //dataArrray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LawTPackageCell  * cell  =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell  =[[[NSBundle mainBundle ]loadNibNamed:@"LawTPackageCell" owner:self options:nil]lastObject];
    }
    //    cell.model = dataArrray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell ;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    LawCaseAppreciateDetail * detail =[[LawCaseAppreciateDetail alloc]init];
//    [self.navigationController pushViewController:detail animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 107;
    
}
-(UIView *)HeaderView{
    if (!_HeaderView) {
        _HeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 135)];
        
        UIImageView * ima =[[UIImageView alloc]initWithFrame:_HeaderView.frame];
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

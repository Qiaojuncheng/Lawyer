//
//  LawCaseAppreciateViewController.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/18.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawCaseAppreciateViewController.h"
#import "LawCaseCell.h"
#import "LawCaseAppreciateDetail.h"
#import "LawCaseTypeSelectView.h"
@interface LawCaseAppreciateViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * dataArrray ;
    UITableView * _tableView;
}
@property (strong, nonatomic) LawCaseTypeSelectView * caseSelectView;

@end

@implementation LawCaseAppreciateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCenterLabelWithTitle:@"案件赏析" titleColor:nil];
    MJWeakSelf
    [self addRightButtonWithTitle:@"案件筛选" titleColor:[UIColor colorWithHex:0xBAC2CE] actionBlock:^{
        [weakSelf showCaseTypeView];
    }];
    [self addView];
    [self.view addSubview:self.caseSelectView];
    // Do any additional setup after loading the view.
}
-(void)addView{
    
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0,  NavStatusBarHeight , SCREENWIDTH, SCREENHEIGHT  -  NavStatusBarHeight - TabBarHeight) style:UITableViewStylePlain];
    _tableView.delegate=  self;
    _tableView.dataSource = self;
    _tableView.separatorInset = UIEdgeInsetsMake(0,SCREENWIDTH, 0, 0);
    _tableView.backgroundColor =[UIColor whiteColor];
    _tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:_tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10; //dataArrray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LawCaseCell  * cell  =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell  =[[[NSBundle mainBundle ]loadNibNamed:@"LawCaseCell" owner:self options:nil]lastObject];
    }
    //    cell.model = dataArrray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell ;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LawCaseAppreciateDetail * detail =[[LawCaseAppreciateDetail alloc]init];
    [self.navigationController pushViewController:detail animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
    
}
-(LawCaseTypeSelectView *)caseSelectView{
    if (!_caseSelectView) {
        _caseSelectView = [[LawCaseTypeSelectView alloc]initWithFrame:_tableView.frame];;
        _caseSelectView.hidden = YES;
        _caseSelectView.TableViewHeight = _caseSelectView.height - 200;
 
    }
    return _caseSelectView;
}
-(void)caseBackAction:(UITapGestureRecognizer *)tap{
    if (tap.view == _caseSelectView) {
        _caseSelectView.hidden = YES;
    }
}
 -(void)showCaseTypeView{
    _caseSelectView.DataArray = [[NSMutableArray alloc]initWithArray:@[@"12",@"dsa"]];
    _caseSelectView.hidden = NO ;
     
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

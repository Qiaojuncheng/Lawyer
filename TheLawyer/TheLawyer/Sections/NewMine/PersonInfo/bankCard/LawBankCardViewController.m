//
//  LawBankCardViewController.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/24.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawBankCardViewController.h"
#import "LawBankCardCell.h"
#import "LawAddCardViewController.h"
@interface LawBankCardViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray * dataArrray ;
    UITableView * _tableView;
}
@property (strong,nonatomic) UIView * headerView;
@property (strong,nonatomic) UIView * footerView;

@end

@implementation LawBankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCenterLabelWithTitle:@"我的银行卡" titleColor:nil];
    self.view.backgroundColor  =   [UIColor colorWithHex:0xf7f7f7];
    [self addView];
    [self  makeData ];
    // Do any additional setup after loading the view.
}

-(void)addView{
    
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0,  NavStatusBarHeight  + 10 , SCREENWIDTH, SCREENHEIGHT  -  NavStatusBarHeight  - 10) style:UITableViewStylePlain];
    _tableView.delegate=  self;
    _tableView.dataSource = self;
    _tableView.separatorInset = UIEdgeInsetsMake(0,SCREENWIDTH, 0, 0);
    _tableView.backgroundColor =[UIColor colorWithHex:0xf7f7f7];
    [self.view addSubview:_tableView];
}
-(void)makeData{
    
    dataArrray =[[NSMutableArray alloc] init];//initWithObjects:@"1",@"2",@"3", nil];
    
    if(dataArrray.count == 0){
        _tableView.tableHeaderView = self.headerView;
        
    }else{
        
        _tableView.tableFooterView = self.footerView;

    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArrray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LawBankCardCell  * cell  =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell  =[[[NSBundle mainBundle ]loadNibNamed:@"LawBankCardCell" owner:self options:nil]lastObject];
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
    return 134;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIView *)headerView{
    if(!_headerView){
        _headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 140)];
        _headerView.backgroundColor =[UIColor whiteColor];
        UIButton * imageBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        imageBtn.frame = CGRectMake(0, 0, 44, 44);
        [imageBtn setBackgroundImage:[UIImage imageNamed:@"addcard"] forState:UIControlStateNormal];
        imageBtn.userInteractionEnabled = NO;
//        [imageBtn addTarget:self action:@selector() forControlEvents:UIControlEventTouchUpInside];
        imageBtn.center = CGPointMake(_headerView.centerX, _headerView.centerY - 30);
        [_headerView addSubview:imageBtn];
        
        
        UILabel * addLable =[[UILabel alloc]initWithFrame:CGRectMake(0, imageBtn.bottom+ 18, SCREENWIDTH, 15)];
        addLable.text = @"添加银行卡";
        addLable.textColor = DEEPTintColor;
        addLable.textAlignment = NSTextAlignmentCenter;
        addLable.font = [UIFont systemFontOfSize:15];
        [_headerView addSubview:addLable];
        UILabel * messageLable =[[UILabel alloc]initWithFrame:CGRectMake(0, addLable.bottom +10, SCREENWIDTH, 15)];
        messageLable.text = @"为保证账户资金安全，只能绑定本人的银行卡";
        messageLable.textColor = [UIColor colorWithHex:0xAAAAAA];
        messageLable.textAlignment = NSTextAlignmentCenter;
        messageLable.font = [UIFont systemFontOfSize:12];
        [_headerView whenTapped:^{
            [self  addCardAction];
        }];
        [_headerView addSubview:messageLable];
        
        
    }
    
    
    return _headerView;
}

-(UIView *)footerView{
    if(_footerView){
        _footerView  =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH,100)];
        UIButton * footerBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        footerBtn.frame = CGRectMake(12, 25, SCREENWIDTH - 24, 50);
        
        [Utile makecorner:footerBtn.height/2 view:footerBtn color:[UIColor colorWithHex:0x3181FE]];
        [footerBtn setTitle:@"添加银行卡" forState:UIControlStateNormal];
        footerBtn.adjustsImageWhenHighlighted = NO;
        [footerBtn setTitleColor:[UIColor colorWithHex:0x3181FE] forState:UIControlStateNormal];
        [footerBtn addTarget:self action:@selector(addCardAction) forControlEvents:UIControlEventTouchUpInside];
        [_headerView addSubview:footerBtn];
        
        
    }
    return _footerView;
}
-(void)addCardAction{
    LawAddCardViewController * addCard =[[LawAddCardViewController alloc]init];
    [self.navigationController pushViewController:addCard animated:YES];
    NSLog(@"addCard");
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

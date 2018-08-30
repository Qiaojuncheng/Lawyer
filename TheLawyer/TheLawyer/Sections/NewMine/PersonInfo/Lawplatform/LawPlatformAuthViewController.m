//
//  LawPlatformAuthViewController.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/22.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawPlatformAuthViewController.h"
#import "LawInfoCell.h"
#import "LawIntroducionCell.h"
#import "LawCaseAppreciateDetail.h"
#import "LawSelectTypeofCaseView.h"
#import "LawChagebasicInfoVC.h"
#import "LawplatformEditCell.h"
@interface LawPlatformAuthViewController () <UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray * dataArrray ;
    UITableView * _tableView;
    NSArray * titleArray;
    NSArray * contentArray;
}
@property (strong , nonatomic) UIView * bottomView;
@property (strong , nonatomic) LawSelectTypeofCaseView * selectCaseTypeView;
@end

@implementation LawPlatformAuthViewController

- (void)viewDidLoad {
         [super viewDidLoad];
        [self addCenterLabelWithTitle:@"平台认证" titleColor:nil];
        titleArray = @[@"律所",@"擅长类型",@"电话咨询",@"预约面谈",@"执业证号",@"简介"];
        contentArray = @[@"江南皮革律所",@"婚姻家庭",@"200",@"300",@"10909321u3i435oi",@"我的简介我的简介我的简介我的简介我的简介我的简介我的简介我的简介我的简介我的简介我的简介我的简介我的简介我的简介我的简介我的简介我的简介我的简介我的简介我的简介"];
        self.view.backgroundColor  =   BackViewColor;
        
        [self addView];
    [self.view addSubview:self.selectCaseTypeView];

        // Do any additional setup after loading the view.
    }
-(LawSelectTypeofCaseView *)selectCaseTypeView{
    if (!_selectCaseTypeView) {
        _selectCaseTypeView  =[[LawSelectTypeofCaseView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
        _selectCaseTypeView.dataArray = [[NSMutableArray alloc]initWithArray: @[@"2",@"sd"]];
        _selectCaseTypeView.hidden = YES;
        
    }
    return _selectCaseTypeView;
}
    -(void)addView{
        
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0,  NavStatusBarHeight+10  , SCREENWIDTH, SCREENHEIGHT  -  NavStatusBarHeight  -10) style:UITableViewStylePlain];
        _tableView.delegate=  self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        _tableView.backgroundColor = BackViewColor;
        _tableView.separatorInset = UIEdgeInsetsMake(0,SCREENWIDTH, 0, 0);
        _tableView.tableFooterView =self.bottomView;
        
        [self.view addSubview:_tableView];
    }
    -(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
             return  titleArray.count;
        
        
    }


    
    -(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        if (indexPath.row < 5){
           
            if (indexPath.row == 2 || indexPath.row == 3) {
                
                
                LawplatformEditCell  * cell  =[tableView dequeueReusableCellWithIdentifier:@"cells"];
                if (cell == nil) {
                    cell  =[[[NSBundle mainBundle ]loadNibNamed:@"LawplatformEditCell" owner:self options:nil]lastObject];
                }
                cell.TitleLB.text =[NSString stringWithFormat:@"%@",titleArray[indexPath.row]];
                cell.PriceTextField.text =[NSString stringWithFormat:@"%@",contentArray[indexPath.row]];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.LineView.hidden = NO;
                 return  cell ;
            }
            
                 LawInfoCell  * cell  =[tableView dequeueReusableCellWithIdentifier:@"cell"];
                if (cell == nil) {
                    cell  =[[[NSBundle mainBundle ]loadNibNamed:@"LawInfoCell" owner:self options:nil]lastObject];
                }
                cell.TypeLB.text =[NSString stringWithFormat:@"%@",titleArray[indexPath.row]];
                cell.ConcentLB.text =[NSString stringWithFormat:@"%@",contentArray[indexPath.row]];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.LineView.hidden = NO;
                if (indexPath.row == titleArray.count -1) {
                    cell.LineView.hidden = YES;
                    
                }
                return  cell ;
        }else{
            LawIntroducionCell  * cell  =[tableView dequeueReusableCellWithIdentifier:@"cells"];
            if (cell == nil) {
                cell  =[[[NSBundle mainBundle ]loadNibNamed:@"LawIntroducionCell" owner:self options:nil]lastObject];
            }
             cell.ConcentLB.text =[NSString stringWithFormat:@"%@",contentArray[indexPath.row]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
             return  cell ;
        }
    }
    
    -(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

        if (indexPath.row == 0) {
            LawChagebasicInfoVC * changeName =[[LawChagebasicInfoVC alloc]init];
            changeName.titleStr =@"律所名称";
            changeName.ChangeTextField.placeholder = @"请填写您所在的律所名称";
            changeName.ChangValue = ^(NSString *changeValueStr) {
                
                [_tableView reloadData];
            };
            [self.navigationController pushViewController:changeName animated:YES];

        }else if (indexPath.row == 1) {
            self.selectCaseTypeView.hidden = NO;
        }else      if (indexPath.row == 4) {
            LawChagebasicInfoVC * changeName =[[LawChagebasicInfoVC alloc]init];
            changeName.titleStr =@"执业证号";
            changeName.ChangeTextField.placeholder = @"请填写您的执业证号";
            changeName.ChangValue = ^(NSString *changeValueStr) {
                
                [_tableView reloadData];
            };
            [self.navigationController pushViewController:changeName animated:YES];
            
        }
      
    }
    -(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        if( indexPath.row == 5){
            return 220;
        }else{
            return 60;
        }
    }
    - (void)didReceiveMemoryWarning {
        [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
    }
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 90)];
        _bottomView.backgroundColor = BackViewColor;
        UIButton * submitBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        submitBtn.frame = CGRectMake(15, 20, SCREENWIDTH - 30, 50);
        [submitBtn setBackgroundColor:[UIColor colorWithHex:0x3181FE]];
        [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        submitBtn.adjustsImageWhenHighlighted = NO;
        [submitBtn addTarget:self action:@selector(SubmitAction:) forControlEvents:UIControlEventTouchUpInside];
        [Utile makeCorner:23 view:submitBtn];
        [_bottomView addSubview:submitBtn];
    }
    return _bottomView;
}

-(void)SubmitAction:(UIButton *)sender{
    NSLog(@"提交");
    
}

@end

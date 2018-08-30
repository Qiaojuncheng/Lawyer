//
//  LawPersonInfoViewController.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/21.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawPersonInfoViewController.h"
#import "LawInfoCell.h"
#import "LawInforImageCell.h"
#import "LawPlatformAuthViewController.h"
#import "LawBankCardViewController.h"

#import "LawChagebasicInfoVC.h"
#import "LawChangeSexViewController.h"
#import "LawSeletAreaViewController.h"
#import "LawJCImageSelect.h"

@interface LawPersonInfoViewController ()<selectImagedelegate,UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray * dataArrray ;
    UITableView * _tableView;
    NSArray * titleArray;
    NSArray * contentArray;
}


@end

@implementation LawPersonInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCenterLabelWithTitle:@"个人信息" titleColor:nil];
    titleArray = @[@"头像",@"姓名",@"性别",@"联系电话",@"地区",@"银行卡"];
    contentArray = @[@"image",@"张大锤",@"未选择",@"1089478323",@"江苏-无锡",@"去绑定"];
    self.view.backgroundColor  =   BackViewColor;
    
     [self addView];
    
    // Do any additional setup after loading the view.
}
-(void)addView{
    
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0,  NavStatusBarHeight+1  , SCREENWIDTH, SCREENHEIGHT  -  NavStatusBarHeight  -1) style:UITableViewStylePlain];
    _tableView.delegate=  self;
    _tableView.backgroundColor = BackViewColor;
    _tableView.dataSource = self;
    _tableView.separatorInset = UIEdgeInsetsMake(0,SCREENWIDTH, 0, 0);
    _tableView.tableFooterView = [[UIView alloc]init];
  
     [self.view addSubview:_tableView];
}
 -(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     if(section==0){
         return  titleArray.count;
     }else{
         return 1;
     }
     
 
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return  0.01;
    }else{
        return 10;
    }
 
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return [[UIView alloc]init];
    }else{
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 10)];
        headerView.backgroundColor = BackViewColor;
        return headerView;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0){
        if(indexPath.row == 0){
        LawInforImageCell  * cell  =[tableView dequeueReusableCellWithIdentifier:@"cells"];
        if (cell == nil) {
            cell  =[[[NSBundle mainBundle ]loadNibNamed:@"LawInforImageCell" owner:self options:nil]lastObject];
        }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell ;
        }
        else{
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
        }
    }else if(indexPath.section == 1){
        LawInfoCell  * cell  =[tableView dequeueReusableCellWithIdentifier:@"cells"];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle ]loadNibNamed:@"LawInfoCell" owner:self options:nil]lastObject];
        }
        cell.TypeLB.text =[NSString stringWithFormat:@"平台认证"];
        cell.ConcentLB.text =[NSString stringWithFormat:@"未认证"];
        cell.RedView.hidden = NO;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.LineView.hidden = YES;
        return  cell ;
        
    }
    
    return [[UITableViewCell alloc]init];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==1) {
        if (indexPath.row == 0) {
            LawPlatformAuthViewController * law =[[LawPlatformAuthViewController alloc]init];
            [self.navigationController pushViewController:law animated:YES];
        }
    }else{
        if(indexPath.row == 0){
            LawJCImageSelect * selectImage =[LawJCImageSelect defaultSelectImage];
            selectImage.delegate = self;
                          [ selectImage showInViewController:self];
        }
      else  if ( indexPath.row == 1){
            LawChagebasicInfoVC * changeName =[[LawChagebasicInfoVC alloc]init];
            changeName.titleStr =@"修改昵称";
            changeName.ChangeTextField.text = @"我是假数据";
            changeName.ChangValue = ^(NSString *changeValueStr) {
                
                [_tableView reloadData];
            };
            [self.navigationController pushViewController:changeName animated:YES];
        }else if(indexPath.row == 2){
            LawChangeSexViewController * lawSex =[[LawChangeSexViewController alloc]init];
            //           判断显示
            if (lawSex) {
                lawSex.manBtn.selected = YES;
            }
            lawSex.SexBlock = ^(NSString *sexStr) {
                NSLog(@"block = %@",sexStr);
            };
            [self.navigationController pushViewController:lawSex animated:YES];
            
        }else if(indexPath.row == 4 ){
            LawSeletAreaViewController * area =[[LawSeletAreaViewController alloc]init];
            
            
            [self.navigationController pushViewController:area animated:nil];
        }else if (indexPath.row == 5){
            LawBankCardViewController * card =[[LawBankCardViewController alloc]init];
            [self.navigationController pushViewController:card animated:YES];
            
        }
        
    }
    
    
//    LawCaseAppreciateDetail * detail =[[LawCaseAppreciateDetail alloc]init];
//    [self.navigationController pushViewController:detail animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0 && indexPath.row == 0){
        return 100;
    }else{
        return 60;
    }
}

#pragma mark  选择图片的代理
-(void)seleWithImage:(UIImage *)selectImage{
    
    
}
-(void)cancelSelecImage{
    
    
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

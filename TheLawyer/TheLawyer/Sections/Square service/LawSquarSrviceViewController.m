//
//  LawSquarSrviceViewController.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/17.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//


#import "LawSquarSrviceViewController.h"

#import "LawMessageModel.h"
#import "LawMainConsultCell.h"
#import "JSDropDownMenu.h"
#import "LawConsultDetailViewController.h"

#import "LawSquarServiceCell.h"
#import  "LawSquarSrviceViewDetailController.h"
@interface LawSquarSrviceViewController ()<UITableViewDataSource,UITableViewDelegate,JSDropDownMenuDelegate,JSDropDownMenuDataSource>{
    JSDropDownMenu *menu;
    
    NSArray * data1;
    NSArray * data2;
    NSArray * data3;
    
    NSMutableArray * dataArrray ;
    UITableView * _tableView;
}

@end

@implementation LawSquarSrviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCenterLabelWithTitle:self.ServiceTitle titleColor:nil];
    
    data2 = @[@"案件类型",@"",@"",@"",@"",@"",@""];
    data3 = @[@"",@"",@"",@"",@"",@"",@""];
     [self makedata];
    [self makemenu];
    [self addView ];
    // Do any additional setup after loading the view.
}
-(void)makemenu{
    menu = [[JSDropDownMenu alloc]initWithOrigin:CGPointMake(0, NavStatusBarHeight) andHeight:46];
    menu.indicatorColor = [UIColor   grayColor];
    menu.separatorColor = [UIColor clearColor];
    menu.textColor = [UIColor lightGrayColor];
    menu.dataSource = self;
    menu.delegate = self;
    menu.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:menu];
    
}
-(BOOL)haveRightTableViewInColumn:(NSInteger)column{
    
    if (column == 0) {
        return  YES;
    }
    return NO;
}
-(NSInteger)menu:(JSDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column leftOrRight:(NSInteger)leftOrRight leftRow:(NSInteger)leftRow{
    if (column == 0) {
        if(leftOrRight){//  0 左侧  1 右侧
            return 5;
        }else{
            return 30;
        }
    }else if(column == 1){
        return 5;
        
    }else if(column == 2){
        return 8;
        
    }
    
    return 5;
}
-(NSInteger)numberOfColumnsInMenu:(JSDropDownMenu *)menu{
    return 3;
}
-(NSString *)menu:(JSDropDownMenu *)menu titleForColumn:(NSInteger)column{
    
    switch (column) {
        case 0:
            return @"省份" ;
            break;
            //        case 1: return _data2[0];
        case 1:
            return @"案件类型";
            break;
        case 2:
            return @"发布时间";
            break;
        default:
            return nil;
            break;
    }
    
}
-(NSString *)menu:(JSDropDownMenu *)menu titleForRowAtIndexPath:(JSIndexPath *)indexPath{
    
    
    switch (indexPath.column) {
        case 0:
            if (indexPath.leftOrRight) {
                return [NSString stringWithFormat:@"第%ld个市",indexPath.row]; //_data1[indexPath.row][@"cat_name"] ;
                
            }else{
                return [NSString stringWithFormat:@"第%ld个省份",indexPath.row]; //_data1[indexPath.row][@"cat_name"] ;
                
            }
            break;
            //        case 1: return _data2[0];
        case 1:return [NSString stringWithFormat:@"第%ld个案件类型",indexPath.row];//@"dasdfa";//_data2[indexPath.row][@"level_name"];
            break;
        case 2: return  [NSString stringWithFormat:@"时间%ld",indexPath.row];//_data3[indexPath.row];
            break;
        default:
            return nil;
            break;
    }
}

- (NSInteger)currentLeftSelectedRow:(NSInteger)column {
    return 5;
}


- (CGFloat)widthRatioOfLeftColumn:(NSInteger)column {
    if (column ==0) {
        return  .5f;
        
    }else{
        return  1;
        
    }
}

-(void)menu:(JSDropDownMenu *)menu didSelectRowAtIndexPath:(JSIndexPath *)indexPath{
    
    switch (indexPath.column) {
        case 0:
            
            
            break;
        case 1:
            
            break;
        case 2:
            
            break;
        default:
            break;
    }
    
}

-(void)makedata{
    
     
}
-(void)addView{
    
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0,  NavStatusBarHeight  + 44, SCREENWIDTH, SCREENHEIGHT  -  NavStatusBarHeight -44) style:UITableViewStylePlain];
    _tableView.delegate=  self;
    _tableView.dataSource = self;
    _tableView.separatorInset = UIEdgeInsetsMake(0,SCREENWIDTH, 0, 0);
    _tableView.backgroundColor =[UIColor whiteColor];
    _tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:_tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArrray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LawSquarServiceCell  * cell  =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell  =[[[NSBundle mainBundle ]loadNibNamed:@"LawSquarServiceCell" owner:self options:nil]lastObject];
    }
    //    cell.model = dataArrray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell ;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LawSquarSrviceViewDetailController * detail =[[LawSquarSrviceViewDetailController alloc]init];
    [self.navigationController pushViewController:detail animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
         return 178;
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

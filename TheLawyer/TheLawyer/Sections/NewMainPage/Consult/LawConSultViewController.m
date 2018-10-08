//
//  LawConSultViewController.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/16.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawConSultViewController.h"
#import "LawMessageModel.h"
#import "LawMainConsultCell.h"
#import "JSDropDownMenu.h"
#import "LawAddressModel.h"
#import "LawConsultTypeModel.h"
#import "LawConsultDetailViewController.h"
#import "MJRefresh.h"

@interface LawConSultViewController() <UITableViewDataSource,UITableViewDelegate,JSDropDownMenuDelegate,JSDropDownMenuDataSource>{
    JSDropDownMenu *menu;

    NSMutableArray * data1;
    NSMutableArray * data2;
    NSArray * data3;
    
    NSMutableArray * dataArrray ;
    UITableView * _tableView;
    
    NSString * cate_id;// 案件的id
    NSString *area;// 区域id
    NSString *order ;   // 默认 @""    正序 正序 1
    
    NSInteger page ;
}


@end

@implementation LawConSultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dataArrray   =[[NSMutableArray alloc]init];
    order = @"";
    cate_id = @"";
    area = @"";
    page =1 ;
    [self addCenterLabelWithTitle:@"咨询" titleColor:nil];
    [self makeAddreeData];
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
    
    
    menu.SelectArray =[[NSMutableArray alloc]init];
    NSArray * numbe = @[@3,@2,@1];
    for(int i = 0 ;i<3 ;i++){
        
        NSMutableArray * nsmutable =[[NSMutableArray alloc]init];
        NSInteger  haveRightTableView = [numbe[i] intValue];
        for (int j = 0; j< haveRightTableView ; j++) {
            NSInteger number = 0;
            [nsmutable addObject:@(number)];
        }
        
        [menu.SelectArray addObject:nsmutable];
    }

    
    
}

-(NSInteger )haveRightTableViewInColumn:(NSInteger)column{
//    0 一个  1 两个    2 三个
    if (column == 0) {
        return  2;
    }else if(column== 1){
        return 1;
    }
    return 0;
}
-(NSInteger)menu:(JSDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column leftOrRight:(NSInteger)leftOrRight leftRow:(NSInteger)leftRow{
    
      NSMutableArray * ColumnlectDataArray    =[[NSMutableArray alloc]initWithArray:menu.SelectArray[column]];
    
    if (column == 0) {
        if(leftOrRight == 0){//  0 左侧  1 中间  2 右侧
            return data1.count;
        }else if(leftOrRight == 1){
            LawAddressModel * proModel = data1[[ColumnlectDataArray[0] integerValue]];
            return proModel.child.count;
        }else if(leftOrRight == 2){
            
            LawAddressModel * proModel = data1[[ColumnlectDataArray[0] integerValue]];
            LawAddressModel * cityModel = proModel.child[[ColumnlectDataArray[1] integerValue]];
            
            return cityModel.child.count;

        }
        
     }else if(column == 1){
         if(leftOrRight == 0){//  0 左侧  1 中间  2 右侧
             return data2.count;
         }else if(leftOrRight == 1){

             LawConsultTypeModel * TypeModel = data2[[ColumnlectDataArray[0] integerValue]];
            
             
 
             return TypeModel.second_child.count;
             
             
         }
    }else if(column == 2){
        return data3.count;

    }
    
    return 0;
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
   
    NSMutableArray * ColumnlectDataArray    =[[NSMutableArray alloc]initWithArray:menu.SelectArray[indexPath.column]];
    
 
 
    switch (indexPath.column) {
        case 0:
            
 
            if (indexPath.leftOrRight == 0) {
                LawAddressModel * Promodle =   data1[indexPath.row];
                return [NSString stringWithFormat:@"%@",Promodle.name];
            }else if (indexPath.leftOrRight == 1){
                NSNumber * leftSelectNumber =   ColumnlectDataArray[0];
                   LawAddressModel * proModel = data1[[leftSelectNumber  integerValue]];
                LawAddressModel * Citymodle =   proModel.child[indexPath.row];
                return [NSString stringWithFormat:@"%@",Citymodle.name]; //_data1[indexPath.row][@"cat_name"] ;

            }else{
                NSNumber * leftSelectNumber =   ColumnlectDataArray[0];
                NSNumber * rightSelectNumber =   ColumnlectDataArray[1];
                 LawAddressModel * proModel = data1[[leftSelectNumber integerValue] ];
                LawAddressModel * Citymodle =   proModel.child[[rightSelectNumber integerValue]];
                LawAddressModel * Areamodel =   Citymodle.child[indexPath.row];

                return [NSString stringWithFormat:@"%@",Areamodel.name]; //
            }
            break;
            //        case 1: return _data2[0];
        case 1:
            if (indexPath.leftOrRight == 0) {
                LawConsultTypeModel * typeOne = data2[indexPath.row];
                return typeOne.name;
                
            }else{
                NSNumber * leftSelectNumber =   ColumnlectDataArray[0];
                LawConsultTypeModel * typeOne = data2[[leftSelectNumber integerValue]];
                 LawConsultTypeModel * typtwo = typeOne.second_child[indexPath.row];
 
                return typtwo.name;

            }
             break;
        case 2:
             return  data3[indexPath.row];
             break;
        default:
            return nil;
            break;
    }
}

//-(NSInteger)currentLeftSelectedRow:(NSInteger)column {
// 
 //}
- (CGFloat)widthRatioOfLeftColumn:(NSInteger)column {
    if (column ==0) {
        return  .33333f;

    }else if(column ==1){
        return  0.5;
    }else{
        return  1;
        
    }
}

-(void)menu:(JSDropDownMenu *)menu didSelectRowAtIndexPath:(JSIndexPath *)indexPath{
    
    NSMutableArray * ColumnlectDataArray =menu.SelectArray[indexPath.column];
        switch (indexPath.column) {
        case 0:
                 if(indexPath.leftOrRight ==2){
                    NSNumber * leftSelectNumber =   ColumnlectDataArray[0];
                    NSNumber * rightSelectNumber =   ColumnlectDataArray[1];
                    LawAddressModel * proModel = data1[[leftSelectNumber integerValue] ];
                    LawAddressModel * Citymodle =   proModel.child[[rightSelectNumber integerValue]];
                    LawAddressModel * Areamodel =   Citymodle.child[indexPath.row];
                     area = Areamodel.id;
                    NSLog(@"first %@ = id= %@",Areamodel.name ,Areamodel.id);
                     page = 1;
                     [self makedata];

                 }
             break;
        case 1:
                if (indexPath.leftOrRight == 1) {
                    NSNumber * leftSelectNumber =   ColumnlectDataArray[0];
                    LawConsultTypeModel * typeOne = data2[[leftSelectNumber integerValue]];
                    LawConsultTypeModel * typtwo = typeOne.second_child[indexPath.row];
                    cate_id = typtwo.id;
                    NSLog(@" third = %@ ，name = %@  ",typtwo.id,typtwo.name);
                    page = 1;
                    [self makedata];

                }
            break;
        case 2:
                    if (indexPath.row == 0) {
                        order = @"";
                     }else{
                        order = @"1";
                       }
                page = 1;
                [self makedata];

              
             break;
        default:
            break;
    }
    
}

-(void)makedata{
  
    NSMutableDictionary * dic  =[[NSMutableDictionary alloc]init];
    NewConsult
    NSMutableDictionary *   valueDic =[[NSMutableDictionary alloc]init];
    [valueDic setObject:UserId forKey:@"lawyer_id" ];
    [valueDic setObject:@"2" forKey:@"type" ];
 
    [valueDic setObject:[NSString stringWithFormat:@"%ld",page ] forKey:@"p" ];
    [valueDic setObject:order forKey:@"order" ];
    [valueDic setObject:cate_id  forKey:@"cate_id" ];
    [valueDic setObject:area forKey:@"area" ];

    NSString * baseStr = [NSString getBase64StringWithArray:valueDic];
    [dic setValue:baseStr forKey:@"value"];
    NSLog(@"dic = %@",dic);
    [self showHudInView:self.view hint:nil];
    
    [HttpAfManager postWithUrlString:BASE_URL parameters:dic success:^(id data) {
        NSLog(@"%@",data);
        if (page ==1) {
            [dataArrray removeAllObjects];
        }
        NSString * codeStr =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([codeStr isEqualToString:@"0"]) {
            
            for (NSDictionary * dics in data[@"data"]) {
                LawMainConsultCellMoldel * model =  [LawMainConsultCellMoldel yy_modelWithDictionary:dics];
                [dataArrray addObject:model];
                
            }
            
            [_tableView reloadData];
        }
        [self hideHud];
        [_tableView.mj_footer endRefreshing];
        [_tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [self hideHud];
        [_tableView.mj_footer endRefreshing];
        [_tableView.mj_header endRefreshing];
    }];
 
}
-(void)addView{
    
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0,  NavStatusBarHeight + 10 + 44, SCREENWIDTH, SCREENHEIGHT -10 -  NavStatusBarHeight -44) style:UITableViewStylePlain];
    _tableView.delegate=  self;
    _tableView.dataSource = self;
    _tableView.backgroundColor =[UIColor whiteColor];
    _tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:_tableView];

    _tableView.mj_header  = [MJRefreshNormalHeader  headerWithRefreshingBlock:^{
        page = 1;
        [self makedata];
    }];
    _tableView.mj_footer =[MJRefreshBackNormalFooter   footerWithRefreshingBlock:^{
        page += 1;
        [self makedata];

    }];
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArrray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LawMainConsultCell  * cell  =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell  =[[[NSBundle mainBundle ]loadNibNamed:@"LawMainConsultCell" owner:self options:nil]lastObject];
    }
    cell.model = dataArrray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell ;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    LawConsultDetailViewController * detail =[[LawConsultDetailViewController alloc]init];
    
    LawMainConsultCellMoldel *model = dataArrray[indexPath.row];
    model.is_read =@"0"; // 去掉红点
    [dataArrray replaceObjectAtIndex:indexPath.row withObject:model];
//    detail.model =  model;
    detail.constultId = model.id;
    detail.reloadBlock = ^{
        [_tableView reloadData];
//        page = 1;
//        [self makedata];
    };

    
    detail.type= @"2";
    [self.navigationController pushViewController:detail animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 124;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)makeAddreeData{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"AreaData" ofType:@"plist"];
    NSArray *   plistData = [NSMutableArray arrayWithContentsOfFile:path];
    data1 =[[NSMutableArray alloc]init];
    for (NSDictionary * proDic in plistData) {
        //省
        LawAddressModel * proModel =[LawAddressModel yy_modelWithJSON:proDic];
        [data1 addObject:proModel];
        
    }
    
    data3 = @[@"时间↓",@"时间↑"];
    
    
    NSMutableDictionary * dic =[[NSMutableDictionary alloc]init];
    NewConsultGetType
    
    
    //    获取分类
    
    [AFManagerHelp POST:BASE_URL parameters:dic success:^(id responseObjeck) {
        // 处理数据
        DLog(@"%@",responseObjeck);
        [self hideHud];
        data2 =[[NSMutableArray alloc]init];
        if ([responseObjeck[@"status"] integerValue] == 0) {
            for (NSDictionary * proDic in responseObjeck[@"data"]) {
                
                LawConsultTypeModel * TypeModel =[LawConsultTypeModel yy_modelWithJSON:proDic];
                [data2 addObject:TypeModel];
                
            }
            
        }else{
        }
    } failure:^(NSError *error) {
        [self hideHud];
    }];
    
    
}


@end

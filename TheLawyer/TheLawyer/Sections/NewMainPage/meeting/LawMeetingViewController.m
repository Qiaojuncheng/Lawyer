//
//  LawMeetingViewController.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/18.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawMeetingViewController.h"
#import "LawMessageModel.h"
#import "LawMainConsultCell.h"
#import "JSDropDownMenu.h"
#import "LawConsultDetailViewController.h"

#import "LawAddressModel.h"
#import "LawConsultTypeModel.h"

#import "LawMeetingCell.h"
#import  "LawSquarSrviceViewDetailController.h"


@interface LawMeetingViewController ()<UITableViewDataSource,UITableViewDelegate,JSDropDownMenuDelegate,JSDropDownMenuDataSource>{
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

@implementation LawMeetingViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCenterLabelWithTitle:self.meetTing titleColor:nil];
    MJWeakSelf;
    [self addRightButtonWithTitle:@"全部" titleColor: [UIColor blackColor] actionBlock:^{
        order = @"";
        cate_id = @"";
        area = @"";
        page =1 ;
        [weakSelf makedata];
    }];
    if ([self.meetTing isEqualToString:@"电话预约"]) {
        NSUserDefaults * UserDefaults =[ NSUserDefaults standardUserDefaults];
        [UserDefaults setBool:YES  forKey:@"phoneN"];
        [UserDefaults synchronize];
        
    }else{
        NSUserDefaults * UserDefaults =[ NSUserDefaults standardUserDefaults];
        [UserDefaults setBool:YES  forKey:@"meetN"];
        [UserDefaults synchronize];
        
    }


    dataArrray   =[[NSMutableArray alloc]init];
    order = @"";
    cate_id = @"";
    area = @"";
    page =1 ;
    
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
            return @"区域" ;
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
    NewMeetGetyuYue
    NSMutableDictionary *   valueDic =[[NSMutableDictionary alloc]init];
    [valueDic setObject:UserId forKey:@"lawyer_id" ];
    if ([self.meetTing isEqualToString:@"电话预约"]) {
        [valueDic setObject:@"1" forKey:@"type" ];
    }else{
        [valueDic setObject:@"2" forKey:@"type" ];
    }
    
    [valueDic setObject:[NSString stringWithFormat:@"%ld",page ] forKey:@"p" ];
    [valueDic setObject:order forKey:@"order" ];
    [valueDic setObject:cate_id  forKey:@"cate_id" ];
    [valueDic setObject:area forKey:@"area" ];
    if(self.mid){
        [valueDic setObject:self.mid forKey:@"mid" ];
        [valueDic setObject:self.tid forKey:@"tid" ];
        
    }
    NSString * baseStr = [NSString getBase64StringWithArray:valueDic];
    [dic setValue:baseStr forKey:@"value"];
    NSLog(@"dic = %@",dic);
    if(page==1){
        [self showHudInView:self.view hint:nil];
        
    }
    [HttpAfManager postWithUrlString:BASE_URL parameters:dic success:^(id data) {
        NSLog(@"%@",data);
    
        if (page ==1) {
            [dataArrray removeAllObjects];
        }
        NSString * codeStr =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([codeStr isEqualToString:@"0"]) {
            
            for (NSDictionary * dics in data[@"data"]) {
                LawMessageModel * model =  [LawMessageModel yy_modelWithDictionary:dics];
                [dataArrray addObject:model];
                
            }
            
            [_tableView reloadData];
        }
        [self hideHud];
        [_tableView.mj_footer  endRefreshing];
        [_tableView.mj_header  endRefreshing];
        
    } failure:^(NSError *error) {
        [self hideHud];
        [_tableView.mj_footer endRefreshing];
        [_tableView.mj_header endRefreshing];
    }];
    
   
}
-(void)addView{
    
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0,  NavStatusBarHeight  + 44, SCREENWIDTH, SCREENHEIGHT  -  NavStatusBarHeight -44) style:UITableViewStylePlain];
    _tableView.delegate=  self;
    _tableView.dataSource = self;
    _tableView.separatorInset = UIEdgeInsetsMake(0,SCREENWIDTH, 0, 0);
    _tableView.backgroundColor =[UIColor whiteColor];
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableView.mj_header  = [MJRefreshNormalHeader  headerWithRefreshingBlock:^{
        page = 1;
        [self makedata];
    }];
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight= 0;
    _tableView.estimatedSectionFooterHeight= 0;

    _tableView.mj_footer =[MJRefreshAutoFooter   footerWithRefreshingBlock:^{
        page += 1;
        [self makedata];
        
    }];
    [self.view addSubview:_tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArrray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LawMeetingCell  * cell  =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell  =[[[NSBundle mainBundle ]loadNibNamed:@"LawMeetingCell" owner:self options:nil]lastObject];
    }
    cell.model = dataArrray[indexPath.row];
    cell.ChangeStatusBlock = ^(NSInteger index, NSString *meetid) {
        
        [self changeStautsWithIndex:index AndId:meetid];
   
    };
    if ( [self.meetTing isEqualToString:@"电话预约"]) {
        cell.MeetTimeL.hidden = YES;
        cell.ConTainViewHeight.constant = 63;

    }else{
        cell.MeetTimeL.hidden = NO;
        cell.ConTainViewHeight.constant = 78;

     }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell ;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    LawSquarSrviceViewDetailController * detail =[[LawSquarSrviceViewDetailController alloc]init];
//    [self.navigationController pushViewController:detail animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if ( [self.meetTing isEqualToString:@"电话预约"]) {
        return 160;

    }else{
        return 175;
    }
    
}
-(void)changeStautsWithIndex:(NSInteger )index AndId:(NSString *)messageID{
  
 
    //     30 拒绝 31 同意   32 完成
    NSMutableDictionary * dic =[[NSMutableDictionary alloc]init];
    NSMutableDictionary * valuedic =[[NSMutableDictionary alloc]init];
    [valuedic setValue:messageID forKey:@"id"];
    
    if (index == 30) {
        NewMeetYuYueStatus
        [valuedic setValue:UserId forKey:@"lawyer_id"];
        [valuedic setValue:@"3" forKey:@"status"];

    }else if(index ==31){
        NewMeetYuYueStatus
        [valuedic setValue:UserId forKey:@"lawyer_id"];
        [valuedic setValue:@"2" forKey:@"status"];

    }else if(index ==32){
        NewMeetyuYueOver
 
    }
    
    NSString * baseStr = [NSString getBase64StringWithArray:valuedic];
    [dic setValue:baseStr forKey:@"value"];
    [AFManagerHelp POST:BASE_URL parameters:dic success:^(id responseObjeck) {
        // 处理数据
        DLog(@"%@",responseObjeck);
  
        [self hideHud];
         if ([responseObjeck[@"status"] integerValue] == 0) {
            
             page = 1;
             [self makedata];
//             [_tableView.mj_header beginRefreshing];
        }else{
            [self showHint:responseObjeck[@"msg"]];
        }
    } failure:^(NSError *error) {
        [self hideHud];
        [self showHint:@"操作失败"];

    }];
    
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

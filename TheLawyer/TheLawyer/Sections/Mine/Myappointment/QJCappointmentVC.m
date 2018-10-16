//
//  QJCappointmentVC.m
//  TheLawyer
//
//  Created by MYMAc on 2017/11/4.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import "QJCappointmentVC.h"
#import "QJCAppointCell.h"
#import "QJCAppointModel.h"

@interface QJCappointmentVC ()<UITableViewDelegate,UITableViewDataSource>{

    UITableView * _Tv;
    NSMutableArray * DataArray;
    NSInteger Page;
    
    
}

@end

@implementation QJCappointmentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCenterLabelWithTitle:self.TitleStr titleColor:[UIColor whiteColor]];
    Page = 1;
    DataArray =[[NSMutableArray alloc]init];
    [self MakeUI];
    [self makeData];
    // Do any additional setup after loading the view.
}
-(void)MakeUI{
    
    _Tv =[[UITableView alloc]initWithFrame:CGRectMake(0, NavStatusBarHeight,SCREENWIDTH , SCREENHEIGHT - NavStatusBarHeight) style:UITableViewStylePlain];
    _Tv.delegate= self;
    _Tv.dataSource= self;
    _Tv.tableFooterView =[[UIView alloc]init];
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH - 0, 60)];
    UILabel *titileLB =[[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREENWIDTH -20, 60)];
    titileLB.text =@"套餐支付的订单，由平台与您协商结算，并不按照你填写的预约价格！";
    titileLB.numberOfLines = 2;
    titileLB.textColor =[UIColor whiteColor];
    titileLB.backgroundColor =[UIColor clearColor];
    headerView.backgroundColor =[UIColor colorWithColor:[UIColor blackColor] alpha:.7];
    titileLB.font =[UIFont systemFontOfSize:14];
   [headerView addSubview:titileLB];
    
    _Tv.tableHeaderView = headerView;
    _Tv.estimatedRowHeight = 0;
    _Tv.estimatedSectionHeaderHeight= 0;
    _Tv.estimatedSectionFooterHeight= 0;
    
    

    _Tv.mj_footer =[MJRefreshAutoFooter footerWithRefreshingBlock:^{
        Page ++;
        [self makeData];
    }];
    _Tv.mj_header  =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        Page =1;
        [self makeData];
    }];
     [self.view addSubview:_Tv];
    
}
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return DataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    QJCAppointModel * model = DataArray[indexPath.row];
    return 174 + model.cellHeight;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    QJCAppointModel * model = DataArray[indexPath.row];
    QJCAppointCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"QJCAppointCell" owner:self options:nil]lastObject];
    }
    cell.model = model;
    
    cell.Block = ^(NSString *type, NSString *id) {
//       type  2 同意  3 拒绝 4 完成
        if([type isEqualToString:@"4"]){
            [self makeOverActinWithId:id];
        }else{
            [self makeAgreeOrRefuseWithType:type andId:id Index:indexPath.row];
        }
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell;
    
}
-(void)makeData{
    NSMutableDictionary * dic  =[[NSMutableDictionary alloc]init];
    QJYUYUE
    NSMutableDictionary *   valueDic =[[NSMutableDictionary alloc]init];
    [valueDic setObject:UserId forKey:@"user_id"];
    [valueDic setObject:[NSString stringWithFormat:@"%ld",Page] forKey:@"p"];
    if (self.appointId) {
        [valueDic setObject:self.appointId forKey:@"id"];
     }else{
         
     }
    NSString * baseStr = [NSString getBase64StringWithArray:valueDic];
    [dic setValue:baseStr forKey:@"value"];
    
    if(Page==1){
        [self showHudInView:self.view hint:nil];
        
    }
    [HttpAfManager postWithUrlString:BASE_URL parameters:dic success:^(id data) {
        NSLog(@"%@",data);
        if(Page == 1){
            [DataArray removeAllObjects];
        }
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            
            for (NSDictionary * dic in data[@"data"]) {
                QJCAppointModel * model =  [QJCAppointModel yy_modelWithJSON:dic];
                [model MakeCellHeight];
                [DataArray addObject:model];
            }
        }else{
            NSString * msg = [NSString stringWithFormat:@"%@",data[@"msg"]];
            [self showHint:msg];
        }
        [_Tv reloadData];
        [self hideHud];
        
        
        if ( DataArray.count == 0) {
            [self ShowNoDataViewWithStr:@"暂无数据" yOffset:50];
        }else{
            [self hintNodataView];
        }
        
        [_Tv.mj_footer endRefreshing];
        [_Tv.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [_Tv.mj_footer endRefreshing];
        [_Tv.mj_header endRefreshing];
        if ( DataArray.count == 0) {
            [self ShowNoDataViewWithStr:@"暂无数据" yOffset:50];
        }else{
            [self hintNodataView];
        }
        
        [self hideHud];
        NSLog(@"%@",error);
    }];
}
-(void)makeOverActinWithId:(NSString *)Yuyue_id{
    
    NSMutableDictionary * dic  =[[NSMutableDictionary alloc]init];
    QJYUYUE_Over
    NSMutableDictionary *   valueDic =[[NSMutableDictionary alloc]init];
//    [valueDic setObject:UserId forKey:@"user_id"];
    [valueDic setObject:Yuyue_id forKey:@"id"];
  
    NSString * baseStr = [NSString getBase64StringWithArray:valueDic];
    [dic setValue:baseStr forKey:@"value"];
    
    [self showHudInView:self.view hint:nil];
    [HttpAfManager postWithUrlString:BASE_URL parameters:dic success:^(id data) {
        NSLog(@"%@",data);
 
        for (int i  = 0; i< DataArray.count; i++) {
            QJCAppointModel * model = DataArray[i];

            NSLog(@"model.id = %@ i = %d,yue_id = %@",model.id, i , Yuyue_id);
            if ([model.id isEqualToString:Yuyue_id]) {
                model.status = @"4";
                [DataArray replaceObjectAtIndex:i withObject:model];
             break;
            }
        }
            
        [_Tv.mj_footer endRefreshing];
        [_Tv.mj_header endRefreshing];

        [_Tv reloadData];
        [self hideHud];
        
    } failure:^(NSError *error) {
        [_Tv.mj_footer endRefreshing];
        [_Tv.mj_header endRefreshing];
         NSLog(@"%@",error);
    }];
    
}

-(void)makeAgreeOrRefuseWithType:(NSString *)Type andId:(NSString *)Id Index:(NSInteger )index{
     NSMutableDictionary * dic  =[[NSMutableDictionary alloc]init];
    QJYUYUEStaTus
    NSMutableDictionary *   valueDic =[[NSMutableDictionary alloc]init];
    [valueDic setObject:UserId forKey:@"user_id"];
    [valueDic setObject:Id forKey:@"id"];
    [valueDic setObject:Type forKey:@"status"];

    NSString * baseStr = [NSString getBase64StringWithArray:valueDic];
    [dic setValue:baseStr forKey:@"value"];
    
    [self showHudInView:self.view hint:nil];
    [HttpAfManager postWithUrlString:BASE_URL parameters:dic success:^(id data) {
        NSLog(@"%@",data);
       
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            QJCAppointModel * model = DataArray[index];
            model.status = Type;
            [DataArray replaceObjectAtIndex:index withObject:model];
        }
        [_Tv reloadData];
        [self hideHud];
        [_Tv.mj_header endRefreshing];
        [_Tv.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        [_Tv.mj_header endRefreshing];
        [_Tv.mj_footer endRefreshing];
        [self hideHud];
        NSLog(@"%@",error);
    }];

    
    
    
}
-(void)didReceiveMemoryWarning {
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

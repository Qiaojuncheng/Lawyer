//
//  QJCSerViceVC.m
//  TheLawyer
//
//  Created by MYMAc on 2017/11/6.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import "QJCSerViceVC.h"
#import "RecordModel.h"
#import "RecoudCell.h"
#import "MainDetailViewController.h"
@interface QJCSerViceVC (){
    NSInteger Page;
}

@end

@implementation QJCSerViceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    Page = 1;
    [self makeUI];

    [self makeData];
    // Do any additional setup after loading the view.
}
-(void)makeUI{
    DataArray  = [[NSMutableArray alloc]init];
    _TV  =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH,SCREENHEIGHT - 42- 64) style:UITableViewStylePlain];
    _TV.delegate = self;
    _TV.dataSource= self;
    _TV.tableFooterView = [[UIView alloc]init];
    _TV.mj_footer =[MJRefreshAutoFooter footerWithRefreshingBlock:^{
        Page ++;
        [self makeData];
    }];
    _TV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        Page =1;
        [self makeData];
    }];
    _TV.estimatedRowHeight = 0;
    _TV.estimatedSectionHeaderHeight= 0;
    _TV.estimatedSectionFooterHeight= 0;
    
    
    

    [self.view addSubview:_TV];
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  DataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RecoudCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell =  [[[NSBundle mainBundle]loadNibNamed:@"RecoudCell" owner:self options:nil]lastObject];
    }
    
    if([self.Type isEqualToString:@"3"]){
         cell.TitleLB.text = @"代写文书";
     }else if([self.Type isEqualToString:@"4"]){
        cell.TitleLB.text = @"案件委托";
     }else if([self.Type isEqualToString:@"5"]){
         cell.TitleLB.text = @"合同审查";
    }else if([self.Type isEqualToString:@"6"]){
        cell.TitleLB.text = @"发律师函";
     }
    RecordModel * model  = DataArray[indexPath.row];
    cell.model = model;
    WS(ws)
    [cell.DetailLB whenTouchedUp:^{
        MainDetailViewController * joke = [[MainDetailViewController alloc] init];
        joke.type = ws.Type;
        joke.HideQiangdan = YES;
        joke.typeId = model.rid;
        joke.titleType = 1;
        [self.navigationController pushViewController:joke animated:YES];
    }];
    cell.Block = ^{
        [self makeOverWithId:model.id andIndex:indexPath.row];

    };
  //    status  4 daipingjia
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark   完成
-(void)makeOverWithId:(NSString *)overId andIndex:(NSInteger)index{
    
    
    NSMutableDictionary * dic  =[[NSMutableDictionary alloc]init];
    QJLAWYEROVER
    NSMutableDictionary *   valueDic =[[NSMutableDictionary alloc]init];
     [valueDic setObject: overId forKey:@"id"];
    [valueDic setObject:self.Type forKey:@"type"];
    NSString * baseStr = [NSString getBase64StringWithArray:valueDic];
    [dic setValue:baseStr forKey:@"value"];
      [HttpAfManager postWithUrlString:BASE_URL parameters:dic success:^(id data) {
      
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            RecordModel * model  = DataArray[index];
            model.status = @"4";
            [DataArray replaceObjectAtIndex:index withObject:model];
         }else{
            NSString * msg = [NSString stringWithFormat:@"%@",data[@"msg"]];
            [self showHint:msg];
        }
        [_TV reloadData];
        [self hideHud];
        
       
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];

    
}
-(void)makeData{
 
    NSMutableDictionary * dic  =[[NSMutableDictionary alloc]init];
    QJCSERVICE
    NSMutableDictionary *   valueDic =[[NSMutableDictionary alloc]init];
    [valueDic setObject:UserId forKey:@"user_id"];
    [valueDic setObject:[NSString stringWithFormat:@"%ld",Page] forKey:@"p"];
    [valueDic setObject:self.Type forKey:@"type"];
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
                RecordModel * model =  [RecordModel yy_modelWithJSON:dic];
                 [DataArray addObject:model];
            }
        }else{
//            NSString * msg = [NSString stringWithFormat:@"%@",data[@"msg"]];
//            [self showHint:msg];
        }
        [_TV reloadData];
        [self hideHud];
 
        if ( DataArray.count == 0) {
            [self ShowNoDataViewWithStr:@"暂无数据" yOffset:50];
        }else{
            [self hintNodataView];
        }
        [_TV.mj_header endRefreshing];
        [_TV.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        [_TV.mj_header endRefreshing];
        [_TV.mj_footer endRefreshing];
        if ( DataArray.count == 0) {
            [self ShowNoDataViewWithStr:@"暂无数据" yOffset:50];
        }else{
            [self hintNodataView];
        }
        
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

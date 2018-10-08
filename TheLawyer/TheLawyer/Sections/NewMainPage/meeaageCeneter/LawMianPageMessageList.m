//
//  LawMianPageMessageList.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/16.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawMianPageMessageList.h"
#import "LawNewMessageMM.h"
#import "LawMessageCenterCell.h"
#import "LawMeetingViewController.h"
#import "LawConsultDetailViewController.h"
#import "LawPersonInfoViewController.h"
#import "LawHeartViewController.h"
@interface LawMianPageMessageList (){
    NSMutableArray * dataArrray ;
    UITableView * _tableView;
    NSInteger page ;
}

@end

@implementation LawMianPageMessageList


- (void)viewDidLoad {
    [super viewDidLoad];
    page=  1;
    [self makedata];
    dataArrray   =[[NSMutableArray alloc]init];

      [self addView ];
    // Do any additional setup after loading the view.
}
-(void)makedata{
    
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    NewMymessageList
    if( [UserId length] < 1){
        return ;
    }
    NSDictionary * valudic  = @{@"lawyer_id":UserId,@"p":[NSString stringWithFormat:@"%ld",page]};
    NSString * baseStr = [NSString getBase64StringWithArray:valudic];
    [dic setValue:baseStr forKey:@"value"];
     [self showHudInView:self.view hint:nil];
 
    [HttpAfManager postWithUrlString:BASE_URL parameters:dic success:^(id data) {
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
             if (page == 1) {
                [dataArrray removeAllObjects];
            }
            for (NSDictionary * dicc in data[@"data"]) {
                LawNewMessageMM * model = [LawNewMessageMM yy_modelWithJSON:dicc];
                [dataArrray addObject:model];
            }
            [_tableView reloadData];
        }
        [self hideHud];
        [_tableView.mj_footer endRefreshing];
        [_tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [_tableView.mj_footer endRefreshing];
        [_tableView.mj_header endRefreshing];
        [self hideHud];
        NSLog(@"%@",error);
    }];

}
-(void)addView{
    
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0,  10, SCREENWIDTH, SCREENHEIGHT -10 -  NavStatusBarHeight) style:UITableViewStylePlain];
    _tableView.delegate=  self;
    _tableView.dataSource = self;
    _tableView.separatorInset =  UIEdgeInsetsMake(0, SCREENWIDTH, 0, 0);
    _tableView.backgroundColor =[UIColor whiteColor];
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableView.mj_header  = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        [self makedata];
    }];
    _tableView.mj_footer =[MJRefreshBackFooter footerWithRefreshingBlock:^{
        page ++;
        [self makedata];
    }];
    [self.view addSubview:_tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArrray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LawMessageCenterCell  * cell  =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell  =[[[NSBundle mainBundle ]loadNibNamed:@"LawMessageCenterCell" owner:self options:nil]lastObject];
    }
    cell.model = dataArrray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell ;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    LawNewMessageMM * modle =  dataArrray[indexPath.row];
//    if ([modle.status isEqualToString:@"3"]) {
        return 112;
//     }else{
//         return 80;
//
//    }
 
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LawNewMessageMM * modle =  dataArrray[indexPath.row];
    modle.status =@"1";
    [dataArrray replaceObjectAtIndex:indexPath.row withObject:modle];
   if ([modle.type isEqualToString:@"1"]) {
       LawMeetingViewController * adsListVc = [[LawMeetingViewController alloc]init];
            adsListVc.meetTing =@"电话预约";
        adsListVc.tid =modle.tid;
        adsListVc.mid =modle.id;
         [self.navigationController pushViewController:adsListVc animated:YES];
   }else if ([modle.type isEqualToString:@"2"]) {
       LawMeetingViewController * adsListVc = [[LawMeetingViewController alloc]init];
        adsListVc.meetTing =@"见面预约";
       adsListVc.mid =modle.id;
       adsListVc.tid =modle.tid;
 
       [self.navigationController pushViewController:adsListVc animated:YES];

   }
   else if ([modle.type isEqualToString:@"3"]) {
       LawConsultDetailViewController * detail =[[LawConsultDetailViewController alloc]init];
       detail.constultId = modle.tid;
         detail.mid =modle.id;
         detail.type = @"2";
       [self.navigationController pushViewController:detail animated:YES];
   }
   else if ([modle.type isEqualToString:@"4"]) {
      
   } else if ([modle.type isEqualToString:@"5"]) {
       LawHeartViewController * lawrevc =  [[LawHeartViewController alloc]init];
       lawrevc.mid = modle.id;
       [self.navigationController pushViewController:lawrevc animated:YES];
    }else if ([modle.type isEqualToString:@"6"]) {
       LawPersonInfoViewController * lawrevc =  [[LawPersonInfoViewController alloc]init];
        lawrevc.mid = modle.id;
       [self.navigationController pushViewController:lawrevc animated:YES];
    }else if ([modle.type isEqualToString:@"7"]) {
//        系统
   }
    
 
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];

    
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

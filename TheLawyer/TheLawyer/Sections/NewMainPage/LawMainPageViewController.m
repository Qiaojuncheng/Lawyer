//
//  LawMainPageViewController.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/15.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawMainPageViewController.h"
#import "LawMainTopView.h"
#import "LawMainConsultCell.h"
#import "LawMainMessageCell.h"
#import "LawAnnouncementViewController.h"
#import "LawMianPageMessageCenter.h"
#import "LawConSultViewController.h"
#import "LawMeetingViewController.h"
#import "LawConsultDetailViewController.h"
#import "LawSquarSrviceViewController.h"
#import "LawMainConsultCellMoldel.h"
#import "LawNewMessageMM.h"
#import "LawHeartViewController.h"
#import "LawPersonInfoViewController.h"
#import "LawNewHeaterModel.h"
@interface LawMainPageViewController ()<UITableViewDataSource,UITableViewDelegate>{
    
    NSMutableArray * dataArrray ;
    UITableView * _tableView;
//     右上角的红点
    UIView * tipView;
    
    NSInteger  page ;
    
    NSMutableArray *messageDataArray ;// 消息数据
    NSMutableArray *HearDataArray ;// 心意数据

    
  
}
@property (strong , nonatomic) LawMainTopView * topHeaderView;
@end

@implementation LawMainPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dataArrray =[[NSMutableArray alloc]init];
    messageDataArray =[[NSMutableArray alloc]init];
    HearDataArray =[[NSMutableArray alloc]init];
    [self addView];
    page = 1;
     [self addCenterLabelWithTitle:@"汇融法" titleColor:nil];
    [self addLeftButtonWithImage:@"nav_phone" preTitle:@"客服"];
    [self addRightButtonWithImage:@"nav_news"];
    [self getData];//资讯列表数据
    [self makemessagedata];// 消息数据
    [self heatData];//收到的心意
    // Do any additional setup after loading the view.
}
 -(void)getData{
   
    [self showHudInView:self.view hint:nil];
    NSMutableDictionary * dic =[[NSMutableDictionary alloc]init];
    NewConsult
     
     NSMutableDictionary * valueDic =[[NSMutableDictionary alloc]init];
     [valueDic setValue:@"1" forKey:@"type"];
     [valueDic setValue:UserId forKey:@"lawyer_id"];
     [valueDic setValue:[NSString stringWithFormat:@"%ld",page] forKey:@"p"];
     NSString * baseStr = [NSString getBase64StringWithArray:valueDic];
     [dic setValue:baseStr forKey:@"value"];

     [HttpAfManager postWithUrlString:BASE_URL parameters:dic success:^(id data) {
        NSLog(@"%@",data);

        NSString * status = [NSString stringWithFormat:@"%@",data[@"status"]];
        if([status isEqualToString:@"0"]){
            if (page == 1) {
                [dataArrray removeAllObjects];
            }
            for (NSDictionary * dics in data[@"data"]) {
            LawMainConsultCellMoldel * model =  [LawMainConsultCellMoldel yy_modelWithDictionary:dics];
            [dataArrray addObject:model];
                
            }

            [_tableView reloadData];
                
        }
        [self hideHud];
         [_tableView.mj_header endRefreshing];
         [_tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        [self hideHud];
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
    }];
}
-(void)addView{
   
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, NavStatusBarHeight, SCREENWIDTH, SCREENHEIGHT - NavStatusBarHeight - TabBarHeight) style:UITableViewStylePlain];
    _tableView.tableHeaderView = self.topHeaderView;
    _tableView.delegate=  self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableView.mj_footer = [MJRefreshBackNormalFooter  footerWithRefreshingBlock:^{
        page++ ;
        [self getData ];
    }];
    _tableView.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page =1 ;
        [self getData ];
    }];
    
    [self.view addSubview:_tableView];
}
-(LawMainTopView *)topHeaderView{
    if (!_topHeaderView) {
        _topHeaderView = [[[NSBundle mainBundle]loadNibNamed:@"LawMainTopView" owner:self options:nil] lastObject];
    }
    MJWeakSelf;
#pragma mark    41 咨询  电话预约  见面预约  法律服务
    _topHeaderView.ItemselectBlock = ^(NSInteger index) {
        if(index == 41){
            
            LawConSultViewController * adsListVc = [[LawConSultViewController alloc]init];
            [weakSelf.navigationController pushViewController:adsListVc animated:YES];
        }else if (index == 42 || index == 43){
            LawMeetingViewController * adsListVc = [[LawMeetingViewController alloc]init];
            if (index ==42) {
                adsListVc.meetTing =@"电话预约";
            }else{
                adsListVc.meetTing =@"见面预约";
            }
            [weakSelf.navigationController pushViewController:adsListVc animated:YES];
            
        }else if (index == 44){
      
            
            LawSquarSrviceViewController * adsListVc = [[LawSquarSrviceViewController alloc]init];
            adsListVc.ServiceTitle = @"法律服务";
            [weakSelf.navigationController pushViewController:adsListVc animated:YES];
        }
        
    };
//    心意
    _topHeaderView.adsselectBlock = ^(NSInteger index) {
//        LawNewHeaterModel * heatmole = HearDataArray[index];
//        LawHeartViewController * lawrevc =  [[LawHeartViewController alloc]init];
//        lawrevc.mid = heatmole.id;
//        [weakSelf.navigationController.navigationController pushViewController:lawrevc animated:YES];

//        LawAnnouncementViewController * adsListVc = [[LawAnnouncementViewController alloc]init];
//        [weakSelf.navigationController pushViewController:adsListVc animated:YES];
    };
    return  _topHeaderView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        if (messageDataArray.count > 2) {
            return 2 ;
        }else{
         return  messageDataArray.count;
        }
    }else{
        return  dataArrray.count;
        
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 52 ;
    }else {
        return 124 ;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return  70;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
    if(indexPath.section == 0){
        LawNewMessageMM * modle =  messageDataArray [indexPath.row];
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

    }else{
    LawConsultDetailViewController * detail =[[LawConsultDetailViewController alloc]init];
   
    LawMainConsultCellMoldel *model = dataArrray[indexPath.row];
    model.is_read =@"0";
    [dataArrray replaceObjectAtIndex:indexPath.row withObject:model];
//    detail.model =  model;
    detail.constultId = model.id;

//    detail.reloadBlock = ^{
//        [_tableView.mj_header beginRefreshing];
//    };
    detail.type = @"1";
        [self.navigationController pushViewController:detail animated:YES];
        
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];

        
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * headerView  =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 60)] ;
    UIView * lineView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 10)];
    lineView.backgroundColor =[UIColor colorWithHex:0xf7f7f7];
    [headerView addSubview:lineView];
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(16.5,10,200,60);
    if (section == 0) {
        label.text = @"消息通知";

    }else{
        label.text = @"咨询列表";
    }
    label.textColor = DEEPTintColor;
    [headerView addSubview:label];
    return  headerView;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section ==  0) {
        LawNewMessageMM * model  = messageDataArray[indexPath.row];

        LawMainMessageCell  *cell  =[tableView dequeueReusableCellWithIdentifier:@"messcell"];
        if (cell == nil) {
            cell  =[[[NSBundle mainBundle ]loadNibNamed:@"LawMainMessageCell" owner:self options:nil]lastObject];
        }
        
        if([model.type isEqualToString:@"1"]){
            cell.MeeageImage.image =[UIImage imageNamed:@"news_telephone"];
        }else if([model.type isEqualToString:@"2"]){
            cell.MeeageImage.image =[UIImage imageNamed:@"news_examination"];
        }else if([model.type isEqualToString:@"3"]){
            cell.MeeageImage.image =[UIImage imageNamed:@"news_consult"];
        }else if([model.type isEqualToString:@"4"]){
            cell.MeeageImage.image =[UIImage imageNamed:@"news_write"];
        }else if([model.type isEqualToString:@"5"]){
            cell.MeeageImage.image =[UIImage imageNamed:@"news_heart"];
        }else if([model.type isEqualToString:@"6"]){
            cell.MeeageImage.image =[UIImage imageNamed:@"news_authentication"];
        }else if([model.type isEqualToString:@"7"]){
            cell.MeeageImage.image =[UIImage imageNamed:@"news_system"];
        }

        if ([model.status isEqualToString:@"0"]) {
            cell.RedView.hidden = NO;
        }else{
            cell.RedView.hidden = YES;
        }
        
        cell.MessageLb.text = model.title;
        cell.TimeLB.text =[NSString timeWithTimeIntervalString:model.time];
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell;
    }else{
        
        LawMainConsultCell  *cell  =[tableView dequeueReusableCellWithIdentifier:@"consultcell"];
        if (cell == nil) {
            cell  =[[[NSBundle mainBundle ]loadNibNamed:@"LawMainConsultCell" owner:self options:nil]lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model=  dataArrray[indexPath.row];
        return  cell;
    }
 
    
 
}
- (void)addLeftButtonWithImage:(NSString *)image preTitle:(NSString *)preTitle
{
    UIButton *LeftBtn = [UIButton buttonWithType:0];
    LeftBtn.backgroundColor = [UIColor clearColor];
    [LeftBtn setNormalImage:image];
    [LeftBtn setPressedImage:image];
    [LeftBtn setTitle:preTitle forState:UIControlStateNormal];
    [LeftBtn setTitleColor:TintColor];
    [LeftBtn addClickTarget:self action:@selector(leftBar_Action:)];
     [self.naviBarView addSubview:LeftBtn];
    LeftBtn.sd_layout
    .leftSpaceToView(self.naviBarView,5)
    .topSpaceToView(self.naviBarView,StatusBarHeight)
    .widthIs(70)
    .heightIs(44);
}
- (void)addRightButtonWithImage:(NSString *)image  {
   
    UIButton *rightButton = [UIButton buttonWithType:0];
    rightButton.backgroundColor = [UIColor clearColor];
    [rightButton setNormalImage:image];
    [rightButton setPressedImage:image];
    [rightButton addClickTarget:self action:@selector(rightBar_Action:)];
     [self.naviBarView addSubview:rightButton];
     rightButton.sd_layout
    .rightSpaceToView(self.naviBarView,5)
    .topSpaceToView(self.naviBarView,StatusBarHeight)
    .widthIs(44)
    .heightIs(44);
    
    tipView = [[UIView alloc] initWithFrame:CGRectMake(0, rightButton.width - 8, 8, 8)];
    [Utile makeCorner:tipView.height/2 view:tipView];
    [rightButton addSubview:tipView];

}
#pragma mark 客服
-(void)leftBar_Action:(UIButton *)sender{
 
        UIAlertController * AlertVC =[UIAlertController alertControllerWithTitle:@"联系客服" message:[NSString stringWithFormat:@"\n%@\n(工作时间9:00_17:00)\n",APPPhone] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * cancal =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }] ;
        [cancal setValue:[UIColor colorWithHex:0x999999] forKey:@"_titleTextColor"];
        UIAlertAction * sure  =[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",APPPhone];
            UIWebView * callWebview = [[UIWebView alloc] init];
            [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
            [self.view addSubview:callWebview];
            
            
        }];
        [AlertVC addAction:cancal];
        [AlertVC addAction:sure];
        [self presentViewController:AlertVC animated:YES completion:nil];
    }
#pragma mark 通知
-(void)rightBar_Action:(UIButton * )sender{
    
    NSLog(@"通知");
    LawMianPageMessageCenter* messagecent = [[LawMianPageMessageCenter alloc]init];
    [self.navigationController pushViewController:messagecent animated:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 50;
    if(scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0,0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

#pragma  mark  消息数据
-(void)makemessagedata{
    
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    NewMymessageList
    if( [UserId length] < 1){
        return ;
    }
    NSDictionary * valudic  = @{@"lawyer_id":UserId,@"p":[NSString stringWithFormat:@"%ld",page]};
    NSString * baseStr = [NSString getBase64StringWithArray:valudic];
    [dic setValue:baseStr forKey:@"value"];
 
    [HttpAfManager postWithUrlString:BASE_URL parameters:dic success:^(id data) {
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            [messageDataArray removeAllObjects];
            for (NSDictionary * dicc in data[@"data"]) {
                LawNewMessageMM * model = [LawNewMessageMM yy_modelWithJSON:dicc];
                [messageDataArray addObject:model];
            }

            [_tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
        }
      } failure:^(NSError *error) {
        
        
    }];
    
}
#pragma mark 收到的心意

-(void)heatData{
         NSDictionary * dic  =[[NSMutableDictionary alloc]init];
        NewHetermind
        if( [UserId length] < 1){
            return ;
        }
    NSDictionary * valudic =[[NSDictionary alloc]init] ;
   
        NSString * baseStr = [NSString getBase64StringWithArray:valudic];
        [dic setValue:baseStr forKey:@"value"];
        
         [HttpAfManager postWithUrlString:BASE_URL parameters:dic success:^(id data) {
            NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
            
            if ([str isEqualToString:@"0"]) {
                for (NSDictionary * dicc in data[@"data"]) {
                    LawNewHeaterModel * model = [LawNewHeaterModel yy_modelWithJSON:dicc];
                    [HearDataArray addObject:model];
                }
            
            [_topHeaderView makeDataWithScrollLBArray:HearDataArray];

            }
           
        } failure:^(NSError *error) {
          
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

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
@interface LawMainPageViewController ()<UITableViewDataSource,UITableViewDelegate>{
    
    NSMutableArray * dataArrray ;
    UITableView * _tableView;
//     右上角的红点
    UIView * tipView;
    
}
@property (strong , nonatomic) LawMainTopView * topHeaderView;
@end

@implementation LawMainPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addView];

     [self addCenterLabelWithTitle:@"汇融法" titleColor:nil];
    [self addLeftButtonWithImage:@"nav_phone" preTitle:@"客服"];
    [self addRightButtonWithImage:@"nav_news"];
    [self getData];

    // Do any additional setup after loading the view.
}
 -(void)getData{
     dataArrray =[[NSMutableArray alloc]init];
   
    [self showHudInView:self.view hint:nil];
    NSMutableDictionary * dic =[[NSMutableDictionary alloc]init];
    NewConsult
     [dic setValue:@"" forKey:@"value"];
    [HttpAfManager postWithUrlString:BASE_URL parameters:dic success:^(id data) {
        NSLog(@"%@",data);

        NSString * status = [NSString stringWithFormat:@"%@",data[@"status"]];
        if([status isEqualToString:@"0"]){
    
            for (NSDictionary * dics in data[@"data"]) {
            LawMainConsultCellMoldel * model =  [LawMainConsultCellMoldel yy_modelWithDictionary:dics];
            [dataArrray addObject:model];
                
            }

            [_tableView reloadData];
                
        }
        [self hideHud];
    } failure:^(NSError *error) {
        [self hideHud];

    }];
}
-(void)addView{
   
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, NavStatusBarHeight, SCREENWIDTH, SCREENHEIGHT - NavStatusBarHeight - TabBarHeight) style:UITableViewStylePlain];
    _tableView.tableHeaderView = self.topHeaderView;
    _tableView.delegate=  self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:_tableView];
}
-(LawMainTopView *)topHeaderView{
    if (!_topHeaderView) {
        _topHeaderView = [[[NSBundle mainBundle]loadNibNamed:@"LawMainTopView" owner:self options:nil] lastObject];
    }
    [_topHeaderView makeDataWithScrollLBArray:@[@""]];
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
    _topHeaderView.adsselectBlock = ^(NSInteger index) {
        LawAnnouncementViewController * adsListVc = [[LawAnnouncementViewController alloc]init];
        [weakSelf.navigationController pushViewController:adsListVc animated:YES];
    };
    return  _topHeaderView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return 2 ;
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
    LawConsultDetailViewController * detail =[[LawConsultDetailViewController alloc]init];
    detail.model = dataArrray[indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
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
        LawMainMessageCell  *cell  =[tableView dequeueReusableCellWithIdentifier:@"messcell"];
        if (cell == nil) {
            cell  =[[[NSBundle mainBundle ]loadNibNamed:@"LawMainMessageCell" owner:self options:nil]lastObject];
        }
        if(indexPath.row == 0){
            cell.messageImage.image = [UIImage imageNamed:@"news_order"];
            cell.MessageLb.text = @"你有一个新的订单";
        }else{
            cell.messageImage.image = [UIImage imageNamed:@"news_telephone"];
            cell.MessageLb.text = @"你收到一条新的电话预约";

            
        }
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
 
        UIAlertController * AlertVC =[UIAlertController alertControllerWithTitle:@"联系客服" message:@"\n4006400661\n(工作时间9:00_17:00)\n" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * cancal =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }] ;
        [cancal setValue:[UIColor colorWithHex:0x999999] forKey:@"_titleTextColor"];
        UIAlertAction * sure  =[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"4006400661"];
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

//
//  LawHeartViewController.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/20.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawHeartViewController.h"
#import "LawheartCell.h"
#import "LawNewHeaterModel.h"
@interface LawHeartViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * dataArrray ;
    UITableView * _tableView;
    NSInteger Page;
}

@end

@implementation LawHeartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Page = 1;
    dataArrray = [[NSMutableArray alloc]init];
    [self addCenterLabelWithTitle:@"收到的心意" titleColor:nil];
    [self addView];
    [self makeData];
    // Do any additional setup after loading the view from its nib.
}
-(void)makeData{
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    NewHetermind
    if( [UserId length] < 1){
        return ;
    }
    NSDictionary * valudic ;
    if(self.mid){
        valudic = @{@"lawyer_id":UserId,@"p":[NSString stringWithFormat:@"%ld",Page],@"mid":self.mid};
    }else{
         valudic = @{@"lawyer_id":UserId,@"p":[NSString stringWithFormat:@"%ld",Page]};
    }
 
    NSString * baseStr = [NSString getBase64StringWithArray:valudic];
    [dic setValue:baseStr forKey:@"value"];
    

    if(Page==1){
        [self showHudInView:self.view hint:nil];
        
    }
    
    [HttpAfManager postWithUrlString:BASE_URL parameters:dic success:^(id data) {
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            if (Page == 1) {
                [dataArrray removeAllObjects];
            }
            for (NSDictionary * dicc in data[@"data"]) {
                LawNewHeaterModel * model = [LawNewHeaterModel yy_modelWithJSON:dicc];
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
    
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0,  NavStatusBarHeight , SCREENWIDTH, SCREENHEIGHT  -  NavStatusBarHeight ) style:UITableViewStylePlain];
    _tableView.delegate=  self;
    _tableView.dataSource = self;
//    _tableView.separatorInset = UIEdgeInsetsMake(0,SCREENWIDTH, 0, 0);
    _tableView.backgroundColor =[UIColor whiteColor];
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        Page =1;
        [self makeData];
    }];
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight= 0;
    _tableView.estimatedSectionFooterHeight= 0;
    
    
    _tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        Page ++;
        [self makeData];

    }];
    _tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:_tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArrray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LawheartCell  * cell  =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell  =[[[NSBundle mainBundle ]loadNibNamed:@"LawheartCell" owner:self options:nil]lastObject];
    }
    cell.model = dataArrray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell ;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    LawCaseAppreciateDetail * detail =[[LawCaseAppreciateDetail alloc]init];
//    [self.navigationController pushViewController:detail animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 105;
    
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

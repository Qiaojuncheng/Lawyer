//
//  LawCollectViewController.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/21.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawCollectViewController.h"
#import "LawCaseCell.h"
#import "LawCaseAppreciateDetail.h"


@interface LawCollectViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray * dataArrray ;
    UITableView * _tableView;
    NSInteger page ;
}

@end

@implementation LawCollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    page = 1;
    dataArrray =[[NSMutableArray alloc]init];
    self.view.backgroundColor  =   BackViewColor;
   
    [self addCenterLabelWithTitle:@"我的收藏" titleColor:nil];
    [self addView];
    [self makeCollect];
    // Do any additional setup after loading the view.
}
-(void)makeCollect{
    
    if(page==1){
        [self showHudInView:self.view hint:nil];
        
    }
    NSMutableDictionary * dic =[[NSMutableDictionary alloc]init];
    NewCasemyCollect
    NSMutableDictionary * valuedic =[[NSMutableDictionary alloc]init];
    if ([UserId length]> 0) {
        [valuedic setValue:UserId forKey:@"lawyer_id"];
        
        [valuedic setValue:[NSString stringWithFormat:@"%ld",page] forKey:@"p"];
        
        NSString * base64String =[NSString getBase64StringWithArray:valuedic];
        [dic setValue:base64String forKey:@"value"];
        
        [AFManagerHelp POST:BASE_URL parameters:dic success:^(id responseObjeck) {
            [self hideHud];
            // 处理数据
            if ([responseObjeck[@"status"] integerValue] == 0) {
                if (page == 1) {
                    [dataArrray removeAllObjects];
                }
                for (NSDictionary  * dicc in responseObjeck[@"data"]) {
                    
                    LawCaseNewModel * model = [LawCaseNewModel yy_modelWithJSON:dicc];
                    [dataArrray addObject:model];
                    
                }
                 [_tableView reloadData];
             }
            [_tableView.mj_header endRefreshing];
            [_tableView.mj_footer endRefreshing];

        } failure:^(NSError *error) {
            [self hideHud];
            [_tableView.mj_header endRefreshing];
            [_tableView.mj_footer endRefreshing];
        }];
        
    }
    
}

-(void)addView{
    
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0,  NavStatusBarHeight  + 10 , SCREENWIDTH, SCREENHEIGHT  -  NavStatusBarHeight  - 10) style:UITableViewStylePlain];
    _tableView.delegate=  self;
    _tableView.dataSource = self;
    _tableView.separatorInset = UIEdgeInsetsMake(0,SCREENWIDTH, 0, 0);
    _tableView.backgroundColor =[UIColor whiteColor];
    _tableView.tableFooterView = [[UIView alloc]init];
    __weak typeof(self) weakSelf = self;
    _tableView.mj_header  = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        
        [weakSelf makeCollect];
    }];
    
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight= 0;
    _tableView.estimatedSectionFooterHeight= 0;
    
    

    _tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        page ++;
         [weakSelf makeCollect];
    }];
    [self.view addSubview:_tableView];
}
 -(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArrray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LawCaseCell  * cell  =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell  =[[[NSBundle mainBundle ]loadNibNamed:@"LawCaseCell" owner:self options:nil]lastObject];
    }
    cell.model = dataArrray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell ;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LawCaseNewModel *  model = dataArrray[indexPath.row];
    LawCaseAppreciateDetail * detail =[[LawCaseAppreciateDetail alloc]init];
    detail.model = model;

    detail.ChangCollectStatus = ^(NSString *iscollect) {
        model.is_collect = iscollect;
        [dataArrray replaceObjectAtIndex:indexPath.row withObject:model];
        [_tableView reloadData];
    };
    [self.navigationController pushViewController:detail animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
    
}
- (NSString *)xy_noDataViewMessage {
    return @"暂无收藏";
}

- (UIImage  *)xy_noDataViewImage{
    return  [UIImage imageNamed:@"tips_nocollect"];
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

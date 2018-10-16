//
//  LawCaseAppreciateViewController.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/18.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawCaseAppreciateViewController.h"
#import "LawCaseCell.h"
#import "LawCaseAppreciateDetail.h"
#import "LawAppreSelectCaseTypeView.h"
#import "LawConsultTypeModel.h"
#import "LawCaseNewModel.h"
@interface LawCaseAppreciateViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * dataArrray ;
    UITableView * _tableView;
    NSMutableArray * CaseTypeArray ;
    NSInteger page ;
    NSString * Cate_id;
}
@property (strong, nonatomic) LawAppreSelectCaseTypeView * caseSelectView;

@end

@implementation LawCaseAppreciateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dataArrray = [[NSMutableArray alloc]init];

    page = 1;
    Cate_id = @"";
    [self addCenterLabelWithTitle:@"案件赏析" titleColor:nil];
    MJWeakSelf
    [self addRightButtonWithTitle:@"案件筛选" titleColor:[UIColor colorWithHex:0xBAC2CE] actionBlock:^{
        [weakSelf showCaseTypeView];
    }];
    [self addView];
    [self makeData];
    [self makeTypeData];
    [self.view addSubview:self.caseSelectView];
    // Do any additional setup after loading the view.
}
-(void)addView{
    
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0,  NavStatusBarHeight , SCREENWIDTH, SCREENHEIGHT  -  NavStatusBarHeight - TabBarHeight) style:UITableViewStylePlain];
    _tableView.delegate=  self;
    _tableView.dataSource = self;
    _tableView.separatorInset = UIEdgeInsetsMake(0,SCREENWIDTH, 0, 0);
    _tableView.backgroundColor =[UIColor whiteColor];
    _tableView.mj_header  =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        [self makeData];
    }];
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight= 0;
    _tableView.estimatedSectionFooterHeight= 0;
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableView.mj_footer  = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        page ++;
        [self makeData];
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
-(LawAppreSelectCaseTypeView *)caseSelectView{
    if (!_caseSelectView) {
        _caseSelectView = [[LawAppreSelectCaseTypeView alloc]initWithFrame:_tableView.frame];;
        _caseSelectView.hidden = YES;
        _caseSelectView.TableViewHeight = _tableView.height - 250;
    }
    return _caseSelectView;
}

 -(void)showCaseTypeView{
     MJWeakSelf ;
    _caseSelectView.DataArray = [[NSMutableArray alloc]initWithArray:CaseTypeArray];
     _caseSelectView.seleAreaBlock = ^(LawConsultTypeModel *selectModel) {
         Cate_id = selectModel.id;
         page = 1;
         [weakSelf  makeData];
     };
    _caseSelectView.hidden = NO ;
     
 }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)makeData{
    if(page==1){
        [self showHudInView:self.view hint:nil];
        
    }    NSMutableDictionary * dic =[[NSMutableDictionary alloc]init];
    NewCaseNews
    NSMutableDictionary * valuedic =[[NSMutableDictionary alloc]init];
    if ([UserId length]> 0) {
        [valuedic setValue:UserId forKey:@"id"];
        [valuedic setValue:@"1" forKey:@"type"];

    }
    [valuedic setValue:[NSString stringWithFormat:@"%ld",page] forKey:@"p"];
    if (Cate_id.length > 0) {
        [valuedic setValue:Cate_id forKey:@"cate_id"];
   
    }
     NSString * base64String =[NSString getBase64StringWithArray:valuedic];
      [dic setValue:base64String forKey:@"value"];
    //    获取分类
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
          
        }else{
 
        }
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        [self hideHud];

        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
    }];
    
}
-(void)makeTypeData{
    CaseTypeArray  =[[NSMutableArray alloc]init];
    NSMutableDictionary * dic =[[NSMutableDictionary alloc]init];
    NewConsultGetType
    //    获取分类
    [AFManagerHelp POST:BASE_URL parameters:dic success:^(id responseObjeck) {
        // 处理数据
        if ([responseObjeck[@"status"] integerValue] == 0) {
            for (NSDictionary * proDic in responseObjeck[@"data"]) {
                
                LawConsultTypeModel * TypeModel =[LawConsultTypeModel yy_modelWithJSON:proDic];
                [CaseTypeArray addObject:TypeModel];

            }
//            if (leftDataArray.count > 0) {
//                LawConsultTypeModel  * TypeModel = leftDataArray[0];
//                rightDataArray = TypeModel.second_child;
//            }
//
        }else{
            
        }
    } failure:^(NSError *error) {
    }];
    
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

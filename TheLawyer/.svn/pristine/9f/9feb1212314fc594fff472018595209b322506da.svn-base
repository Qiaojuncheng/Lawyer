//
//  QJFAQViewController.m
//  Lawyer
//
//  Created by MYMAc on 2017/4/14.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJFAQViewController.h"
#import "QJCJQuestionSubModel.h"
#import "QJCJQuestionModel.h"
#import "QJInfoDetailVC.h"

@interface QJFAQViewController ()

@end

@implementation QJFAQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     AccountArray =[[NSMutableArray alloc]init];
    [self addCenterLabelWithTitle:@"常见问题" titleColor:[UIColor whiteColor]];
    //[self makeBackItem];
    [self makeUI];

    [self  makeData];
    // Do any additional setup after loading the view.
}
-(void)makeData{

    
    AccountArray  =[[NSMutableArray alloc]init];
    
    
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    QJCQUESTION
//    NSDictionary * valueDic  = @{@"uid":UserId,@"type":[NSString stringWithFormat:@"2"]};
//    NSString * baseStr = [NSString getBase64StringWithArray:valueDic];
//    [dic setValue:baseStr forKey:@"value"];
    
    [HttpAfManager postWithUrlString:BASE_URL parameters:dic success:^(id data) {
        NSLog(@"%@",data);
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            for (NSDictionary * dic in data[@"data"]) {
                QJCJQuestionModel *model =[QJCJQuestionModel makeModelWithDic:dic];
                [AccountArray addObject:model];
            }
            [_tv reloadData];
        }else{
            NSString * msg = [NSString stringWithFormat:@"%@",data[@"msg"]];
            [self showHint:msg];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    


}
-(void)makeUI{

//    AccountArray =[[NSArray alloc]initWithObjects:@"1、账户注册只能手机注册么？",@"2、如何修改账户名和头像？",@"3、密码丢失如何找回", nil];
//    UseingArray =[[NSArray alloc] initWithObjects:@"1、咨询方式有哪些？",@"2、咨询以后还要找律师怎么办？",@"3、服务中会产生那些收费？", nil];
//    userJiFen = [[NSArray alloc]initWithObjects:@"1、这里的律师可靠不？",@"2、如果对结果存在质疑该怎么办？",@"3、律师故意拖延时间该怎么办？", nil];
  
    _tv =[[UITableView alloc]initWithFrame:CGRectMake(0, NavStatusBarHeight, ConentViewWidth , ConentViewHeight  ) style:UITableViewStyleGrouped];
    _tv.delegate = self;
    _tv.dataSource = self;
    _tv.estimatedRowHeight = 0;
    _tv.estimatedSectionHeaderHeight = 0;
    _tv.estimatedSectionFooterHeight = 0;
    [self.view addSubview:_tv];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return AccountArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    QJCJQuestionModel *  modle = AccountArray[section];
    return modle.arcLists.count;

 }


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
 
    QJCJQuestionModel *  modle = AccountArray[indexPath.section];
    QJCJQuestionSubModel * submodel = modle.arcLists[indexPath.row];
     cell.textLabel.text = submodel.title;
    cell.selectionStyle= UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return  cell;
 
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
    
    QJCJQuestionModel *  modle = AccountArray[indexPath.section];
    QJCJQuestionSubModel * submodel = modle.arcLists[indexPath.row];

    
    QJInfoDetailVC * lvc= [[QJInfoDetailVC alloc]init];
    lvc.infoId =submodel.id;
    lvc.title  =  submodel.title;
    lvc.IsHiden = YES;
    lvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:lvc animated:YES];

}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    QJCJQuestionModel *  modle = AccountArray[section];

    
    UIView * headerVew =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, 30)];
     UILabel * titLabel =[[UILabel alloc]initWithFrame:CGRectMake(20, 0, ConentViewWidth, 30)];
    titLabel.textColor =MainBlueColor;
   
    titLabel.text = modle.cate_name;

    [headerVew addSubview:titLabel];
     return  headerVew;

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

//
//  MainDetailViewController.m
//  TheLawyer
//
//  Created by yaoyao on 17/7/30.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import "MainDetailViewController.h"
#import "MainDetailModel.h"
#import "MainDetailCell.h"
#import "GrabSucessViewController.h"
#import "QJCScanHeTong.h"

@interface MainDetailViewController ()<UITableViewDelegate, UITableViewDataSource,UIAlertViewDelegate>{
    NSFileManager *fileManager;

    
}

// TableView
@property (nonatomic, strong) UITableView *tableView;

// 数据源
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIImageView *headerImg;
//okBt
@property (nonatomic, strong) UIButton *okBt;

@end

@implementation MainDetailViewController

- (UIImageView *)headerImg {
    if (!_headerImg) {
        _headerImg = [UIImageView new];
        _headerImg.image = [UIImage imageNamed:@"tuceng"];
        _headerImg.frame = CGRectMake( SCREENWIDTH/2 - 40 , 10+NavStatusBarHeight, 80, 80);
        [Utile makeCorner:40 view:_headerImg];
    }
    return _headerImg;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.titleType) {
        [self addCenterLabelWithTitle:@"业务详情" titleColor:[UIColor whiteColor]];
    }
  fileManager = [NSFileManager defaultManager];
    
//    [self initData];
    [self.view addSubview:self.headerImg];
    [self.view addSubview:self.tableView];
    if (!self.HideQiangdan) {
        UIView * footView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 100)];
        [footView addSubview:self.okBt];
         self.tableView.tableFooterView = footView;
    }else{
        
        self.tableView.tableFooterView = [[UIView alloc]init];

    }
    [self ReshData];

}


//刷新数据
-(void)ReshData
{
    //App/Lawyer/law_xq
     //action、value
    NSDictionary *dic = @{
                          @"user_id":UserId,
                          @"law_id":self.typeId,
                           };
    
    NSError *dataError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:(NSJSONWritingOptions)0 error:&dataError];
    NSString *body = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    DLog(@"%@",body);
    NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [data base64EncodedStringWithOptions:0];
    DLog(@"%@",base64String);
    
    NSDictionary *parameter= @{
                               @"action":[NSString stringWithFormat:@"App/Lawyer/law_xq"],
                               @"value":base64String
                               };
    
    DLog(@"%@",parameter);
    WS(ws);
    [self showHudInView:self.view hint:nil];
    [AFManagerHelp POST:BASE_URL parameters:parameter success:^(id responseObjeck) {
        // 处理数据
        DLog(@"%@",responseObjeck);
         if ([responseObjeck[@"status"] integerValue] == 0) {
            _tableView.hidden = NO;
            ws.detailModel = [MainDetailModel yy_modelWithDictionary:responseObjeck[@"data"]];
            [self.headerImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_URL,ws.detailModel.avatar]] placeholderImage:[UIImage imageNamed:@"tuceng"]];
            if ([self.detailModel.type isEqualToString:@"5"]){
                _tableView.height =      SCREENHEIGHT - NavStatusBarHeight - 100;
            }else{
                _tableView.height =      SCREENHEIGHT - NavStatusBarHeight - 100;

            }

            [ws.tableView reloadData];
            [ws.tableView.mj_header endRefreshing];
            [ws.tableView.mj_footer resetNoMoreData];
            [ws.tableView.mj_footer endRefreshing];
        }else{
            [ShowHUD showWYBTextOnly:responseObjeck[@"msg"] duration:2 inView:ws.view];
        }
        [self hideHud];
    } failure:^(NSError *error) {
        [self hideHud];
         [ShowHUD showWYBTextOnly:@"你的网络好像不太给力\n请稍后再试" duration:2 inView:ws.view];
    }];
}

// 提交按钮
- (UIButton *)okBt {
    if (!_okBt) {
        _okBt = [UIButton buttonWithType:UIButtonTypeCustom];
        _okBt.layer.masksToBounds = YES;
        _okBt.layer.cornerRadius = 5;
        _okBt.backgroundColor = THEMECOLOR;
        [_okBt setNormalTitle:@"抢单"];
        _okBt.frame = CGRectMake(75, 100  -  70, SCREENWIDTH-150, 40);
        [_okBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_okBt addClickTarget:self action:@selector(okClick:)];
    }
    return _okBt;
}
// 抢单
- (void)okClick:(UIButton *)sender {
    
    UIAlertController * alVC =[UIAlertController alertControllerWithTitle:@"提示" message:@"确定要抢单吗？" preferredStyle:UIAlertControllerStyleAlert ];
    UIAlertAction * cancer =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction * SuerAction =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self makeSureQiaoDan];
    }];
    [alVC addAction:cancer];
    [alVC addAction:SuerAction];

    [self presentViewController:alVC animated:YES completion:nil];
    
    
    
}
#pragma mark -UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
    }else if (buttonIndex == 1){
        
    }else{
//        //
//        QangFinishViewController*qfVC = [[QangFinishViewController alloc] init];
//        qfVC.type = self.detailModel.type;
//        qfVC.lawid = self.detailModel.yewuId;
//        [self.navigationController pushViewController:qfVC animated:YES];
    }
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavStatusBarHeight+100, SCREENWIDTH, SCREENHEIGHT - NavStatusBarHeight - 100 ) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        
        // 注册
        [self.tableView registerClass:[MainDetailCell class] forCellReuseIdentifier:@"MainDetailCell"];
    }
    return _tableView;
}
// 数据源
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark -- UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.detailModel.type isEqualToString:@"5"]){
        return  12;
    }else{
         return 11;

    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 10 ) {
        return 90;
    } else {
            if ( indexPath.section == 0 && indexPath.row == 9 ) {
                if(![self.detailModel.type isEqualToString:@"3"]){
                    return 0.01;
                }
             }else{
                 return 40;
             }
        }
        return 40;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MainDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainDetailCell"];
  if (indexPath.row==0) {
        cell.titleLabel.text = [NSString stringWithFormat:@"姓名：%@",[NSString changeNullString:self.detailModel.name]];
    }else if (indexPath.row ==1){
        cell.titleLabel.text = [NSString stringWithFormat:@"地址：%@",[NSString changeNullString:self.detailModel.address]];
    }else if (indexPath.row==2) {
        cell.titleLabel.text = [NSString stringWithFormat:@"联系方式：%@",[NSString changeNullString:self.detailModel.phone]];
        
    }else if (indexPath.row ==3){
         cell.titleLabel.text = [NSString stringWithFormat:@"服务类型：%@",[NSString changeNullString:self.detailModel.typeName]];
    }else if (indexPath.row ==4){
        if([self.detailModel.status isEqualToString:@"3"]){
         cell.titleLabel.text = [NSString stringWithFormat:@"服务报价：￥%@",[NSString changeNullString:self.detailModel.price]];
        }else{
        cell.titleLabel.text = [NSString stringWithFormat:@"服务报价：￥%@",[NSString changeNullString:self.detailModel.offer]];
        }
            
    }else if (indexPath.row ==5){
        if([self.detailModel.status isEqualToString:@"3"]){
            cell.titleLabel.text = [NSString stringWithFormat:@"交付时间：%@",[NSString changeNullString:[NSString timeWithTimeIntervalString:self.detailModel.finish_time]]];
        }else{
            cell.titleLabel.text = [NSString stringWithFormat:@"交付时间：%@",[NSString changeNullString:[NSString timeWithTimeIntervalString:self.detailModel.time]]];
         }
    } else if (indexPath.row==6) {
        cell.titleLabel.text = [NSString stringWithFormat:@"发布时间：%@",[NSString changeNullString:[NSString timeWithTimeIntervalString:self.detailModel.create_time]]];
    }else if (indexPath.row ==7){
        if ([self.detailModel.party_information  isEqualToString:@"1"]) {
            cell.titleLabel.text = [NSString stringWithFormat:@"当事人信息：个人"];

        }else{
            cell.titleLabel.text = [NSString stringWithFormat:@"当事人信息：公司"];
         }
        
    }else if (indexPath.row ==8){
        cell.titleLabel.text = [NSString stringWithFormat:@"案件领域：%@",[NSString changeNullString:self.detailModel.cat_name]];
    }else if (indexPath.row ==9){
        if ([self.detailModel.type isEqualToString:@"3"]) {
            cell.titleLabel.text = [NSString stringWithFormat:@"邮箱地址：%@",[NSString changeNullString:self.detailModel.email]];
        }else{
            cell.titleLabel.text  = @"";
        }
    }
    else  if (indexPath.row ==10) {
        cell.subTitleLabel.hidden = NO;
        cell.titleLabel.text = [NSString stringWithFormat:@"客户问题："];
        cell.subTitleLabel.text = [NSString stringWithFormat:@"%@",[NSString changeNullString:self.detailModel.contract_description]];
    }
    else if (indexPath.row==11){
         cell.imageView.image = [UIImage imageNamed:@"下载"];
        NSString *path =[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString *directryPath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",UserId]];
        NSString *fullPath = [directryPath stringByAppendingPathComponent:[[self.detailModel.file componentsSeparatedByString:@"/"]lastObject]];

        if(![fileManager fileExistsAtPath:fullPath]){//如果不存在,则说明是第一次运行这个程序，那么建立这个文件夹
            cell.textLabel.text =@"合同下载";
            [cell whenTapped:^{
                [self downloadFild];
            }];

        }else{
            cell.textLabel.text =@"查看合同";
            [cell whenTapped:^{
                [self ScanHeTong];
            }];

        }
        cell.textLabel.textColor = THEMECOLOR;
    } else{
        cell.titleLabel.text = [NSString stringWithFormat:@"业务领域：%@",[NSString changeNullString:self.detailModel.cat_name]];
    }
//    cell.tempModel = self.detailModel;
    // 点击效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

#pragma mark -- cell点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 设置选中动画
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}
-(void)downloadFild{
     //创建传话管理者
     NSString * donwStr =[NSString stringWithFormat:@"%@%@",Image_URL,self.detailModel.file];
   
    
    NSURL* url = [NSURL URLWithString:donwStr];
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        

        //保存的文件路径
        NSString * FilePath  =[[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]  stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",UserId]];
        
        if(![fileManager fileExistsAtPath:FilePath]){//如果不存在,则说明是第一次运行这个程序，那么建立这个文件夹
            NSString *path =[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
            NSString *directryPath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",UserId]];
            [fileManager createDirectoryAtPath:directryPath withIntermediateDirectories:YES attributes:nil error:nil];
            
        }
        
        NSString *fullPath = [FilePath stringByAppendingPathComponent:response.suggestedFilename];
        [fileManager createFileAtPath:fullPath contents:data attributes:nil];
        [_tableView reloadData];
      }];
 }
-(void)ScanHeTong{
    QJCScanHeTong * hetong  =[[ QJCScanHeTong alloc]init];
    NSString *path =[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *directryPath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",UserId]];
    NSString *fullPath = [directryPath stringByAppendingPathComponent:[[self.detailModel.file componentsSeparatedByString:@"/"]lastObject]];

    hetong.fullPath = fullPath ;
    
    [self.navigationController pushViewController:hetong animated:YES];
    
    
}
-(void)makeSureQiaoDan{
    GrabSucessViewController * GrabVc =[[GrabSucessViewController alloc]initWithNibName:@"GrabSucessViewController" bundle:[NSBundle mainBundle]];
 
    GrabVc.type = self.detailModel.type;
    GrabVc.law_id = self.detailModel.information_id;
    
    [self.navigationController pushViewController:GrabVc animated:YES];
 
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

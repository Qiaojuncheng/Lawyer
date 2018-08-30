//
//  SetViewController.m
//  TheLawyer
//
//  Created by yaoyao on 17/7/27.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import "SetViewController.h"
#import "FeedbackViewController.h"

#import "XSetVCModel.h"
#import "XSetVCCell.h"
#import "FeedbackViewController.h"
#import "QJFAQViewController.h"
#import "QJNewMessageTX.h"
#import "QJInfoVC.h"

@interface SetViewController ()<UITableViewDelegate, UITableViewDataSource,UIAlertViewDelegate>{
    NSString * phoneString;
    
}
@property (nonatomic,strong)NSString *CashSizeS;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic,strong) UIButton *logoutButton;

@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addCenterLabelWithTitle:@"设置" titleColor:[UIColor whiteColor]];
    [self initData];
    [self makePhoneTel];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.logoutButton];
}

- (void)initData {
    
    XSetVCModel *model = [XSetVCModel new];
    model.XTitle = @"个人资料";
    model.XSubTitle = @"";
    [self.dataArray addObject:model];
    
    XSetVCModel *modelp = [XSetVCModel new];
    modelp.XTitle = @"常见问题";
    modelp.XSubTitle = @"";
    [self.dataArray addObject:modelp];
    
    XSetVCModel *modelTS = [XSetVCModel new];
    modelTS.XTitle = @"新消息提示";
    modelTS.XSubTitle = @"";
    [self.dataArray addObject:modelTS];
 
    // 清除缓存
    XSetVCModel *modelOne = [XSetVCModel new];
    modelOne.XTitle = @"清理缓存";
//    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
//
//    NSString *filePath = [documentPath stringByAppendingPathComponent:@"Resources"];
//    long long sizeOne;
//    sizeOne = [PublicMethod folderSizeAtPath:filePath];
//
//    long long sizeTwo = [[SDImageCache sharedImageCache] getSize];
//    DLog(@"%lld", sizeTwo);
//    NSString *size = [NSString stringWithFormat:@"当前缓存%.2f M", (sizeOne + sizeTwo) / 1024.0 / 1024.0];
//    modelOne.XSubTitle = size;
    modelOne.type = 1;
    [self.dataArray addObject:modelOne];
    //客服热线
    XSetVCModel *modelTwo = [XSetVCModel new];
    modelTwo.XTitle = @"客服热线";
    modelTwo.XSubTitle = @"";//modelTwo
    [self.dataArray addObject:modelTwo];
    

    

    
    // 意见反馈
    XSetVCModel *modelFour = [XSetVCModel new];
    modelFour.XTitle = @"意见反馈";
    modelFour.XSubTitle = @"";
    [self.dataArray addObject:modelFour];
    
    
    
    
}
// 数据源
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (UIButton *)logoutButton {
    if (!_logoutButton) {
        _logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _logoutButton.frame= CGRectMake(10, SCREENHEIGHT-100, SCREENWIDTH-20, 40);
        _logoutButton.backgroundColor = THEMECOLOR;
        [_logoutButton setNormalTitle:@"退出账号"];//titleLabel.text = @"退出账号";
        [_logoutButton setTitleColor:[UIColor whiteColor]];//titleLabel.textColor = [UIColor whiteColor];
        _logoutButton.layer.masksToBounds = YES;
        _logoutButton.layer.cornerRadius = 5;
         [_logoutButton addClickTarget:self action:@selector(logoutButtonClick)];
    }
    return _logoutButton;
}

// tableView
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavStatusBarHeight, SCREENWIDTH, 300) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

        [_tableView registerClass:[XSetVCCell class] forCellReuseIdentifier:@"XSetVCCell"];
    }
    return _tableView;
}

#pragma mark -- UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XSetVCModel *tempModel = self.dataArray[indexPath.row];
    XSetVCCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XSetVCCell"];
    cell.tempModel = tempModel;
    if (indexPath.row ==3) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *cachPath = [paths objectAtIndex:0];
        
        CGFloat fileSize = [self folderSizeAtPath:cachPath];
        cell.XSubTitleLabel.text = [NSString stringWithFormat:@"%.2fM",fileSize];
        
        self.CashSizeS =cell.XSubTitleLabel.text;

    }
    // 点击效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 点击效果
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row ==0) {
//        个人资料
        QJInfoVC *qVC = [[QJInfoVC alloc] init];
         [self.navigationController pushViewController:qVC animated:YES];
        
    }else if (indexPath.row ==1){
        //常见问题
         QJFAQViewController * qj =[[QJFAQViewController alloc]init];
        qj.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:qj animated:YES];

    }else if (indexPath.row ==2){
        //新消息提示
        QJNewMessageTX * qj =[[QJNewMessageTX alloc]init];
        qj.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:qj animated:YES];
    }else if (indexPath.row ==3){
        //清理缓存
        [self clearCashSelf];
        
    }else if (indexPath.row ==4){
        //客服热线
        [self makeAddAction];
        
        
    }else if (indexPath.row ==5){
        //意见反馈
        FeedbackViewController *feedBack = [[FeedbackViewController alloc] init];
        [self.navigationController pushViewController:feedBack animated:YES];
        
    }
}
#pragma mark 客服热线
- (void)makePhoneTel{
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
 [dic setValue:@"App/User/getConfig" forKey:@"action"];
     [HttpAfManager postWithUrlString:BASE_URL parameters:dic success:^(id data) {
        NSLog(@"客服热线%@",data);
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
         phoneString = [NSString stringWithFormat:@"%@",data[@"data"]];
            [[NSUserDefaults standardUserDefaults] setObject:phoneString forKey:@"KeFuPhone"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }else{
            NSString * msg = [NSString stringWithFormat:@"%@",data[@"msg"]];
            [self showHint:msg];
        }
     } failure:^(NSError *error) {
         [self showHint:@"登录失败，请稍后重试！"];
        NSLog(@"客服热线%@",error);
    }];
    
}


//退出登录
- (void)logoutButtonClick
{
//    ShowAlert(@"确定要退出登录吗？");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"确定要退出登录吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 8898;
    [alert show];



}
#pragma mark -UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
    }
    if (buttonIndex == 1 &&alertView.tag==8899) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *cachPath = [paths objectAtIndex:0];
        
        [self clearCache:cachPath];
        [self.tableView reloadData];

    }else if (buttonIndex == 1 &&alertView.tag==8898){
        DLog(@"退出");
        
        [UD removeObjectForKey:@"userid"];
        
        [self.navigationController popToRootViewControllerAnimated:NO];
    }else{
        //
    }
}


-(void)clearCashSelf{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachPath = [paths objectAtIndex:0];
    
    CGFloat fileSize = [self folderSizeAtPath:cachPath];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"清除缓存" message:[NSString stringWithFormat:@"清除%@",_CashSizeS]  delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];//[NSString stringWithFormat:@"清除%.2fM",fileSize]
    alert.tag = 8899;
    [alert show];
    
}
-(void)clearCache:(NSString *)path{
    
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
        [[SDImageCache sharedImageCache] cleanDisk];
}
-(float)folderSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    float folderSize;
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            folderSize +=[self fileSizeAtPath:absolutePath];
        }
        ////          SDWebImage框架自身计算缓存的实现
        //                folderSize+=[[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
        //                [self fileSizeAtPath:[UIImageView sharedImageCache]];
        return folderSize;
    }
    return 0;
}

-(float)fileSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]){
        long long size=[fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size/1024.0/1024.0;
    }
    return 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)makeAddAction{
    NSString *url = [NSString stringWithFormat:@"联系客服 %@\n周一至周五 9：00-17：00\n是否拨打客服？",phoneString];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:url preferredStyle:UIAlertControllerStyleAlert];
    
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        [self makePhone];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"点击了取消按钮");
    }]];
    
    
    [self presentViewController:alert animated:YES completion:nil];
}
#pragma mark 拨打电话
- (void)makePhone{
    
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",phoneString];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    });
    
    
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

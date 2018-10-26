//
//  LawNewSettingViewController.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/13.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawNewSettingViewController.h"
#import "XSetVCCell.h"
#import "QJFAQViewController.h"
#import "FeedbackViewController.h"
@interface LawNewSettingViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation LawNewSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =BackViewColor;
    [self addCenterLabelWithTitle:@"通用设置" titleColor:[UIColor blackColor]];
    self.dataArray =[[NSMutableArray alloc]init];
    [self.dataArray addObjectsFromArray:@[@"常见问题",@"意见反馈",@"退出登录"]];
    [self.view addSubview:self.tableView];

    // Do any additional setup after loading the view.
}
     // tableView
- (UITableView *)tableView {
         if (!_tableView) {
             _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavStatusBarHeight + 10, SCREENWIDTH, SCREENHEIGHT - NavStatusBarHeight - 10 ) style:UITableViewStylePlain];
             _tableView.delegate = self;
             _tableView.dataSource = self;
             _tableView.backgroundColor = [UIColor whiteColor];
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
    XSetVCCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XSetVCCell"];
    cell.XTitleLabel.text = self.dataArray[indexPath.row];
    
    // 点击效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 点击效果
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row ==0) {
        //常见问题
                QJFAQViewController * qj =[[QJFAQViewController alloc]init];
                qj.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:qj animated:YES];

 
    }else if (indexPath.row ==1){
        //意见反馈
        FeedbackViewController *feedBack = [[FeedbackViewController alloc] init];
        [self.navigationController pushViewController:feedBack animated:YES];
        
    }else if (indexPath.row ==2){
        [self logoutACtion];
    }    
    
}
//退出登录
- (void)logoutACtion
{
 
    
    UIAlertController * Alvc =[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"确定要退出登录吗？" preferredStyle:UIAlertControllerStyleAlert];
   
    UIAlertAction * cancel =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction * sure =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        [UD removeObjectForKey:@"userid"];
        [UD synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINSUCCESS object:nil];
        [self.navigationController popToRootViewControllerAnimated:NO];

    }];
    
    [Alvc addAction:cancel];
    [Alvc addAction:sure];
    [self presentViewController:Alvc animated:YES completion:nil];
    
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

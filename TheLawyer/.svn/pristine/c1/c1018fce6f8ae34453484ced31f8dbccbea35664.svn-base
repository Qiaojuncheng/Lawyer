//
//  GuideViewController.m
//  XuanMiLaywer
//
//  Created by MYMAc on 15/7/30.
//  Copyright (c) 2015年 zhiyou. All rights reserved.
//


#import "GuideViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
//#import "DTabbarViewController.h"

//获取屏幕宽高
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
@interface GuideViewController ()
{
    NSArray * imageArr;
    UIImageView *imageview;
    UIScrollView *scrollView;
}
@end

@implementation GuideViewController




- (void)viewDidLoad {
    [super viewDidLoad];
//    UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    img.image=[UIImage imageNamed:@"法律1.png"];
   
   imageArr = [[NSArray alloc]initWithObjects: @"111",@"222",@"333",nil];
    
    [self initView];
}
-(void)initView
{
   scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    scrollView.showsVerticalScrollIndicator=NO;
    scrollView.showsHorizontalScrollIndicator=NO;
    [scrollView setContentSize:CGSizeMake(SCREEN_WIDTH * imageArr.count, 0)];
    [scrollView setPagingEnabled:YES];  //视图整页显示
       [scrollView setBounces:NO]; //避免弹跳效果,避免把根视图露出来
    for (int i = 0; i < imageArr.count; i ++) {
        imageview = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        imageview.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",imageArr[i]]];
        imageview.userInteractionEnabled = YES;
        [scrollView addSubview:imageview];


}
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, SCREEN_HEIGHT  - 150, SCREEN_WIDTH, 100);
      [button addTarget:self action:@selector(firstpressed) forControlEvents:UIControlEventTouchUpInside];
//    [button setBackgroundColor:[UIColor redColor]];

     [imageview addSubview:button];
    
    
    [self.view addSubview:scrollView];
    
    
}
- (void)firstpressed
{
    
    NSUserDefaults *userdefa =[NSUserDefaults standardUserDefaults];
    [userdefa setBool:YES forKey:@"MMIsFirst"];
    [userdefa synchronize];
    AppDelegate * appdelegatee =(AppDelegate *)[UIApplication sharedApplication].delegate;
    LoginViewController *view = [LoginViewController new];
    UINavigationController * nav =[[UINavigationController alloc]initWithRootViewController:view];
    appdelegatee.window.rootViewController = nav;

    
    //点击button跳转到根视图
//    AppDelegate * appdelegatee = [UIApplication sharedApplication].delegate;
//    [self presentViewController:appdelegatee.tabBar animated:YES completion:^
//    {
//
//         appdelegatee.window.rootViewController =appdelegatee.tabBar;
//        
//    }];
    
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

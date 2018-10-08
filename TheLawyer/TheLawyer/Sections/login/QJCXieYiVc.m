//
//  QJCXieYiVc.m
//  TheLawyer
//
//  Created by MYMAc on 2017/11/9.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import "QJCXieYiVc.h"

@interface QJCXieYiVc ()

@end

@implementation QJCXieYiVc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCenterLabelWithTitle:@"协议" titleColor:[UIColor whiteColor]];
    [self makeUI];
    // Do any additional setup after loading the view.
}
-(void)makeUI{
    
    UIWebView * web =[[UIWebView alloc]initWithFrame:CGRectMake(0, NavStatusBarHeight, SCREENWIDTH, SCREENHEIGHT - NavStatusBarHeight)];
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.huirongfa.com/Wap/Index/lawyer_xieyi.html"]]];
    [web loadRequest:request];
    [self.view addSubview:web];
    
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

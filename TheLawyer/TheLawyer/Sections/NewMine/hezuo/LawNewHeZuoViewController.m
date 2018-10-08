//
//  LawNewHeZuoViewController.m
//  TheLawyer
//
//  Created by MYMAc on 2018/9/26.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawNewHeZuoViewController.h"
#import <WebKit/WebKit.h>

@interface LawNewHeZuoViewController ()<WKNavigationDelegate,WKUIDelegate>
@property (strong, nonatomic) WKWebView * webView;
@end

@implementation LawNewHeZuoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
[self addCenterLabelWithTitle:@"我要合作" titleColor:nil];
self.view.backgroundColor =[UIColor whiteColor];
self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, NavStatusBarHeight +10, SCREENWIDTH, SCREENHEIGHT - NavStatusBarHeight)];
[self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.huirongfa.com/Wap/Index/cooperation.html"]]]];
self.webView.navigationDelegate = self;
self.webView.UIDelegate = self;
//开了支持滑动返回
self.webView.allowsBackForwardNavigationGestures = YES;
[self.view addSubview:self.webView];

[self showHudInView:self.view hint:nil];
// Do any additional setup after loading the view.
}
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
    [self hideHud];
    
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    [self hideHud];
    [self showHint:@"页面加载失败，请重试！"];
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

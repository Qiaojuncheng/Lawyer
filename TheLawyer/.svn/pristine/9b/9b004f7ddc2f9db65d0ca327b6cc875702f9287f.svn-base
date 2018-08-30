//
//  QJInfoDetailVC.m
//  Lawyer
//
//  Created by MYMAc on 2017/9/22.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJInfoDetailVC.h"

@interface QJInfoDetailVC ()<UIWebViewDelegate>{

    UIWebView * webView;
}

@end

@implementation QJInfoDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addCenterLabelWithTitle:@"常见问题" titleColor:[UIColor whiteColor]];
    
    webView =[[UIWebView alloc]initWithFrame:CGRectMake(0, NavStatusBarHeight, ConentViewWidth, ConentViewHeight )];
    NSURL * urlStr =[NSURL URLWithString:[NSString stringWithFormat:@"%@%@/%@/type/app.html",Image_URL,INFODETAIL,self.infoId]];
    NSURLRequest * request =[[NSURLRequest alloc]initWithURL:urlStr];
    [webView loadRequest:request];
    [self.view addSubview:webView];
    
    // Do any additional setup after loading the view.
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

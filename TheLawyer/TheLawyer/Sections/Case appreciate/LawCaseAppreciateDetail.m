//
//  LawCaseAppreciateDetail.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/18.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawCaseAppreciateDetail.h"
#import <WebKit/WebKit.h>
@interface LawCaseAppreciateDetail ()<WKNavigationDelegate,WKUIDelegate>{
 
    
}
@property (strong, nonatomic) WKWebView * webView;

@end

@implementation LawCaseAppreciateDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    [self addCenterLabelWithTitle:self.titleStr titleColor:nil];
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, NavStatusBarHeight +10, SCREENWIDTH, SCREENHEIGHT - NavStatusBarHeight - 68- 10)];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    //开了支持滑动返回
    self.webView.allowsBackForwardNavigationGestures = YES;
    [self.view addSubview:self.webView];
   
    [self addBottomView];
    // Do any additional setup after loading the view.
}
-(void)addBottomView{
    
    UIButton * consultBtn =[[UIButton alloc]initWithFrame:CGRectMake(68, self.webView.bottom +1, SCREENWIDTH  - 68*2, 40)];
    [consultBtn setTitle:@"收藏" forState:UIControlStateNormal];
    [consultBtn setTitleColor:[UIColor colorWithHex:0x3181FE] forState:UIControlStateNormal];
    [consultBtn setBackgroundColor:[UIColor colorWithHex:0x3181FE]];
  
    consultBtn.selected = YES;
    
    [consultBtn setTitle:@"取消收藏" forState:UIControlStateSelected];
    [consultBtn setTitleColor:[UIColor colorWithHex:0xffffff] forState:UIControlStateSelected];

    consultBtn.adjustsImageWhenHighlighted = NO;
    [consultBtn addTarget:self action:@selector(CollectionAction:) forControlEvents:UIControlEventTouchUpInside];
    consultBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:consultBtn];
    [consultBtn createBordersWithColor:[UIColor colorWithHex:0x3181FE] withCornerRadius:20 andWidth:1];
 
    
}

-(void)CollectionAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        [sender setBackgroundColor:[UIColor colorWithHex:0x3181FE]];
    }else{
    [sender setBackgroundColor:[UIColor colorWithHex:0xffffff]];
    }
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

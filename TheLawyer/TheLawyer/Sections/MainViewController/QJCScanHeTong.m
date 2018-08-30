//
//  QJCScanHeTong.m
//  TheLawyer
//
//  Created by MYMAc on 2017/11/17.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import "QJCScanHeTong.h"

@interface QJCScanHeTong ()<UIWebViewDelegate>

@end

@implementation QJCScanHeTong

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCenterLabelWithTitle:@"查看合同" titleColor:[UIColor whiteColor]];
    [self loadData];
    // Do any additional setup after loading the view.
}
-(void)loadData{
NSURL *fileRUL = [NSURL fileURLWithPath:self.fullPath];

UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, NavStatusBarHeight, SCREENWIDTH, SCREENHEIGHT)];

webView.delegate = self;

webView.multipleTouchEnabled = YES;

webView.scalesPageToFit = YES;

webView.scrollView.bounces = YES;

//加载动画

//[self bsShowLoadingView];



[self.view addSubview:webView];

NSStringEncoding *useEncodeing = nil;



//排除一下用webview预览文件出现乱码情况

//带编码头的如utf-8等，



NSString *body = [NSString stringWithContentsOfFile:self.fullPath usedEncoding:useEncodeing error:nil];

 
//识别不到，按GBK编码再解码一次.这里不能先按GB18030解码，否则会出现整个文档无换行bug。

 
if (!body) {
 
     body = [NSString stringWithContentsOfFile:self.fullPath encoding:0x80000632 error:nil];
    
    
    
}



//还是识别不到，按GB18030编码再解码一次.



if (!body) {
    
    
    
    
    
    
    
    body = [NSString stringWithContentsOfFile:self.fullPath encoding:0x80000631 error:nil];
    
    
    
}



//展现



if (body) {
    
    
    
    body =[body stringByReplacingOccurrencesOfString:@"\n" withString:@"<br>"];//替换换行符为HTML换行符
    
    [webView loadHTMLString:body baseURL:fileRUL];
    
 
}else { //其他文件直接加载请求
 
    NSURLRequest *request = [NSURLRequest requestWithURL:fileRUL];
    
    [webView loadRequest:request];
    
    
    
    
    
}

}



//然后监听一下webview加载完成的时候，根据webview是否展示内容，来判断是否预览成功

#pragma mark- webViewDelegate



//加载完成

- (void)webViewDidFinishLoad:(UIWebView *)webView

{
    
    
    
    //获取加载的h5字符串的body
    
    NSString *lJs = @"document.documentElement.innerText";//获取当前网页的html
    
    NSString *currentHTMLBody = [webView stringByEvaluatingJavaScriptFromString:lJs];
    
    if ([currentHTMLBody isEqualToString:@""]) { //不能预览
        
        //做一些不能预览的处理操作
        
    }
    
    ;
    
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

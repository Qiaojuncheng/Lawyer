//
//  BaseViewController.m
//  TheLawyer
//
//  Created by yaoyao on 17/7/18.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import "BaseViewController.h"
//#import "LoginViewController.h"
//#import "MyCenterViewController.h"

@interface BaseViewController ()

@property(nonatomic,copy) void (^leftBarActionBlock)(void);
@property(nonatomic,copy) void (^rightBarActionBlock)(void);



//@property (nonatomic, assign) BOOL isStatusBarBlack;

@end

@implementation BaseViewController

- (void)initCustomNavigationBar
{
    self.naviBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, NavStatusBarHeight)];
    
    self.naviBarView.backgroundColor = THEMECOLOR;
    [self.view addSubview:self.naviBarView];
    
    self.lineLabel = [[UILabel alloc] init];
    self.lineLabel.backgroundColor = RGBMCOLOR(230);
    self.lineLabel.hidden = YES;
    [self.naviBarView addSubview:self.lineLabel];
    
    self.lineLabel.sd_layout
    .leftSpaceToView(self.naviBarView, 0)
    .topSpaceToView(self.naviBarView, NavStatusBarHeight - 0.5)
    .widthIs(SCREENWIDTH)
    .heightIs(0.5);
}

- (void)upLoadCustomNavigationView
{
    
    self.lineLabel.hidden = YES;
    self.naviBarView.backgroundColor = APPCOLOR;
    [self.backButton setNormalImage:@"nav_arrow"];
    [self.backButton setPressedImage:@"nav_arrow"];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

#pragma mark - 导航栏相关
- (void)addBackButton
{
    NSArray *viewControllers = self.navigationController.viewControllers;
    if (viewControllers.count > 1) {
        self.backButton = [UIButton buttonWithType:0];
        [self.backButton setNormalImage:@"nav_arrow"];
        [self.backButton setPressedImage:@"nav_arrow"];
        [self.backButton addClickTarget:self action:@selector(BackButtonAction:)];
        [self.naviBarView addSubview:self.backButton];
        
        self.backButton.sd_layout
        .leftSpaceToView(self.naviBarView,2)
        .topSpaceToView(self.naviBarView,StatusBarHeight )
        .widthIs(40)
        .heightIs(40);
    }
}

- (void)BackButtonAction:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addLeftButtonWithImage:(NSString *)image preImg:(NSString *)preImg actionBlock:(void (^)(void))block
{
    UIButton *LeftBtn = [UIButton buttonWithType:0];
    LeftBtn.backgroundColor = [UIColor clearColor];
    [LeftBtn setNormalImage:image];
    [LeftBtn setPressedImage:preImg];
    [LeftBtn addClickTarget:self action:@selector(leftBar_Touched:)];
    self.leftBarActionBlock = block;
    [self.naviBarView addSubview:LeftBtn];
    
    LeftBtn.sd_layout
    .leftSpaceToView(self.naviBarView,5)
    .topSpaceToView(self.naviBarView,StatusBarHeight)
    .widthIs(44)
    .heightIs(44);
}

- (void)leftBar_Touched:(id)sender
{
    if (self.leftBarActionBlock) {
        self.leftBarActionBlock();
    }
}

- (void)addRightButtonWithImage:(NSString *)image preImg:(NSString *)preImg actionBlock:(void (^)(void))block
{
    UIButton *rightButton = [UIButton buttonWithType:0];
     rightButton.backgroundColor = [UIColor clearColor];
    [rightButton setNormalImage:image];
    [rightButton setPressedImage:image];
    [rightButton addClickTarget:self action:@selector(rightBar_Touched:)];
    self.rightBarActionBlock = block;
    [self.naviBarView addSubview:rightButton];
    
    rightButton.sd_layout
    .rightSpaceToView(self.naviBarView,5)
    .topSpaceToView(self.naviBarView,StatusBarHeight)
    .widthIs(44)
    .heightIs(44);
}

-(void)addleftButtonWithTitle:(NSString *)title actionBlock:(void (^)(void))block
{
    UIButton *LeftBtn = [UIButton buttonWithType:0];
    LeftBtn.backgroundColor = [UIColor clearColor];
    [LeftBtn setNormalTitle:title];
    [LeftBtn.titleLabel setNormalFont:15.0f];
    [LeftBtn addClickTarget:self action:@selector(leftBar_Touched:)];
    self.leftBarActionBlock = block;
    [self.naviBarView addSubview:LeftBtn];
    
    LeftBtn.sd_layout
    .leftSpaceToView(self.naviBarView,5)
    .topSpaceToView(self.naviBarView,StatusBarHeight)
    .widthIs(44)
    .heightIs(44);
}

- (void)addRightButtonWithTitle:(NSString *)title titleColor:(UIColor *)color actionBlock:(void (^)(void))block
{
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.backgroundColor = [UIColor whiteColor];
    [rightButton setNormalTitle:title];
    [rightButton setTitleColor:color];
    [rightButton.titleLabel setNormalFont:16.0f];
    [rightButton addClickTarget:self action:@selector(rightBar_Touched:)];
    self.rightBarActionBlock = block;
    [self.naviBarView addSubview:rightButton];
    [rightButton sizeToFit];
    rightButton.sd_layout
    .rightSpaceToView(self.naviBarView,5)
    .topSpaceToView(self.naviBarView,StatusBarHeight)
    .widthIs(rightButton.width+10)
    .heightIs(44);
}

- (void)rightBar_Touched:(id)sender
{
    if (self.rightBarActionBlock) {
        self.rightBarActionBlock();
    }
}

- (void)addCenterLabelWithTitle:(NSString *)title titleColor:(UIColor *)color
{
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.text = title;
    [self.naviBarView addSubview:self.titleLabel];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, StatusBarHeight, SCREENWIDTH - 100, NavStatusBarHeight - StatusBarHeight)];
        _titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:17];

        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
//        [_titleLabel setNormalFont:18.0f];
    }
    return _titleLabel;
}
//
//#pragma mark - 跳转登录页面
//- (void)jumpLoginViewControllerBlock:(void(^)(void))block
//{
//    LoginViewController *loginVC = [[LoginViewController alloc] init];
//    BaseNavigationController *loginNav = [[BaseNavigationController alloc] initWithRootViewController:loginVC];
//    loginNav.xFirstBlock = ^(){
//        if (block) {
//            block();
//        }
//    };
//    [self presentViewController:loginNav animated:YES completion:^{
//    }];
//}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.view bringSubviewToFront:self.naviBarView];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSString* cName = [NSString stringWithFormat:@"%@",  self.titleLabel.text, nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSString* cName = [NSString stringWithFormat:@"%@", self.titleLabel.text, nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder)to:nil from:nil forEvent:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.view.backgroundColor = DEFAULTBGCOLOR;
    
    [self.navigationController setNavigationBarHidden:YES];
//    self.fd_prefersNavigationBarHidden = YES;
    
    [self initCustomNavigationBar];
    [self addBackButton];
    
    _scale=1.0;
    if ([[UIScreen mainScreen] bounds].size.height > 480)
    {
        //适配的Scale
        //1136x640
        _scale = [[UIScreen mainScreen] bounds].size.height / 568.0;
    }
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
}

//隐藏键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder)to:nil from:nil forEvent:nil];
}

#pragma mark -- 没有数据时的please hold
- (UIView *)pleaseHoldWithImageName:(NSString *)image title:(NSString *)title subtitle:(NSString *)subtitle button:(NSString *)button andAction:(SEL)action frame:(CGRect)frame isNoNet:(BOOL)ifNoNet {
    UIView *bigView = [[UIView alloc] initWithFrame:frame];
    bigView.backgroundColor = [UIColor whiteColor];
    
    
    // 图片
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:image]];
    
    // title
    UILabel *titleLabel = [UILabel new];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = title;
    
    // subTitle
    UILabel *subtitleLabel = [UILabel new];
    subtitleLabel.font = [UIFont systemFontOfSize:13];
    subtitleLabel.textColor = RGBMCOLOR(153);
    subtitleLabel.textAlignment = NSTextAlignmentCenter;
    subtitleLabel.text = subtitle;
    subtitleLabel.numberOfLines = 0;
    
    // 按钮
    UIButton *holdButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [holdButton setNormalTitle:button];
    holdButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [holdButton setTitleColor:APPCOLOR];
    if (action) {
        [holdButton addClickTarget:self action:action];
    }
    holdButton.layer.borderWidth = 1;
    holdButton.layer.borderColor = APPCOLOR.CGColor;
    
    if (!button) {
        holdButton.hidden = YES;
    }
    
    [self.view addSubview:bigView];
    [bigView addSubview:imageView];
    [bigView addSubview:titleLabel];
    [bigView addSubview:subtitleLabel];
    [bigView addSubview:holdButton];
    
    titleLabel.sd_layout
    .centerXEqualToView(bigView)
    .centerYEqualToView(bigView)
    .widthIs(SCREENWIDTH)
    .heightIs(20);
    
    if (ifNoNet) {
        imageView.sd_layout
        .bottomSpaceToView(titleLabel, 30)
        .centerXEqualToView(bigView)
        .widthIs(160)
        .heightIs(150);
    } else {
        imageView.sd_layout
        .bottomSpaceToView(titleLabel, 30)
        .centerXEqualToView(bigView)
        .widthIs(160)
        .heightIs(123);
    }
    
    subtitleLabel.sd_layout
    .topSpaceToView(titleLabel, 5)
    .centerXEqualToView(bigView)
    .widthIs(SCREENWIDTH - 30)
    .heightIs(35);
    
    holdButton.sd_layout
    .topSpaceToView(subtitleLabel, 15)
    .centerXEqualToView(bigView)
    .widthIs(SCREENWIDTH / 3.0)
    .heightIs(40);
    
    return bigView;
}

//- (void)jumpWebViewWithUrl:(NSString *)url {
//    BaseWebViewController *baseWebVC = [BaseWebViewController new];
//    baseWebVC.webUrl = url;
//    [[PublicMethod getCurrentDisplayedViewController].navigationController pushViewController:baseWebVC animated:YES];
//}

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

//
//  BaseViewController.h
//  TheLawyer
//
//  Created by yaoyao on 17/7/18.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

static int ZCount = 0;

@interface BaseViewController : UIViewController<UIAlertViewDelegate,UIActionSheetDelegate>

//自定义导航条
@property (nonatomic, strong) UIView *naviBarView;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UILabel *lineLabel;
@property(nonatomic,assign)float scale;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, copy) void(^cancelBlock)(void);
@property (nonatomic, copy) void(^otherBlock)(NSString *text);

@property (nonatomic, copy) void(^othersBlock)(NSInteger index);

//更新导航栏样式
- (void)upLoadCustomNavigationView;

//添加按钮标题的方法
- (void)addBackButton;
- (void)addLeftButtonWithImage:(NSString *)image preImg:(NSString *)preImg actionBlock:(void(^)(void))block;
- (void)addRightButtonWithImage:(NSString *)image  preImg:(NSString *)preImg actionBlock:(void(^)(void))block;
-(void)addleftButtonWithTitle:(NSString*)title actionBlock:(void(^)(void))block;
- (void)addRightButtonWithTitle:(NSString *)title titleColor:(UIColor *)color actionBlock:(void(^)(void))block;


- (void)addCenterLabelWithTitle:(NSString *)title titleColor:(UIColor *)color;

/**
 *  跳转登录页面
 */
- (void)jumpLoginViewControllerBlock:(void(^)(void))block;

/**
 *  无数据或无网时hold页
 *
 *  @param image    图片名
 *  @param title    主标题
 *  @param subtitle 副标题
 *  @param button   按钮标题
 *  @param action   按钮点击事件
 */
- (UIView *)pleaseHoldWithImageName:(NSString *)image title:(NSString *)title subtitle:(NSString *)subtitle button:(NSString *)button andAction:(SEL)action frame:(CGRect)frame isNoNet:(BOOL)ifNoNet;

/**
 *  返回按钮
 */
- (void)BackButtonAction:(UIButton *)btn;

/**
 *  跳转web页
 */
- (void)jumpWebViewWithUrl:(NSString *)url;

@end

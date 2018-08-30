//
//  ZYTabBar.m
//  TheLawyer
//
//  Created by yaoyao on 17/7/18.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import "ZYTabBar.h"
@interface ZYTabBar ()

@property (nonatomic, strong) ZYTabBarButton *selButton;

@end

@implementation ZYTabBar
- (NSMutableArray *)buttonArray
{
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray new];
    }
    return _buttonArray;
}

- (void)addImageView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 0.5)];
    view.backgroundColor = RGBMCOLOR(230);
    [self addSubview:view];
}

- (void)addBarButtonWithNorName:(NSString *)nor andDisName:(NSString *)dis andTitle:(NSString *)title
{
    ZYTabBarButton *btn = [ZYTabBarButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, SCREENWIDTH / 5.0, MainTabBarHeight);
    [btn setImage:[UIImage imageNamed:nor] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:dis] forState:UIControlStateDisabled];
    
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:RGBCOLOR(80, 82, 80) forState:UIControlStateNormal];
    [btn setTitleColor:RGBCOLOR(245, 59, 71) forState:UIControlStateDisabled];
    
    [btn addTarget:self action:@selector(tabBarButtonClicked:) forControlEvents:UIControlEventTouchDown];
    
    [self addSubview:btn];
    
    [self.buttonArray addObject:btn];
    
    //让第一个按钮默认为选中状态
    if (self.subviews.count == 2) {
        [self tabBarButtonClicked:btn];
    }
}

- (void)layoutSubviews
{
    for (int i = 1; i<self.subviews.count; i++) {
        UIButton *btn = self.subviews[i];
        CGFloat btnW = SCREENWIDTH / 5.0;
        CGFloat btnH = 49;
        CGFloat btnX = (i-1) * btnW;
        CGFloat btnY = 0;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        // 绑定tag 便于后面使用
        btn.tag = i-1;
    }
}

#pragma mark - Action
- (void)tabBarButtonClicked:(ZYTabBarButton *)btn
{
    // 响应代理方法 实现页面跳转
    if ([self.tbDelegate respondsToSelector:@selector(ChangSelIndexForm:to:)]) {
        [self.tbDelegate ChangSelIndexForm:_selButton.tag to:btn.tag];
    }
    // 设置按钮显示状态 并切换选中按钮
    _selButton.enabled = YES;
    _selButton = btn;
    btn.enabled = NO;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

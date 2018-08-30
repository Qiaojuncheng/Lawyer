//
//  ShowHUD.m
//  WeiFenGou
//
//  Created by wyb on 16/3/14.
//  Copyright © 2016年 WeiFenGou. All rights reserved.
//

#import "ShowHUD.h"

#ifdef DEBUG
#define ShowHUD_DLog(fmt, ...) NSLog((@"ShowHUD.m:%s:%d" fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define ShowHUD_DLog(...)
#endif

@interface ShowHUD ()<MBProgressHUDDelegate>

{
    MBProgressHUD   *_hud;
}

@end

@implementation ShowHUD

- (instancetype)initWithView:(UIView *)view
{
    if (view == nil) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        _hud = [[MBProgressHUD alloc] initWithView:view];
        _hud.delegate                  = self;                       // 设置代理
        _hud.animationType             = MBProgressHUDAnimationZoom; // 默认动画样式
        _hud.removeFromSuperViewOnHide = YES;                        // 该视图隐藏后则自动从父视图移除掉
        [view addSubview:_hud];
    }
    return self;
}

- (void)hide:(BOOL)hide afterDelay:(NSTimeInterval)delay
{
    [_hud hide:hide afterDelay:delay];
}

- (void)hide
{
    [_hud hide:YES];
}

- (void)show:(BOOL)show
{
    // 根据属性判断是否要显示文本
    if (_text != nil && _text.length != 0) {
        _hud.labelText = _text;
    }
    
    // 设置文本字体
    if (_textFont) {
        _hud.labelFont = _textFont;
    }
    
    // 如果设置这个属性,则只显示文本
    if (_showTextOnly == YES && _text != nil && _text.length != 0) {
        _hud.mode = MBProgressHUDModeText;
    }
    
    // 设置背景色
    if (_backgroundColor) {
        _hud.color = _backgroundColor;
    }
    
    // 文本颜色
    if (_labelColor) {
        _hud.labelColor = _labelColor;
    }
    
    // 设置圆角
    if (_cornerRadius) {
        _hud.cornerRadius = _cornerRadius;
    }
    
    // 设置透明度
    if (_opacity) {
        _hud.opacity = _opacity;
    }
    
    // 自定义view
    if (_customView) {
        _hud.mode = MBProgressHUDModeCustomView;
        _hud.customView = _customView;
    }
    
    // 边缘留白
    if (_margin > 0) {
        _hud.margin = _margin;
    }
    
    if (_offSet) {
        _hud.yOffset = _offSet;
    }
    
    if (_interaction) {
        _hud.userInteractionEnabled = _interaction;
    }
    
    [_hud show:show];
}

#pragma mark - HUD代理方法
- (void)hudWasHidden:(MBProgressHUD *)hud
{
    [_hud removeFromSuperview];
    _hud = nil;
}

#pragma mark - 重写setter方法
@synthesize animationStyle = _animationStyle;
- (void)setAnimationStyle:(HUDAnimationType)animationStyle
{
    _animationStyle    = animationStyle;
    _hud.animationType = (MBProgressHUDAnimation)_animationStyle;
}
- (HUDAnimationType)animationStyle
{
    return _animationStyle;
}

#pragma mark - 便利的方法
+ (void)showTextOnly:(NSString *)text
     configParameter:(ConfigShowHUDBlock)config
            duration:(NSTimeInterval)sec
              inView:(UIView *)view
{
    ShowHUD *hud     = [[ShowHUD alloc] initWithView:view];
    hud.text         = text;
    hud.showTextOnly = YES;
    hud.margin       = 10.f;
    
    // 配置额外的参数
    config(hud);
    
    // 显示
    [hud show:YES];
    
    // 延迟sec后消失
    [hud hide:YES afterDelay:sec];
}

+ (void)showText:(NSString *)text
 configParameter:(ConfigShowHUDBlock)config
        duration:(NSTimeInterval)sec
          inView:(UIView *)view
{
    ShowHUD *hud     = [[ShowHUD alloc] initWithView:view];
    hud.text         = text;
    hud.margin       = 10.f;
    
    // 配置额外的参数
    config(hud);
    
    // 显示
    [hud show:YES];
    
    // 延迟sec后消失
    [hud hide:YES afterDelay:sec];
}


+ (void)showCustomView:(ConfigShowHUDCustomViewBlock)viewBlock
       configParameter:(ConfigShowHUDBlock)config
              duration:(NSTimeInterval)sec
                inView:(UIView *)view
{
    ShowHUD *hud     = [[ShowHUD alloc] initWithView:view];
    hud.margin       = 10.f;
    
    // 配置额外的参数
    config(hud);
    
    // 自定义View
    hud.customView   = viewBlock();
    
    // 显示
    [hud show:YES];
    
    [hud hide:YES afterDelay:sec];
}


+ (instancetype)showTextOnly:(NSString *)text
             configParameter:(ConfigShowHUDBlock)config
                      inView:(UIView *)view
{
    ShowHUD *hud     = [[ShowHUD alloc] initWithView:view];
    hud.text         = text;
    hud.showTextOnly = YES;
    hud.margin       = 10.f;
    
    // 配置额外的参数
    config(hud);
    
    // 显示
    [hud show:YES];
    
    return hud;
}

+ (instancetype)showText:(NSString *)text
         configParameter:(ConfigShowHUDBlock)config
                  inView:(UIView *)view
{
    ShowHUD *hud     = [[ShowHUD alloc] initWithView:view];
    hud.text         = text;
    hud.margin       = 10.f;
    
    // 配置额外的参数
    config(hud);
    
    // 显示
    [hud show:YES];
    
    return hud;
}

+ (instancetype)showCustomView:(ConfigShowHUDCustomViewBlock)viewBlock
               configParameter:(ConfigShowHUDBlock)config
                        inView:(UIView *)view
{
    ShowHUD *hud     = [[ShowHUD alloc] initWithView:view];
    hud.margin       = 10.f;
    
    // 配置额外的参数
    config(hud);
    
    // 自定义View
    hud.customView   = viewBlock();
    
    // 显示
    [hud show:YES];
    
    return hud;
}

+ (void)showTextOnly:(NSString *)text duration:(NSTimeInterval)sec inView:(UIView *)view
{
    [ShowHUD showTextOnly:text configParameter:^(ShowHUD *config) {
        config.animationStyle  = ZoomOut;  // 设置动画方式
        config.margin          = 15.f;     // 边缘留白
        config.opacity         = 0.5f;     // 设定透明度
        config.cornerRadius    = 5.f;     // 设定圆角
        config.textFont        = [UIFont systemFontOfSize:16.0f];
        config.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];  // 设置背景色
        config.labelColor      = [[UIColor whiteColor] colorWithAlphaComponent:1.0];// 设置文本颜色
    } duration:sec inView:view];
}

+ (void)showWYBTextOnly:(NSString *)text duration:(NSTimeInterval)sec inView:(UIView *)view
{
    [ShowHUD showCustomView:^UIView *{
        
        CGSize size = [PublicMethod getContentSizeWithContent:text width:SCREENWIDTH / 3.0 * 2.0 font:[UIFont systemFontOfSize:16.0f]];
        float width = SCREENWIDTH / 3.0 * 2.0;
        if (size.width < SCREENWIDTH / 3.0 * 2.0 - 30) {
            width = size.width + 30;
        }
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, size.height)];
        bgView.backgroundColor = [UIColor clearColor];
        
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:bgView.bounds];
        contentLabel.text = text;
        contentLabel.numberOfLines = 0;
        contentLabel.textAlignment = NSTextAlignmentCenter;
        contentLabel.textColor = [UIColor whiteColor];
        [contentLabel setNormalFont:16.0f];
        [bgView addSubview:contentLabel];
        
        return bgView;
        
    } configParameter:^(ShowHUD *config) {
        config.animationStyle  = ZoomOut;  // 设置动画方式
        config.margin          = 13.0f;     // 边缘留白
        config.opacity         = 0.5f;     // 设定透明度
        config.cornerRadius    = 5.f;     // 设定圆角
        config.textFont        = [UIFont systemFontOfSize:16.0f];
        config.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];  // 设置背景色
        config.labelColor      = [[UIColor whiteColor] colorWithAlphaComponent:1.0];// 设置文本颜色
    } duration:sec inView:view];
}

+ (instancetype)showText:(NSString *)text inView:(UIView *)view
{
    ShowHUD *hud = [ShowHUD showText:text configParameter:^(ShowHUD *config) {
        config.animationStyle  = Fade;  // 设置动画方式
        config.margin          = 20.f;     // 边缘留白
        config.opacity         = 0.5f;     // 设定透明度
        config.cornerRadius    = 5.f;     // 设定圆角
        config.textFont        = [UIFont systemFontOfSize:15.0f];
        config.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];  // 设置背景色
        config.labelColor      = [[UIColor whiteColor] colorWithAlphaComponent:1.0];// 设置文本颜色
    } inView:view];
    return hud;
}

+ (instancetype)showCustomLoadingInView:(UIView *)view
{
    ShowHUD *hud = [self showCustomView:^UIView *{
        
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0; i < 4; i ++) {
            [array addObject:[UIImage imageNamed:[NSString stringWithFormat:@"0%d",i + 1]]];
        }
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        img.animationDuration = 0.6;
        img.animationRepeatCount = 0;
        img.animationImages = array;
        [img startAnimating];
        return img;
        
    } configParameter:^(ShowHUD *config) {
        config.animationStyle  = Fade;  // 设置动画方式
        config.margin          = 5.0f;     // 边缘留白
        config.cornerRadius    = 5.f;     // 设定圆角
        config.interaction     = NO;
        config.offSet          = -25;
        config.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];  // 设置背景色
    } inView:view];
    return hud;
}

- (void)dealloc
{
    
}

@end

//
//  UIViewController+HUD.m
//  WuKong
//
//  Created by 赵耀 on 16/5/17.
//  Copyright © 2016年 weifengou. All rights reserved.
//

#import "UIViewController+HUD.h"
#import "MBProgressHUD.h"
#import <objc/runtime.h>

// 屏幕宽
#define ConentViewWidth  [UIScreen mainScreen].bounds.size.width

#define kScreenW  ConentViewWidth
//  出去导航栏高度
#define ConentViewHeight ((IS_IOS_7)?([UIScreen mainScreen].bounds.size.height - NavBarHeight):([UIScreen mainScreen].bounds.size.height - NavBarHeight -StatusBarHeight))

static const void *HttpRequestHUDKey = &HttpRequestHUDKey;

@implementation UIViewController (HUD)
#define SCREEN_HEIGHT self.view.bounds.size.height
- (MBProgressHUD *)HUD{
    return objc_getAssociatedObject(self, HttpRequestHUDKey);
}

- (void)setHUD:(MBProgressHUD *)HUD{
    objc_setAssociatedObject(self, HttpRequestHUDKey, HUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)showHudInView:(UIView *)view hint:(NSString *)hint{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    HUD.labelText = hint;
    [view addSubview:HUD];
    [HUD show:YES];
    [self setHUD:HUD];
}

- (void)showHint:(NSString *)hint {
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeText;
    hud.labelText = hint;
    hud.margin = 10.f;
    hud.yOffset = SCREEN_HEIGHT / 2 - 100;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
}

- (void)showHint:(NSString *)hint yOffset:(float)yOffset {
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = hint;
    hud.margin = 10.f;
    //    hud.yOffset = IS_IPHONE_5?200.f:150.f;
    hud.yOffset += yOffset;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
}

- (void)hideHud
{
    [[self HUD] hide:YES];
}



- (void)ShowNoDataViewWithStr:(NSString *) ShowStr yOffset:(float)yOffset{
    UIView * showViews =[self.view viewWithTag:101];
    [showViews removeFromSuperview];
    
    UIView * ShowView =[[UIView alloc]initWithFrame:CGRectMake(ConentViewWidth/2 - 50,0,100 , 60)];
    ShowView.tag = 101;
    ShowView.centerY = self.view.centerY  + yOffset;
    ShowView.backgroundColor =[UIColor clearColor];
    
    
    UIImageView * ima =[[UIImageView alloc]initWithFrame:CGRectMake(35, 0, 30, 30)];
    ima.image =[UIImage imageNamed:@"wjl"];
    [ShowView addSubview:ima];
    
    
    UILabel  * showLabel =[[UILabel alloc]initWithFrame:CGRectMake(0,40 , 100 , 20)];
    showLabel.text = ShowStr ;
    showLabel.textAlignment = NSTextAlignmentCenter;
    showLabel.font =  [UIFont systemFontOfSize:14];
    showLabel.textColor =[UIColor colorWithHex:0x666666];
    [ShowView addSubview:showLabel];
    
    //    UIView *view = [[UIApplication sharedApplication].delegate window];
    [ self.view addSubview:ShowView];
    
}
-(void)hintNodataView{
    UIView * showView =[self.view viewWithTag:101];
    [showView removeFromSuperview];
    
}

-(void)createShowMessage:(NSString *)labelTitle {
    
    
    UIImageView * ImageView=(UIImageView *)[self.view viewWithTag:333];
    UILabel * label = (UILabel *)[self.view viewWithTag:222];
    
    if (!ImageView) {
        
        UIImageView * ShowImageView= [[UIImageView alloc]initWithFrame:CGRectMake((ConentViewWidth-157/2)/2, (ConentViewHeight-181/2)/2-44, 157/2, 181/2)];
        ShowImageView.image = [UIImage imageNamed:@"zanwushuju1"];
        ShowImageView.tag = 333;
        
        [self.view addSubview:ShowImageView];
        NSLog(@"又建了一次？？？？？？？？？");
    }else{
        
        NSLog(@"没有重新建!!!!");
    }
    
    if (! label) {
        
        UILabel * Showlabel = [[UILabel alloc]initWithFrame:CGRectMake((ConentViewWidth-200)/2, (ConentViewHeight-181/2)/2-44+181/2+10, 200, 10)];
        Showlabel.textAlignment = NSTextAlignmentCenter;
        //        Showlabel.textColor = RGB11(212, 212, 212);
        Showlabel.textColor = [UIColor grayColor];
        Showlabel.tag = 222;
        Showlabel.text = labelTitle;
        [self.view addSubview:Showlabel];
    }
    
    
    
    
}

-(void)removeShowMessage{
    
    UIImageView * ImageView=(UIImageView *)[self.view viewWithTag:333];
    
    
    [ImageView removeFromSuperview];
    
    UILabel * label = (UILabel *)[self.view viewWithTag:222];
    
    [label removeFromSuperview];
}






@end

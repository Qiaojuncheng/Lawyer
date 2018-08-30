//
//  UIViewController+HUD.h
//  WuKong
//
//  Created by 赵耀 on 16/5/17.
//  Copyright © 2016年 weifengou. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface UIViewController (HUD)
- (void)showHudInView:(UIView *)view hint:(NSString *)hint;

- (void)hideHud;

- (void)showHint:(NSString *)hint;
// 从默认(showHint:)显示的位置再往上(下)yOffset
- (void)showHint:(NSString *)hint yOffset:(float)yOffset;

-(void)createShowMessage:(NSString *)labelTitle;
-(void)removeShowMessage;
// 没有数据的时时候显示
- (void)ShowNoDataViewWithStr:(NSString *) ShowStr yOffset:(float)yOffset;
- (void) hintNodataView;

@end

//
//  WKButton.h
//  WuKong
//
//  Created by 赵耀 on 16/5/3.
//  Copyright © 2016年 weifengou. All rights reserved.
//

#import <UIKit/UIKit.h>


@class WKButton;

typedef void(^block)(WKButton *button);

@interface WKButton : UIButton

+(WKButton *)buttonWithFrame:(CGRect)frame
                        type:(UIButtonType)type
                       title:(NSString *)title
             backgroundColor:(UIColor *)color
                      target:(id)target
                      action:(SEL)selector;

+(WKButton *)buttonWithFrame:(CGRect)frame type:(UIButtonType)type title:(NSString *)title andBlock:(block)tempBlock;

@end

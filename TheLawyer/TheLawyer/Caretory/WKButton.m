//
//  WKButton.m
//  WuKong
//
//  Created by 赵耀 on 16/5/3.
//  Copyright © 2016年 weifengou. All rights reserved.
//

#import "WKButton.h"

@interface WKButton ()
//注意:给block变量下合成存取, 一定要用copy
@property(nonatomic,copy) block myBlock;
@end


@implementation WKButton



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+(WKButton *)buttonWithFrame:(CGRect)frame
                        type:(UIButtonType)type
                       title:(NSString *)title
             backgroundColor:(UIColor *)color
                      target:(id)target
                      action:(SEL)selector{
    
    WKButton *button = [WKButton buttonWithType:type];
    [button setTitle:title forState:UIControlStateNormal];
    button.frame = frame;
    //    button.backgroundColor = [UIColor cyanColor];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}
+(WKButton *)buttonWithFrame:(CGRect)frame type:(UIButtonType)type title:(NSString *)title andBlock:(block)tempBlock{
    WKButton *button = [WKButton buttonWithType:type];
    [button setTitle:title forState:UIControlStateNormal];
    button.frame = frame;
    button.titleLabel.font = [UIFont systemFontOfSize:14] ;
    [button addTarget:button action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    button.myBlock = tempBlock;
    return button;
    
    
}
-(void)buttonClicked:(WKButton *)button{
    //    NSLog(@"block来的");
    //触发按钮
    //    button.tag = 10;
    button.myBlock(button);
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

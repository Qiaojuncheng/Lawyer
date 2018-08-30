//
//  ZYSuperView.m
//  WuKong
//
//  Created by 张炳鑫 on 16/7/21.
//  Copyright © 2016年 weifengou. All rights reserved.
//

#import "ZYSuperView.h"

@implementation ZYSuperView

// 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _scale = 1.0;
        if ([[UIScreen mainScreen] bounds].size.height > 568)//1334*750
        {
            _scale = [[UIScreen mainScreen] bounds].size.height /568.0;// 667.0;
        }
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

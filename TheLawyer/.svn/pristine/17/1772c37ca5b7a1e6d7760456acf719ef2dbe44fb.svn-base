//
//  ZYrepeatLableView.m
//  JiuXiao
//
//  Created by 张炳鑫 on 16/9/8.
//  Copyright © 2016年 Ed. All rights reserved.
//

#import "ZYrepeatLableView.h"

@implementation ZYrepeatLableView

- (instancetype)init {
    if (self = [super init]) {
        
        [self buildViews];
    }
    return self;
}


- (void)buildViews
{

    
    
}

-(void)ViewMakeWithArray:(NSArray *)DetailArray
{
    for (int a = 0; a<4; a++) {
        _repeatL = [[UILabel alloc] initWithFrame:CGRectMake((a%4)*80+(SCREENWIDTH-80*4)/5*(a%4+1), 41+(a/4*30), 80, 30)];
        _repeatL.text = [NSString stringWithFormat:@"%@",@"粉丝"];//DetailArray[a]
        _repeatL.textAlignment = NSTextAlignmentCenter;
        _repeatL.textColor = RGBCOLOR(255, 222, 36);//WKColor(102, 102, 102);
        _repeatL.font = [UIFont systemFontOfSize:14];
        [self addSubview:_repeatL];
    }
}

@end

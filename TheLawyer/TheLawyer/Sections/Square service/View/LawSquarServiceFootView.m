//
//  LawSquarServiceFootView.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/17.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawSquarServiceFootView.h"

@implementation LawSquarServiceFootView 

-(void)setPriceStr:(NSString *)PriceStr{
     if (!PriceStr) {
        self.TitileLB.text = [NSString stringWithFormat:@"请输入您的竞标价格"];
 
    }else{
        self.TitileLB.text = [NSString stringWithFormat:@"平台统一价格：%@元",PriceStr];
        self.PriceView.hidden = YES;
     }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

//
//  ZYTabBarButton.m
//  TheLawyer
//
//  Created by yaoyao on 17/7/18.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import "ZYTabBarButton.h"
#import "UIView+Frame.h"

@implementation ZYTabBarButton
- (void)setHighlighted:(BOOL)highlighted
{
    // 目的就是重写取消高亮显示
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.y = 5;
    self.imageView.xWidth = 25;
    self.imageView.xHeight = 25;
    self.imageView.x = (self.xWidth - self.imageView.xWidth)/2.0;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.titleLabel.x = self.imageView.x - (self.titleLabel.xWidth - self.imageView.xWidth)/2.0;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame) + 2;
    
    self.titleLabel.shadowColor = [UIColor clearColor];
    [self.titleLabel setNormalFont:10.0f];
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

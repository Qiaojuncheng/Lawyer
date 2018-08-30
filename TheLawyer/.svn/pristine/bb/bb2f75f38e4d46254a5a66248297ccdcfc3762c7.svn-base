//
//  UIButton+ZYButton.m
//  TheLawyer
//
//  Created by yaoyao on 17/7/18.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import "UIButton+ZYButton.h"

@implementation UIButton (ZYButton)
- (void) setNormalTitle:(NSString *)t {
    [self setTitle:t forState:UIControlStateNormal];
}

- (void) setTitleColor:(UIColor* )color {
    [self setTitleColor:color forState:UIControlStateNormal];
}

- (void) setNormalImage:(NSString *)imageName {
    [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}
- (void) setPressedImage:(NSString *)imageName {
    [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateHighlighted];
}


- (void) addClickTarget:(id)target action:(SEL)action {
    [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

@end

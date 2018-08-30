//
//  UIButton+ZYButton.h
//  TheLawyer
//
//  Created by yaoyao on 17/7/18.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (ZYButton)
- (void) setNormalTitle:(NSString *)t;

- (void) setTitleColor:(UIColor* )color;

- (void) setNormalImage:(NSString *)file;
- (void) setPressedImage:(NSString *)file;

- (void) addClickTarget:(id)target action:(SEL)action;
@end

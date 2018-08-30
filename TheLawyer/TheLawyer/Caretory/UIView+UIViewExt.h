//
//  UIView+UIViewExt.h
//  JiuXiao
//
//  Created by wangbo on 16/8/29.
//  Copyright © 2016年 Ed. All rights reserved.
//

#import <UIKit/UIKit.h>

CGPoint CGRectGetCenter(CGRect rect);
CGRect  CGRectMoveToCenter(CGRect rect, CGPoint center);

@interface UIView (UIViewExt)

@property CGPoint origin;
@property CGSize size;

@property (readonly) CGPoint bottomLeft;
@property (readonly) CGPoint bottomRight;
@property (readonly) CGPoint topRight;

@property CGFloat height;
@property CGFloat width;

@property CGFloat top;
@property CGFloat left;

@property CGFloat bottom;
@property CGFloat right;

// 移动
- (void) moveBy: (CGPoint) delta;
// 缩放
- (void) scaleBy: (CGFloat) scaleFactor;
// 固定原宽高比，放入新size内
- (void) fitInSize: (CGSize) aSize;
//下一个响应链
- (UIViewController *)viewController;

@end

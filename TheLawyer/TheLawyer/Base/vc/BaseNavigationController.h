//
//  BaseNavigationController.h
//  TheLawyer
//
//  Created by yaoyao on 17/7/18.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^XFirstBlock)();

@interface BaseNavigationController : UINavigationController

// block
@property (nonatomic, copy) XFirstBlock xFirstBlock;

- (void)popViewController:(NSInteger)index;

@end

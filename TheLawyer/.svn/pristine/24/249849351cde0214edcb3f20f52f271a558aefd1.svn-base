//
//  ZYTabBar.h
//  TheLawyer
//
//  Created by yaoyao on 17/7/18.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYTabBarButton.h"

@protocol ZYTabBarDelegate <NSObject>

- (void)ChangSelIndexForm:(NSInteger)from to:(NSInteger)to;

@end
@interface ZYTabBar : UIView
@property (nonatomic, assign) id<ZYTabBarDelegate> tbDelegate;

@property (nonatomic, strong) NSMutableArray *buttonArray;

- (void)addImageView;

- (void)addBarButtonWithNorName:(NSString *)nor andDisName:(NSString *)dis andTitle:(NSString *)title;

- (void)tabBarButtonClicked:(ZYTabBarButton *)btn;

@end

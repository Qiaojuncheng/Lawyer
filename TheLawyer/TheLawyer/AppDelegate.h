//
//  AppDelegate.h
//  TheLawyer
//
//  Created by yaoyao on 17/7/18.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "MineViewController.h"
#import "MessageViewController.h"
#import "ZYMainTabBarController.h"
#import "GuideViewController.h"
static const CGFloat kDefaultPlaySoundInterval = 3.0;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
//tabbar
@property (nonatomic, strong) ZYMainTabBarController *mainTabbar;
//主视图
@property (nonatomic, strong) MainViewController *mainViewController;
@property (strong, nonatomic) NSDate *lastPlaySoundDate;

@property(nonatomic,strong)UITabBarController *tabBarController;


@end


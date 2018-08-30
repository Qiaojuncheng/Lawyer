//
//  MainViewController.h
//  TheLawyer
//
//  Created by yaoyao on 17/7/18.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import "BaseViewController.h"

@interface MainViewController : BaseViewController

@property (nonatomic, assign) NSInteger currentColumn;
@property (nonatomic, strong) UIView *navView;
@property (nonatomic, strong) UILabel *dividerLabel;
@property (nonatomic, strong) UIScrollView *typeScrollView;
@property (nonatomic, strong) UILabel *redLabel;
@property (nonatomic, strong) NSMutableArray *childArray;

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, assign) BOOL isShow;

 
@end

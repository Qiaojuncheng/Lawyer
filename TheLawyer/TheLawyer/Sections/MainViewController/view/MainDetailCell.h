//
//  MainDetailCell.h
//  TheLawyer
//
//  Created by yaoyao on 17/7/30.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainDetailModel.h"

@interface MainDetailCell : UITableViewCell
// title
@property (nonatomic, strong) UILabel *titleLabel;

// subTitle
@property (nonatomic, strong) UILabel *subTitleLabel;

@property (nonatomic, strong) MainDetailModel *tempModel;

@end

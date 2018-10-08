//
//  LawMondetaulCell.h
//  TheLawyer
//
//  Created by MYMAc on 2018/8/14.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LawMoneyDetailModel.h"
@interface LawMondetaulCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *deteailtitle;
@property (weak, nonatomic) IBOutlet UILabel *DetaileNum;

@property (weak, nonatomic) IBOutlet UILabel *DetailTime;

@property (strong, nonatomic) LawMoneyDetailModel * modle ;


@end

//
//  LawMainConsultCell.h
//  TheLawyer
//
//  Created by MYMAc on 2018/8/15.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LawMainConsultCellMoldel.h"
@interface LawMainConsultCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *PersonImage;
@property (weak, nonatomic) IBOutlet UILabel *PersonName;
@property (weak, nonatomic) IBOutlet UILabel *PersonTypeLB;
@property (weak, nonatomic) IBOutlet UIImageView *adopt;

@property (weak, nonatomic) IBOutlet UILabel *AdressLB;

@property (weak, nonatomic) IBOutlet UILabel *ConcentLB;

@property (weak, nonatomic) IBOutlet UILabel *TimeLB;
@property (weak, nonatomic) IBOutlet UIView *RedView;


@property (weak, nonatomic) IBOutlet UILabel *answerLB;

@property (strong, nonatomic) LawMainConsultCellMoldel * model;


@end

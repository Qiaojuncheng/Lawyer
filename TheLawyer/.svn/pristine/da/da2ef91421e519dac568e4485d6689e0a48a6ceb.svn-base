//
//  RecoudCell.h
//  TheLawyer
//
//  Created by yaoyao on 17/7/28.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordModel.h"
@interface RecoudCell : UITableViewCell


typedef void(^OverBlock)();
@property (strong , nonatomic) RecordModel  * model;
@property (weak, nonatomic) IBOutlet UILabel *SNNumberLB;

@property (weak, nonatomic) IBOutlet UILabel *TitleLB;


@property (weak, nonatomic) IBOutlet UILabel *statusLB;
@property (weak, nonatomic) IBOutlet UILabel *TimeLB;
@property (weak, nonatomic) IBOutlet UILabel *DetailLB;
@property (weak, nonatomic) IBOutlet UIButton *OverBtn;
@property (strong , nonatomic) OverBlock Block;
- (IBAction)OverAction:(id)sender;



@end

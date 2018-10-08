//
//  LawMessageCenterCell.h
//  TheLawyer
//
//  Created by MYMAc on 2018/8/16.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LawNewMessageMM.h"

@interface LawMessageCenterCell : UITableViewCell
@property (strong ,nonatomic) LawNewMessageMM * model;
@property (weak, nonatomic) IBOutlet UILabel *ConcentLB;

@property (weak, nonatomic) IBOutlet UIView *RedView;
@property (weak, nonatomic) IBOutlet UIButton *SeeBtn;
@property (weak, nonatomic) IBOutlet UILabel *TimeLB;

- (IBAction)SeeBtnAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *MeeageImage;


@end

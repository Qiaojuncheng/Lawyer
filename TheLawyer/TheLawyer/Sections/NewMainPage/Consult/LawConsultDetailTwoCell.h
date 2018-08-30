//
//  LawConsultDetailTwoCell.h
//  TheLawyer
//
//  Created by MYMAc on 2018/8/16.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LawConsultDetailReplayModel.h"
@interface LawConsultDetailTwoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *PersonImage;
@property (weak, nonatomic) IBOutlet UILabel *concentLB;

@property (weak, nonatomic) IBOutlet UILabel *PersonName;
@property (weak, nonatomic) IBOutlet UILabel *TimeLB;




@property (strong , nonatomic) LawConsultDetailReplayModel * model;



@end

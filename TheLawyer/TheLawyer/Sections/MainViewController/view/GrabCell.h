//
//  GrabCell.h
//  TheLawyer
//
//  Created by yaoyao on 17/7/28.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import "SuperTableViewCell.h"
#import "GrabModel.h"
@interface GrabCell : SuperTableViewCell

@property (nonatomic,strong) GrabModel *commentsModel;
@property (weak, nonatomic) IBOutlet UILabel *MainTitle;
@property (weak, nonatomic) IBOutlet UILabel *SubTitle;
@property (weak, nonatomic) IBOutlet UILabel *TimeLb;



@end

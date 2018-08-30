//
//  LawMeetingCell.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/18.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawMeetingCell.h"

@implementation LawMeetingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [Utile makeCorner:5 view:self.AgreeBtn];
    [self.RefuseBtn createBordersWithColor:[UIColor colorWithHex:0x4483F6] withCornerRadius:5 andWidth:1];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

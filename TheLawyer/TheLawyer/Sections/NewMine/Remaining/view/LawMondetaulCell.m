//
//  LawMondetaulCell.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/14.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawMondetaulCell.h"

@implementation LawMondetaulCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.DetailTime.text = @"2018-06-09 10:22:06";
    self.deteailtitle.text = @"吃喝嫖赌";
    self.DetaileNum.text = @"-500.00";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

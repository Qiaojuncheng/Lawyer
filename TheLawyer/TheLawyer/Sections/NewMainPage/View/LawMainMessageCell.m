//
//  LawMainMessageCell.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/15.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawMainMessageCell.h"

@implementation LawMainMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [Utile makeCorner:self.RedView.width/2 view:self.RedView];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

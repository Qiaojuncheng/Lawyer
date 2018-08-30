//
//  LawInfoCell.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/21.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawInfoCell.h"

@implementation LawInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [Utile makeCorner:self.RedView.height/2 view:self.RedView];
    self.RedView.hidden = YES;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

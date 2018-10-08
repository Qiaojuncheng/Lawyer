//
//  LawBankCardCell.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/24.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawBankCardCell.h"

@implementation LawBankCardCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [Utile makeCorner:self.CardImage.height/2 view:self.CardImage];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

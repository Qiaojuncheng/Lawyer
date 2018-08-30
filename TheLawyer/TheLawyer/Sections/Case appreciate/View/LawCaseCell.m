//
//  LawCaseCell.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/18.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawCaseCell.h"

@implementation LawCaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [Utile makeCorner:5 view:self.CaseImage];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

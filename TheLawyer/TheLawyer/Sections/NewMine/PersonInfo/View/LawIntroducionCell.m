//
//  LawIntroducionCell.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/22.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawIntroducionCell.h"

@implementation LawIntroducionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [Utile makeCorner:4 view:self.LeftImaeg];
    [Utile makeCorner:4 view:self.RightImage];
    self.LeftImaeg.userInteractionEnabled = YES ;
    self.ImageHeight.constant  = 375/SCREENWIDTH * 84;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

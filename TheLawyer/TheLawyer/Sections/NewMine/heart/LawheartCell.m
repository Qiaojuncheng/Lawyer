//
//  LawheartCell.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/20.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawheartCell.h"

@implementation LawheartCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [Utile makeCorner:self.PeronImage.height/2 view:self.PeronImage];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

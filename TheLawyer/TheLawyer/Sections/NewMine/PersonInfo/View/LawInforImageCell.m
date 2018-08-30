//
//  LawInforImageCell.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/21.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawInforImageCell.h"

@implementation LawInforImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [Utile makeCorner:self.PersonImage.height/2 view:self.PersonImage];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

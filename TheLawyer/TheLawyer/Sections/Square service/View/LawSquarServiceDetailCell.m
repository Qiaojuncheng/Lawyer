//
//  LawSquarServiceDetailCell.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/17.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawSquarServiceDetailCell.h"

@implementation LawSquarServiceDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [Utile makeCorner:self.HeaderImageView.height/2 view:self.HeaderImageView];
    // Initialization code
}
-(void)setModel:(LawServicePingModel *)model{
        _model = model;
    [self.HeaderImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_URL,model.avatar]] placeholderImage:[UIImage imageNamed:@"head_empty"]];
    self.PersonName.text =[NSString stringWithFormat:@"%@律师",model.name];
    self.TimeLB.text = [NSString timeWithTimeIntervalString:model.time];
    self.DesLB.text = model.describe;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

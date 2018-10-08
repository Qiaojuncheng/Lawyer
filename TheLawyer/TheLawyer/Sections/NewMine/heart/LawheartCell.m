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
-(void)setModel:(LawNewHeaterModel *)model{
    _model = model;
    [self.PeronImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_URL,model.user_avatar]] placeholderImage:nil];
    self.PersonName.text = model.user_name;
    self.TimeLb.text = [NSString timeWithTimeIntervalString:model.create_time];
    self.PriceLB.text = model.money;
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

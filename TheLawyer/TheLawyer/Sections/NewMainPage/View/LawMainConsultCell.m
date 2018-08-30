//
//  LawMainConsultCell.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/15.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawMainConsultCell.h"

@implementation LawMainConsultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [Utile makeCorner:self.RedView.width/2 view:self.RedView];
    [Utile makeCorner:self.PersonImage.width/2 view:self.PersonImage];
    [Utile makeCorner:13 view:self.answerLB];

    // Initialization code
}
-(void)setModel:(LawMainConsultCellMoldel *)model{
    _model = model;
    
    [self.PersonImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",Image_URL,_model.avatar]] placeholderImage:[UIImage imageNamed:@""]];
    self.PersonName.text = _model.name;
    self.PersonTypeLB.text = _model.cate_name;
    self.ConcentLB.text = _model.content;
    if ([_model.status isEqualToString:@"1"]) {
        self.adopt.hidden = YES;
    }else{
        self.adopt.hidden = NO;
    }
    self.AdressLB.text =[NSString stringWithFormat:@"%@·%@",_model.province,_model.city];
    self.TimeLB.text = [NSString stringWithFormat:@"%@·%@人回答",_model.create_time,_model.reply_count];
    if ([_model.reply_count integerValue] > 0) {
        
        self.answerLB.text = @"已回答";
    }else {
        self.answerLB.text = @"未回答";

        
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  LawConsultDetailTwoCell.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/16.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawConsultDetailTwoCell.h"

@implementation LawConsultDetailTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [Utile makeCorner:self.PersonImage.width/2 view:self.PersonImage];
    // Initialization code
}
-(void)setModel:(LawConsultDetailReplayModel *)model{
    
    [self.PersonImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",Image_URL,_model.avatar]] placeholderImage:nil];
    self.PersonName.text = _model.lawyer_name;
    self.TimeLB.text = _model.time;
    self.concentLB.text = _model.content;
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

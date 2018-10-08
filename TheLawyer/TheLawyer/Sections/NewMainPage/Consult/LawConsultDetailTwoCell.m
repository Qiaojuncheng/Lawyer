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
    [Utile makeCorner: self.ReplayLB.height/2 view: self.ReplayLB];
    [Utile makeCorner:self.PersonImage.width/2 view:self.PersonImage];
    // Initialization code
}
-(void)setModel:(LawConsultDetailReplayModel *)model{
    _model = model;
    [self.PersonImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",Image_URL,_model.avatar]] placeholderImage:nil];
    self.PersonName.text =[NSString stringWithFormat:@"%@律师", _model.lawyer_name];
    self.TimeLB.text = _model.time;
    self.concentLB.text = _model.content;
    if ([_model.is_adopt isEqualToString:@"0"]) {
        self.adoptImage.hidden = YES;
    }else{
        self.adoptImage.hidden = NO;
    }
    if([_model.answered isEqualToString:@"1"]){
        self.ReplayLB.hidden = NO;
    }else{
        self.ReplayLB.hidden = YES;
    }
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

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
-(void)setModel:(LawCaseNewModel *)model{
    
    self.CaseTitleLB.text = model.title;
    self.CaseTypeLB.text = model.cate_name;
    self.NUmberLB.text = model.click;
    
    self.TimeLb.text = [NSString timeWithTimeIntervalString:model.create_time];
    [self.CaseImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",Image_URL,model.thumb]] placeholderImage:nil];
    

    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

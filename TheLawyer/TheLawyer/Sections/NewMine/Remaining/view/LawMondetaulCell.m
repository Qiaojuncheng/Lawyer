//
//  LawMondetaulCell.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/14.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawMondetaulCell.h"

@implementation LawMondetaulCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
}
-(void)setModle:(LawMoneyDetailModel *)modle{
    _modle = modle;
    self.DetailTime.text = [NSString timeWithTimeIntervalString:modle.time];
    self.deteailtitle.text =[NSString stringWithFormat:@"%@",modle.remark];
    if ([modle.type integerValue] == 1) {
        self.DetaileNum.text =[NSString stringWithFormat:@"+%@",modle.money];

    }else{
        self.DetaileNum.text =[NSString stringWithFormat:@"-%@",modle.money];

    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  LawMainADCell.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/15.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawMainADCell.h"

@implementation LawMainADCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [Utile makeCorner:self.PersinImage.width/2 view:self.PersinImage];
    // Initialization code
}
-(void)setAdmodel:(LawLawMainAdModel *)admodel{
    
    self.PersonName.text = _admodel.PersonName;
    self.TimeLB.text = _admodel.time;
    self.ConcentLB.text = _admodel.Concent;
     self.PricrLB.text = _admodel.price;
    [self.PersinImage sd_setImageWithURL:[NSURL URLWithString:_admodel.PersinImage] placeholderImage:nil];
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

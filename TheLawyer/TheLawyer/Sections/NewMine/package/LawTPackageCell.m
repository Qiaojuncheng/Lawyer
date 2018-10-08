//
//  LawTPackageCell.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/20.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawTPackageCell.h"

@implementation LawTPackageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(LawMyTicketModel *)model{
    _model = model;
    self.TopTypeLB.text = model.type_name;
    self.NameLB.text = model.user_name;
    self.PriceLB.text= [NSString stringWithFormat:@"￥%@", model.money];
    self.TimeLB.text = [NSString timeWithTimeIntervalString:model.time];
    
    if([model.status isEqualToString:@"1"]){
//self.ticket_backImage.image= [UIImage imageNamed:@"ticket"];
    self.DUihuanBtn.selected = YES ;
        self.ticket_backImage.image= [UIImage imageNamed:@"tickets_bg_grey"];

    }else{
        self.DUihuanBtn.selected = NO ;
        self.ticket_backImage.image= [UIImage imageNamed:@"tickets_bg"];
        
    }
//    if([model.type isEqualToString:@"1"]){
//        self.TypeImage.image = [UIImage imageNamed:@""];
//    }else  if([model.type isEqualToString:@"2"]){
//        self.TypeImage.image = [UIImage imageNamed:@""];
//    }else  if([model.type isEqualToString:@"3"]){
//        self.TypeImage.image = [UIImage imageNamed:@""];
//    }else  if([model.type isEqualToString:@"4"]){
//        self.TypeImage.image = [UIImage imageNamed:@""];
//    }else  if([model.type isEqualToString:@"5"]){
//        self.TypeImage.image = [UIImage imageNamed:@""];
//    }
//    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

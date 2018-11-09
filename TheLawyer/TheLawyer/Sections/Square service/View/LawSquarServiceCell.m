//
//  LawSquarServiceCell.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/17.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawSquarServiceCell.h"

@implementation LawSquarServiceCell

- (void)awakeFromNib {
    [Utile makeCorner:self.PersonImage.height/2 view:self.PersonImage];
    [self.CateBodthView createBordersWithColor:[UIColor colorWithHex:0x4483F6] withCornerRadius:5 andWidth:1];
    [super awakeFromNib];
    // Initialization code
}
-(void)setModle:(LawSquaremodel *)modle{
    _modle = modle;
    [self.PersonImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_URL,modle.avatar]] placeholderImage:[UIImage imageNamed:@"touxiang"]];
    
    self.PersonName.text = modle.name;
    self.AddressLB.text =[NSString stringWithFormat:@"%@·%@",modle.province,modle.city];
    self.TypeLB.text = modle.type_name;
    self.CateLB.text = [NSString stringWithFormat:@"%@",modle.cate_name];
    self.NumberPersonLB.text=  [NSString stringWithFormat:@"%@人竞标",modle.lawyer_num];
    self.ConcentLB.text = modle.content;
    self.TimeLB.text = [NSString timeWithTimeIntervalString:modle.create_time];
    if([modle.pay_type integerValue] == 3){
//       套餐支付
        self.PriceLB.text = [NSString stringWithFormat:@"平台统一价格:%@",modle.money];
        self.taocanImage.hidden = NO;
        self.RightLengh.constant = 60;
    }else{
        self.PriceLB.text = [NSString stringWithFormat:@"委托报价:%@",modle.user_money];
        self.taocanImage.hidden = YES;
        self.RightLengh.constant = 10;

    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

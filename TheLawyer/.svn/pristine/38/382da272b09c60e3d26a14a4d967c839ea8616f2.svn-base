//
//  QJCAppointCell.m
//  TheLawyer
//
//  Created by MYMAc on 2017/11/4.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import "QJCAppointCell.h"

@implementation QJCAppointCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [Utile makeCorner:25 view:self.HeaderImageView];

    [Utile makeCorner:4 view:self.AgreeBtn];
    [Utile makecorner:1 view:self.AgreeBtn color:THEMECOLOR];

    [Utile makeCorner:4 view:self.refuseBtn];
    [Utile makecorner:1 view:self.refuseBtn color:THEMECOLOR];
    // Initialization code
}
-(void)setModel:(QJCAppointModel *)model{
    _model= model;
    
    [self.HeaderImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_URL,model.avator]] placeholderImage:[UIImage imageNamed:@"头像"] completed:nil];
    self.NameLB.text = model.name;
    self.meetType.text =[NSString stringWithFormat:@"预约方式:【%@】",model.typeName];
    self.AddressLB.text = [NSString stringWithFormat:@"地址:%@",model.address];
    self.contactLB.text = [NSString stringWithFormat:@"预约电话:%@",model.phone];
    self.meetTimeLB.text =[NSString stringWithFormat:@"预约时间:%@",[NSString timeWithTimeIntervalString:model.meetTime]];
//    [Utile  makecorner:1 view:self.Paytype color:MainBlueColor];
    [Utile  makeCorner:4 view:self.Paytype];

    if ([model.pay_type isEqualToString:@"1"]) {
        self.Paytype.text =[NSString stringWithFormat:@"金钱支付"];

     }else{
         self.Paytype.text =[NSString stringWithFormat:@"套餐支付"];

    }
    if ([model.type isEqualToString:@"1"]) {
        self.meetAddressLB.text = @"";

    }else{
        self.meetAddressLB.text = [NSString stringWithFormat:@"预约地址:%@",model.meetAddress];
    }
    self.refuseBtn.hidden = YES;
    [self.refuseBtn setTitle:@"拒绝" forState:UIControlStateNormal];
    [self.refuseBtn setBackgroundColor:[UIColor whiteColor]];
    [self.refuseBtn setTitleColor:[UIColor colorWithHex:0x15679C] forState:UIControlStateNormal];

    if([_model.status isEqualToString:@"1"]){
        [self.AgreeBtn setTitle:@"同意" forState:UIControlStateNormal];
        self.AgreeWidth.constant = 61;
        [self.refuseBtn setTitle:@"拒绝" forState:UIControlStateNormal];
        [self.refuseBtn setBackgroundColor:[UIColor whiteColor]];

        self.refuseBtn.hidden = NO;
    }else if([_model.status isEqualToString:@"2"]){
        [self.AgreeBtn setTitle:@"已同意" forState:UIControlStateNormal];
        [self.refuseBtn setBackgroundColor:[UIColor colorWithHex:0x15679C]];
        [self.refuseBtn setTitle:@"完成" forState:UIControlStateNormal];

        [self.refuseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

        self.refuseBtn.hidden = NO;
        self.AgreeWidth.constant = 61;

        
    }else if([_model.status isEqualToString:@"3"]){
        self.AgreeWidth.constant = 61;
        [self.AgreeBtn setTitle:@"已拒绝" forState:UIControlStateNormal];
        self.refuseBtn.hidden = YES;

    }else if([_model.status isEqualToString:@"4"]){
        [self.AgreeBtn setTitle:@"等待评价" forState:UIControlStateNormal];
        self.AgreeWidth.constant = 100;
        self.refuseBtn.hidden = YES;

    }else if([_model.status isEqualToString:@"5"]){
        [self.AgreeBtn setTitle:@"服务完成" forState:UIControlStateNormal];
        self.AgreeWidth.constant = 100;
        self.refuseBtn.hidden = YES;


    }

}
-(void)setBlock:(Action)Block{
    _Block = [Block copy];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)agreeAction:(id)sender {
    if([_model.status isEqualToString:@"1"]){
        self.Block(@"2" ,_model.id);// 同意
     }
}

- (IBAction)refuseAction:(id)sender {
    if([_model.status isEqualToString:@"1"]){
     self.Block(@"3",_model.id);// 拒绝
    } else if([_model.status isEqualToString:@"2"]){
        self.Block(@"4",_model.id);// 完成

    }

}
@end

//
//  RecoudCell.m
//  TheLawyer
//
//  Created by yaoyao on 17/7/28.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import "RecoudCell.h"

@implementation RecoudCell



- (void)awakeFromNib {
    [super awakeFromNib];
    [Utile makeCorner:4 view:self.DetailLB];
    [Utile makeCorner:4 view:self.OverBtn];
    [Utile makecorner:1 view:self.DetailLB color:THEMECOLOR];
    // Initialization code
}
-(void)setModel:(RecordModel *)model
{
    self.OverBtn.hidden = YES;
    self.SNNumberLB.text =[NSString stringWithFormat:@"订单号:%@",model.orderSn];
    if ([model.lawyer_status isEqualToString:@"2"]) {
        self.statusLB.text =[NSString stringWithFormat:@"状态:等待处理"];
    }if ([model.lawyer_status isEqualToString:@"3"]) {
        if ([model.status isEqualToString:@"3"]) {// 显示完成按钮
            self.statusLB.text =[NSString stringWithFormat:@"状态:已聘用"];
            self.OverBtn.hidden = NO;

        }else if ([model.status isEqualToString:@"4"]) {
            self.statusLB.text =[NSString stringWithFormat:@"状态:待评价"];
        }else if ([model.status isEqualToString:@"5"]) {
            self.statusLB.text =[NSString stringWithFormat:@"状态:服务结束"];

        }

    }else if ([model.lawyer_status isEqualToString:@"4"]) {
        self.statusLB.text =[NSString stringWithFormat:@"状态:抢单失败"];

    }
    self.TimeLB.text =[NSString stringWithFormat:@"发布时间:%@",[NSString timeWithTimeIntervalString:model.time]];

    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setBlock:(OverBlock)Block{
    _Block = [Block copy];
}
- (IBAction)OverAction:(id)sender {
    _Block();
}
@end

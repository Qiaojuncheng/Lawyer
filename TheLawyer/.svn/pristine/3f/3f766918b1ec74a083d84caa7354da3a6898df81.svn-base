//
//  QJMessageCellCell.m
//  TheLawyer
//
//  Created by MYMAc on 2017/11/2.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import "QJMessageCellCell.h"

@implementation QJMessageCellCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [Utile makeCorner:6 view:self.TypeNameLB];
    // Initialization code
}
-(void)setModel:(MessageModel *)model{
    self.TypeNameLB.text = model.typeName;
    self.TimeLB.text =[NSString stringWithFormat:@"预约时间:%@",[self timeWithTimeIntervalString:model.meet_time]];
    self.FabuTimeLB.text =[NSString stringWithFormat:@"发布时间:%@",[self timeWithTimeIntervalString:model.time]];
    
    if ([model.type isEqualToString:@"2" ]) {
        self.TypeNameLB.backgroundColor = YelleColorTine;
         self.YuyueInfoLB.text = [NSString stringWithFormat:@"预约信息:%@",model.meet_info];

    }else if ([model.type  isEqualToString:@"1"]){
        self.TypeNameLB.backgroundColor = QingColor;
        self.YuyueInfoLB.text = [NSString stringWithFormat:@"当事人信息:%@",model.title];
        self.TimeLB.text =[NSString stringWithFormat:@"业务领域:%@",model.lingyu];
    }



    
}
- (NSString *)timeWithTimeIntervalString:(NSInteger)timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:timeString];//[timeString doubleValue]/ 1000.0
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

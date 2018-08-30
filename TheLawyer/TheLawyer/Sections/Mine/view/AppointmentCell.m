//
//  AppointmentCell.m
//  TheLawyer
//
//  Created by yaoyao on 17/7/29.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import "AppointmentCell.h"

@implementation AppointmentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.headerImg.layer.masksToBounds = YES;
    self.headerImg.layer.cornerRadius = 12.5;
    self.refusedBtn.layer.masksToBounds = YES;
    self.refusedBtn.layer.cornerRadius = 5;
    self.refusedBtn.layer.borderWidth = 0.5;
    self.refusedBtn.layer.borderColor = THEMECOLOR.CGColor;
    
    
    self.agreeBtn.layer.masksToBounds = YES;
    self.agreeBtn.layer.cornerRadius = 5;
    self.agreeBtn.layer.borderWidth = 0.5;
    self.agreeBtn.layer.borderColor = THEMECOLOR.CGColor;
    // Initialization code
}


-(void)setCommentsModel:(AppointmentModel *)commentsModel
{
    _commentsModel = commentsModel;
    
    [self.headerImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",commentsModel.headerImg]] placeholderImage:[UIImage imageNamed:@"tuceng"]];
    
    self.nameLable.text = [NSString stringWithFormat:@"%@",commentsModel.name];
    
    self.adressLable.text = [NSString stringWithFormat:@"地址：%@",commentsModel.address];
    
    self.typeL.text = [NSString stringWithFormat:@"预约方式：%ld",(long)commentsModel.type];
    NSString *str = [self timeWithTimeIntervalString:commentsModel.meetTime];

    self.timeLable.text = [NSString stringWithFormat:@"预约时间：%@",str];
    
    self.telLable.text = [NSString stringWithFormat:@"联系电话：%ld",(long)commentsModel.phone];
    
    self.yuyueAdressL.text = [NSString stringWithFormat:@"预约地点：%@",commentsModel.meetAddress];

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
/*
 
 -(void)deleteFansButtonClick:(UIButton*)btn
 {
 if (FansCancelBlock) {
 FansCancelBlock(self.fansModel.fansUserId);
 }
 }
 -(void)FansCancelBlock:(void (^)(NSInteger FansUserId))Block
 {
 FansCancelBlock =[Block copy];
 }
 
 
 */

- (IBAction)refuseBtnClick:(id)sender {
    if (refusedCancelBlock) {
        refusedCancelBlock();

    }

}
-(void)refusedCancelBlock:(void (^)())Block{
    refusedCancelBlock =  [Block copy];

}
-(void)agreeCancelBlock:(void (^)())Block{
    agreeCancelBlock = [Block copy];

}

- (IBAction)agreeBtnClick:(id)sender {
    
    if (agreeCancelBlock) {
        agreeCancelBlock();
    }
}
@end

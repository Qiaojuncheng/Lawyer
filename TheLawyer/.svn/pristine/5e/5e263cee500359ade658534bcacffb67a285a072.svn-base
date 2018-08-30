//
//  GrabCell.m
//  TheLawyer
//
//  Created by yaoyao on 17/7/28.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import "GrabCell.h"


@implementation GrabCell
-(void)setCommentsModel:(GrabModel *)commentsModel
{
    self.MainTitle.layer.cornerRadius = 6;
    self.MainTitle.layer.masksToBounds = YES;
    
    _commentsModel = commentsModel;
     self.MainTitle.text = [NSString stringWithFormat:@"%@",commentsModel.typeName];
    self.SubTitle.text = [NSString stringWithFormat:@"%@",commentsModel.typeName];
    if (commentsModel.type  ==  3) {
        self.MainTitle.backgroundColor =QingColor;
     }else if (commentsModel.type  ==  4){
        self.MainTitle.backgroundColor = YelleColorTine;
    }else if (commentsModel.type  ==  5){
        self.MainTitle.backgroundColor =BlueColor;
      }else if (commentsModel.type  ==  6){
        self.MainTitle.backgroundColor =YellColoreDeep;

     }

    NSString *str = [self timeWithTimeIntervalString:commentsModel.time];
    
    self.TimeLb.text = [NSString stringWithFormat:@"发布时间:%@",str];
 
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

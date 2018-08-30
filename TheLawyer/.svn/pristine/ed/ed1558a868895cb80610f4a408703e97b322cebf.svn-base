//
//  QJCAppointModel.m
//  TheLawyer
//
//  Created by MYMAc on 2017/11/4.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import "QJCAppointModel.h"

@implementation QJCAppointModel

-(void)MakeCellHeight{
    
    if ([self.type isEqualToString:@"2"]) {
         CGSize  sizes = CGSizeMake(SCREENWIDTH - 71, 1000);
        NSDictionary *attributess = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:17] forKey:NSFontAttributeName];
    CGRect rects = [[NSString stringWithFormat:@"预约地点:%@",self.meetAddress] boundingRectWithSize:sizes
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:attributess
                                             context:nil];
    _cellHeight = rects.size.height;
    
    }else{
         _cellHeight =  0;
    }
  }

@end

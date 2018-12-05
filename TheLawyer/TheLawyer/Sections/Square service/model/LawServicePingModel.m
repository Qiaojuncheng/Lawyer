//
//  LawServicePingModel.m
//  TheLawyer
//
//  Created by MYMAc on 2018/11/28.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawServicePingModel.h"

@implementation LawServicePingModel
-(void)MakeCellHeight{
    _cellHeight =[NSString GetHeightWithMaxSize:CGSizeMake(SCREENWIDTH  - 67, MAXFLOAT) AndFont:[UIFont systemFontOfSize:15] AndText:self.describe].height + 53;    
}
@end

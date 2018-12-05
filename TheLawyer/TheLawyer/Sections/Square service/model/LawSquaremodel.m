//
//  LawSquaremodel.m
//  TheLawyer
//
//  Created by MYMAc on 2018/10/9.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawSquaremodel.h"

@implementation LawSquaremodel

-(void)MakeCellHeight{
    _cellHeight =[NSString GetHeightWithMaxSize:CGSizeMake(SCREENWIDTH - 35, MAXFLOAT) AndFont:[UIFont systemFontOfSize:13] AndText:self.content].height +135;
}

@end

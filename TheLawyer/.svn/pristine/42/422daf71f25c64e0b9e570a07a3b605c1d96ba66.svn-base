//
//  BottomCell.m
//  JiuXiao
//
//  Created by 赵耀 on 16/9/5.
//  Copyright © 2016年 Ed. All rights reserved.
//

#import "BottomCell.h"

@implementation BottomCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self newView];
    }
    return self;
}

-(void)newView{
    self.contentView.backgroundColor =[UIColor whiteColor];
    _leftImage = [[UIImageView alloc] init];
    _leftImage.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_leftImage];

    
    _NameLabel=[[UILabel alloc]init];
    _NameLabel.font=[UIFont systemFontOfSize:15];//DefaultFont(self.scale);
    _NameLabel.backgroundColor=[UIColor clearColor];
    _NameLabel.text = @"我的jifen";
    [self.contentView addSubview:_NameLabel];

    _RigthImage=[[UIImageView alloc]init];
    
    [_RigthImage setImage:[UIImage imageNamed:@"箭头"]];
    [self.contentView addSubview:_RigthImage];
    
    _TopLine=[UIView new];
     _TopLine.backgroundColor = LINECOLOR;
    [self.contentView addSubview:_TopLine];
}
-(void)layoutSubviews{
    _leftImage.frame =CGRectMake(5, (44-18)/2, 18, 18);
    _TopLine.frame=CGRectMake(0, 0, SCREENWIDTH, 0.5);
    _NameLabel.frame=CGRectMake(_leftImage.right+5, 0, self.width/2, 44);
    _RigthImage.frame=CGRectMake(self.width-22, self.height/2-8, 10, 16);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

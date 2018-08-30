//
//  QJCSelectLingyuCell.m
//  TheLawyer
//
//  Created by MYMAc on 2017/11/7.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import "QJCSelectLingyuCell.h"

@implementation QJCSelectLingyuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)makeLabelDataArray:(NSArray *)NameArray{
    [self.BackScroller removeAllSubviews];
    NSLog(@"nameArray = %@",NameArray);
    self.BackScroller.bounces = NO; // 默认为YES。如果该属性为YES，视图滚动时可以越过边界，越过边界后会被弹回。

    CGFloat BackScrollerWidth =  0;
    for (int i  = 0 ; i < NameArray.count; i++) {
      BackScrollerWidth +=  [self getSizeWithStr:NameArray[i]].width + 10;
    }
    if (BackScrollerWidth  > self.BackScroller.width) {
 
    }else{
        BackScrollerWidth = SCREENWIDTH - 105;
        
    }
    self.BackScroller.contentSize = CGSizeMake(BackScrollerWidth, 0);

    NSLog(@"%lf,width = %f",BackScrollerWidth, SCREENWIDTH - 105);
    CGFloat NameLBLfet = BackScrollerWidth;

     for (int i  = 0 ; i < NameArray.count; i++) {
        UILabel * nameLB =[[UILabel alloc] initWithFrame:CGRectMake(NameLBLfet, 10, 30, 30 )];
        nameLB.width  =  [self getSizeWithStr:NameArray[i]].width;
        nameLB.text = NameArray[i];
        NameLBLfet =   NameLBLfet - nameLB.width -  10 ;
        nameLB.left = NameLBLfet ;
        nameLB.font = [UIFont systemFontOfSize:14];
      
         [self.BackScroller  addSubview:nameLB];

        UIButton * clearBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        clearBtn.frame = CGRectMake(nameLB.right - 5, nameLB.top - 5, 10, 10);
        [clearBtn setTitleColor:[UIColor colorWithHex:0x333333] forState:UIControlStateNormal];
        [clearBtn setImage:[UIImage imageNamed:@"Clears"] forState:UIControlStateNormal];
        clearBtn.tag = 55 + i;
        [clearBtn addTarget:self action:@selector(ClearBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.BackScroller  addSubview:clearBtn];

   
    }
}
-(void)setClearBlock:(Block)ClearBlock{
    _ClearBlock =[ClearBlock copy];
}
-(CGSize )getSizeWithStr:(NSString *)Str{
    CGSize size = CGSizeMake(10000, MAXFLOAT);//设置高度宽度的最大限度
    CGSize rect = [Str boundingRectWithSize:size options:NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size;
    return rect;
}
-(void)ClearBtn:(UIButton *)sender{
    self.ClearBlock(sender.tag - 55);
}
  

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

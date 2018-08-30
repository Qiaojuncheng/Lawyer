//
//  LawMessageCenterCell.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/16.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawMessageCenterCell.h"

@implementation LawMessageCenterCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [Utile makeCorner:self.RedView.width/2 view:self.RedView];
    // Initialization code
}
-(void)setModel:(LawMessageModel *)model{
    _model = model;
    
    if ([_model.showRed isEqualToString:@"1"]) {
        self.RedView.hidden = NO;
    }else{
        self.RedView.hidden = YES;

    }
    if ([_model.showBtn isEqualToString:@"1"]) {
        self.SeeBtn.hidden =  NO;
    }else{
        self.SeeBtn.hidden = YES;
    }
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)SeeBtnAction:(id)sender {
}
@end

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
    self.SeeBtn.userInteractionEnabled = NO ;
    // Initialization code
}
-(void)setModel:(LawNewMessageMM *)model{
    _model = model;
//
    if ([_model.status isEqualToString:@"0"]) {
        self.RedView.hidden = NO;
    }else{
        self.RedView.hidden = YES;

    }
    self.TimeLB.text =[NSString timeWithTimeIntervalString:model.time];
    self.ConcentLB.text = model.title;
    if([model.type isEqualToString:@"1"]){
        self.MeeageImage.image =[UIImage imageNamed:@"news_telephone"];
    }else if([model.type isEqualToString:@"2"]){
        self.MeeageImage.image =[UIImage imageNamed:@"news_examination"];
    }else if([model.type isEqualToString:@"3"]){
        self.MeeageImage.image =[UIImage imageNamed:@"news_consult"];
    }else if([model.type isEqualToString:@"4"]){
        self.MeeageImage.image =[UIImage imageNamed:@"news_write"];
    }else if([model.type isEqualToString:@"5"]){
        self.MeeageImage.image =[UIImage imageNamed:@"news_heart"];
    }else if([model.type isEqualToString:@"6"]){
        self.MeeageImage.image =[UIImage imageNamed:@"news_authentication"];
    }else if([model.type isEqualToString:@"7"]){
        self.MeeageImage.image =[UIImage imageNamed:@"news_system"];
    }
    
//    self.UIImageView
//    if ([_model.showBtn isEqualToString:@"1"]) {
//        self.SeeBtn.hidden =  NO;
//    }else{
//        self.SeeBtn.hidden = YES;
//    }
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)SeeBtnAction:(id)sender {
}
@end

//
//  LawMainConsultCell.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/15.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawMainConsultCell.h"

@implementation LawMainConsultCell

- (void)awakeFromNib {
    [super awakeFromNib];
//    self.answBtn.enabled = NO ;
    [Utile makeCorner:self.RedView.width/2 view:self.RedView];
    [Utile makeCorner:self.PersonImage.width/2 view:self.PersonImage];
    [Utile makeCorner:13 view:self.answBtn];

    // Initialization code
}
-(void)setModel:(LawMainConsultCellMoldel *)model{
    _model = model;
    
    [self.PersonImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",Image_URL,_model.avatar]] placeholderImage:[UIImage imageNamed:@"touxiang"]]; 
    self.PersonName.text = _model.name;
    self.PersonTypeLB.text = _model.cate_name;
    self.ConcentLB.text = _model.content;
    if ([_model.status isEqualToString:@"1"]) {
        self.adopt.hidden = YES;
    }else{
        self.adopt.hidden = NO;
    }
    
    self.PriceLB.text = [NSString stringWithFormat:@"￥%@",_model.money];
    if([_model.type isEqualToString:@"1"]){
        self.PriceLB.hidden = NO;
    }else{
        self.PriceLB.hidden = YES;
        
    }
    
    self.AdressLB.text =[NSString stringWithFormat:@"%@·%@",_model.province,_model.city];
    self.TimeLB.text = [NSString stringWithFormat:@"%@·%@人回答",_model.create_time,_model.reply_count];
    self.answBtn.hidden = YES ;
    
    if ([_model.answered isEqualToString:@"0" ]) {
        self.answBtn.hidden = NO ;

        self.answBtn.selected  = YES;// = @"未回答";
        self.answBtn.userInteractionEnabled  =NO ;
    }else if ([_model.answered isEqualToString:@"1" ]) {
        self.answBtn.hidden = NO ;
        //      已回答 或者已采纳的时候显示
        self.answBtn.selected = NO;// = @"已回答";
        self.answBtn.userInteractionEnabled  =NO ;
    }else  {
        self.answBtn.hidden = YES ;
    }
    if([model.is_read isEqualToString:@"1"]){
        self.RedView.hidden = NO  ;
    }else{
        self.RedView.hidden = YES  ;
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)AnswerBtnAction:(UIButton *)sender {
}
@end

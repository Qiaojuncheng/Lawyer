//
//  LawMeetingCell.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/18.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawMeetingCell.h"

@implementation LawMeetingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [Utile makeCorner:5 view:self.AgreeBtn];
    [Utile makeCorner:self.PersonImage.height/2 view:self.PersonImage];

    [self.OverBtn createBordersWithColor:[UIColor colorWithHex:0x4483F6] withCornerRadius:5 andWidth:1];

    [self.RefuseBtn createBordersWithColor:[UIColor colorWithHex:0x4483F6] withCornerRadius:5 andWidth:1];
    [Utile makeCorner:self.RedView.height/2 view:self.RedView];
    // Initialization code
}
-(void)setModel:(LawMessageModel *)model{
     _model = model;
    self.RedView.hidden = YES;
    self.timeLB.text=[NSString timeWithTimeIntervalString: model.create_time];
    self.TypeLb.text =model.cate_name ;
    [self.PersonImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_URL,model.avatar]] placeholderImage:nil];
    self.PersonImaeg.text = model.name;
    self.MeetTimeL.text= [NSString stringWithFormat:@"预约时间： %@",[NSString timeWithTimeIntervalString:model.meet_time]];
    self.PersonPhone.text = [NSString stringWithFormat:@"联系电话： %@ **** %@",[model.phone substringToIndex:3],[model.phone substringFromIndex:7]];;
//     支付方式
    if ([model.pay_type isEqualToString:@"3"]) {
        self.PriceBtn.hidden = NO ;
        self.priceLB.hidden = YES;
    }else{
        self.PriceBtn.hidden = YES ;
        self.priceLB.hidden = NO;
        self.priceLB.text = model.money;
    }
    
/*
 
 1. 付款成功 （拒绝/同意）
 2  已同意 服务中...
 3  已拒绝
 4  律师结束
 5  用户结束
*/
    self.TelBtn.selected = YES ;
    self.TelBtn.userInteractionEnabled = YES;
    
    self.RedView.hidden= YES;
    self.meetTypeLb.hidden= YES;
    self.RefuseBtn.hidden = YES;
    self.AgreeBtn.hidden = YES ;
    self.OverBtn.hidden = YES;
    self.ShowStatusLB.hidden = YES;
    if([model.status isEqualToString:@"1"]){
       self.RedView.hidden= NO ;
        self.RefuseBtn.hidden = NO;
        self.AgreeBtn.hidden = NO ;
        self.TelBtn.selected = NO ;
        self.TelBtn.userInteractionEnabled = NO;
     }else if([model.status isEqualToString:@"2"]){
         self.meetTypeLb.text = @"已同意 服务中...";
         self.meetTypeLb.hidden = NO;
         self.OverBtn.hidden = NO;

      }else if([model.status isEqualToString:@"3"]){
          self.ShowStatusLB.hidden = NO;
          self.ShowStatusLB.text= @"已拒绝";
          self.TelBtn.selected = NO ;
          self.TelBtn.userInteractionEnabled = NO;
    }else if([model.status isEqualToString:@"4"]){
        self.meetTypeLb.text = @"服务结束";
        self.meetTypeLb.hidden = NO;
    }else if([model.status isEqualToString:@"5"]){
        self.meetTypeLb.text = @"已完成";
        self.meetTypeLb.hidden = NO;
    }
    
    
  
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)btnAction:(UIButton *)sender {
//     30 拒绝 31 同意   32 完成
    
    if(self.ChangeStatusBlock){
        
        self.ChangeStatusBlock(sender.tag,_model.id);
    }
}
- (IBAction)telAction:(UIButton *)sender {
   
    
    if (sender.selected) {
        NSMutableString * string = [[NSMutableString alloc] initWithFormat:@"tel:%@",_model.phone];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:string]]];
        [self.contentView addSubview:callWebview];
    }

}

@end

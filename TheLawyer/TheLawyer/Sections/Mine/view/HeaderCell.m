//
//  HeaderCell.m
//  TheLawyer
//
//  Created by MYMAc on 2017/11/3.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import "HeaderCell.h"

@implementation HeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    NSUserDefaults *   UserDefaults  =[NSUserDefaults standardUserDefaults];
    [Utile makeCorner:8 view:self.ZixunTIshi];
    [Utile makeCorner:8 view:self.YuyueTishi];
    [Utile makeCorner:8 view:self.LieBiaoTishi];
    if ([[UserDefaults objectForKey:@"MyCounsment"] isEqualToString:@"yes"]) {
        self.ZixunTIshi.hidden = NO;
    }else{
        self.ZixunTIshi.hidden = YES;
     }
    if ([[UserDefaults objectForKey:@"MyAppoinment"] isEqualToString:@"yes"]) {
        self.YuyueTishi.hidden = NO;
     }else{
        self.YuyueTishi.hidden = YES;
    }
    if ([[UserDefaults objectForKey:@"MyService"] isEqualToString:@"yes"]) {
        self.LieBiaoTishi.hidden=  NO;
    }else{
        self.LieBiaoTishi.hidden=  YES;

    }


    
    
    
    [Utile makeCorner:5 view:self.indentificationLB];
    [Utile makeCorner:5 view:self.TiXianLB];
    [Utile makeCorner:30 view:self.HeaderVIew];
    [Utile makeCorner:5 view:self.TiXianLB];
    [Utile makecorner:1 view:self.TiXianLB color:THEMECOLOR];
    // Initialization code
}
-(void)setInfoModel:(MyInfoModel *)infoModel{
    
    [self.HeaderVIew sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_URL,infoModel.avatar]] placeholderImage:[UIImage imageNamed:@"logo"]];
    self.LawyerName.text = [NSString changeNullString:infoModel.name];
    self.YuELb.text = [NSString stringWithFormat:@"账户余额:%@元",[NSString changeNullString:infoModel.money]];
    if ([infoModel.is_show isEqualToString:@"1"]) {
        self.indentificationLB.text = @"已认证";
    }else{
        self.indentificationLB.text = @"未认证";
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

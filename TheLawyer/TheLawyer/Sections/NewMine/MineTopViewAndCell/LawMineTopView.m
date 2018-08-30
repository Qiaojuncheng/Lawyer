//
//  LawMineTopView.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/11.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawMineTopView.h"

@implementation LawMineTopView
-(void)setInfoModel:(MyInfoModel *)infoModel{
    _infoModel = infoModel;
    [Utile makeCorner:5 view:self.EditBtn ];
    [self.certifi createBordersWithColor:[UIColor colorWithHex:0x888888] withCornerRadius:self.certifi.height/2 andWidth:1];
    [Utile makeCorner:self.HeaderImage.height/2 view:self.HeaderImage];
    self.PhoneLb.text =[NSString stringWithFormat:@"%@律师",_infoModel.name];
    if([NSString changeNullString:_infoModel.name].length == 0){
        self.PhoneLb.text =[NSString stringWithFormat:@"- - -"];
    }
    self.certifi.text = [_infoModel.identification  isEqualToString:@"0"]?@"未认证":@"已认证";
    
    [self.certifi sizeToFit];
    self.CertifiCon.constant = self.certifi.width + 20;
    [self.HeaderImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_URL,_infoModel.avatar]] placeholderImage:[UIImage imageNamed:@"头像.png"]];
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)BtnAction:(UIButton *)sender {
//     41 编辑 42 余额  43  券 44 爱心
    if(self.TouchBtnBlock){
        self.TouchBtnBlock(sender.tag);
    }
}
@end

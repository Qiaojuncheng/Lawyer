//
//  ConsultingCell.m
//  TheLawyer
//
//  Created by yaoyao on 17/7/29.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import "ConsultingCell.h"

@implementation ConsultingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.headerImg.layer.masksToBounds = YES;
    self.headerImg.layer.cornerRadius = 25;
    [Utile makeCorner:4 view:self.replyButton];
    [Utile makecorner:1 view:self.replyButton color:THEMECOLOR];
    // Initialization code
}


-(void)setCommentsModel:(ConsultingModel *)commentsModel
{
    _commentsModel = commentsModel;
    
    [self.headerImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_URL,commentsModel.avatar]] placeholderImage:[UIImage imageNamed:@"头像"]];
    self.titleLable.text = [NSString stringWithFormat:@"%@",commentsModel.name];
    self.TitileLable.text = [NSString stringWithFormat:@"当事人信息:%@",commentsModel.title];
    self.TimeLB.text =[NSString timeWithTimeIntervalString:commentsModel.create_time];
    self.TypeLB.text = commentsModel.category_name;
     self.contentLable.text = [NSString stringWithFormat:@"%@",commentsModel.content];
    
    if([commentsModel.flag isEqualToString:@"1"]){
         [self.replyButton setTitle:@"已回复" forState:UIControlStateNormal];
    }else{
        [self.replyButton setTitle:@"未回复" forState:UIControlStateNormal];
        
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

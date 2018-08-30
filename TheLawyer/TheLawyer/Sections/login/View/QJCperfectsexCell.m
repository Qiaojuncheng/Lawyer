//
//  QJCperfectsexCell.m
//  TheLawyer
//
//  Created by MYMAc on 2017/11/8.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import "QJCperfectsexCell.h"

@implementation QJCperfectsexCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setSelectBlock:(SexBlock)SelectBlock{
    _SelectBlock = [SelectBlock copy];
    
    
}

- (IBAction)womanAction:(id)sender {
    self.womanBtn.selected = YES;
    self.manBtn.selected = NO;
    _SelectBlock(1);
 }

- (IBAction)manAction:(id)sender {
    self.womanBtn.selected = NO;
    self.manBtn.selected = YES;
    _SelectBlock(1);

}
@end

//
//  LawplatformEditCell.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/23.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawplatformEditCell.h"

@implementation LawplatformEditCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.PriceTextField.delegate = self ;
     // Initialization code
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.textFieldBlock) {
        self.textFieldBlock(textField.text);
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

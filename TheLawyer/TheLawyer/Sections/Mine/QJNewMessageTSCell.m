//
//  QJNewMessageTSCell.m
//  Lawyer
//
//  Created by MYMAc on 2017/10/25.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJNewMessageTSCell.h"

@implementation QJNewMessageTSCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

 
- (IBAction)SwitchAction:(UISwitch *)sender {
    if (sender.on) {
        self.SwitchBlock(YES);
        NSLog(@"OPen");
    }else{
        self.SwitchBlock(NO);

        NSLog(@"Close");

        
    }
    
    
}
@end

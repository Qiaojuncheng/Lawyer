//
//  LawBankCardCell.h
//  TheLawyer
//
//  Created by MYMAc on 2018/8/24.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LawBankCardCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *CardImage;
@property (weak, nonatomic) IBOutlet UILabel *CardTitle;

@property (weak, nonatomic) IBOutlet UILabel *CareType;

@property (weak, nonatomic) IBOutlet UILabel *CardNumber;






@end

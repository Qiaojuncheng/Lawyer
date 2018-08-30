//
//  LawIntroducionCell.h
//  TheLawyer
//
//  Created by MYMAc on 2018/8/22.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LawIntroducionCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *ConcentLB;
@property (weak, nonatomic) IBOutlet UIImageView *LeftImaeg;
@property (weak, nonatomic) IBOutlet UIImageView *RightImage;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ImageHeight;



@end

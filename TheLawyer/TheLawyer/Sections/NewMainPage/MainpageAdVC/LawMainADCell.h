//
//  LawMainADCell.h
//  TheLawyer
//
//  Created by MYMAc on 2018/8/15.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LawLawMainAdModel.h"
@interface LawMainADCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *PersinImage;
@property (weak, nonatomic) IBOutlet UILabel *PersonName;
@property (weak, nonatomic) IBOutlet UILabel *TimeLB;
@property (weak, nonatomic) IBOutlet UILabel *PricrLB;
@property (weak, nonatomic) IBOutlet UILabel *ConcentLB;
@property (strong,nonatomic) LawLawMainAdModel * admodel;






@end

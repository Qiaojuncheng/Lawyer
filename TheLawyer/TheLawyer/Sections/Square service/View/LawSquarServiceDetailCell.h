//
//  LawSquarServiceDetailCell.h
//  TheLawyer
//
//  Created by MYMAc on 2018/8/17.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LawServicePingModel.h"
@interface LawSquarServiceDetailCell : UITableViewCell
@property (strong , nonatomic) LawServicePingModel * model ;

@property (weak, nonatomic) IBOutlet UIImageView *HeaderImageView;
@property (weak, nonatomic) IBOutlet UILabel *PersonName;
@property (weak, nonatomic) IBOutlet UILabel *TimeLB;
@property (weak, nonatomic) IBOutlet UILabel *DesLB;







@end

//
//  LawTPackageCell.h
//  TheLawyer
//
//  Created by MYMAc on 2018/8/20.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LawMyTicketModel.h"
@interface LawTPackageCell : UITableViewCell
@property (strong, nonatomic) LawMyTicketModel * model;
@property (weak, nonatomic) IBOutlet UILabel *TopTypeLB;
@property (weak, nonatomic) IBOutlet UILabel *NameLB;
@property (weak, nonatomic) IBOutlet UILabel *TimeLB;

@property (weak, nonatomic) IBOutlet UILabel *PriceLB;

@property (weak, nonatomic) IBOutlet UIImageView *ticket_backImage;
@property (weak, nonatomic) IBOutlet UIImageView *TypeImage;

@property (weak, nonatomic) IBOutlet UIButton *DUihuanBtn;





@end

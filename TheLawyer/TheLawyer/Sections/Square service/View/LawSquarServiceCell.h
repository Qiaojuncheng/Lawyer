//
//  LawSquarServiceCell.h
//  TheLawyer
//
//  Created by MYMAc on 2018/8/17.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LawSquaremodel.h"
@interface LawSquarServiceCell : UITableViewCell

@property (strong , nonatomic) LawSquaremodel * modle ;


@property (weak, nonatomic) IBOutlet UIImageView *PersonImage;
@property (weak, nonatomic) IBOutlet UILabel *PersonName;
@property (weak, nonatomic) IBOutlet UILabel *AddressLB;

@property (weak, nonatomic) IBOutlet UILabel *TypeLB;

@property (weak, nonatomic) IBOutlet UILabel *CateLB;
@property (weak, nonatomic) IBOutlet UIView *CateBodthView;

@property (weak, nonatomic) IBOutlet UILabel *ConcentLB;
@property (weak, nonatomic) IBOutlet UILabel *NumberPersonLB;

@property (weak, nonatomic) IBOutlet UILabel *TimeLB;


@property (weak, nonatomic) IBOutlet UIImageView *taocanImage;

@property (weak, nonatomic) IBOutlet UILabel *PriceLB;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *RightLengh;











@end

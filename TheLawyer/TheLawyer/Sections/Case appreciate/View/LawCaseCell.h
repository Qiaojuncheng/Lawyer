//
//  LawCaseCell.h
//  TheLawyer
//
//  Created by MYMAc on 2018/8/18.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LawCaseNewModel.h"
@interface LawCaseCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *CaseImage;

@property (weak, nonatomic) IBOutlet UILabel *CaseTitleLB;
@property (weak, nonatomic) IBOutlet UILabel *CaseTypeLB;

@property (weak, nonatomic) IBOutlet UILabel *TimeLb;


@property (weak, nonatomic) IBOutlet UILabel *NUmberLB;


@property (strong, nonatomic) LawCaseNewModel * model ;



@end

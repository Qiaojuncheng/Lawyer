//
//  LawheartCell.h
//  TheLawyer
//
//  Created by MYMAc on 2018/8/20.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LawNewHeaterModel.h"
@interface LawheartCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *PeronImage;

@property (weak, nonatomic) IBOutlet UILabel *PersonName;
@property (weak, nonatomic) IBOutlet UILabel *TimeLb;

@property (weak, nonatomic) IBOutlet UILabel *PriceLB;

@property (strong , nonatomic )LawNewHeaterModel * model ;

@end

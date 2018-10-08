//
//  LawInfoCell.h
//  TheLawyer
//
//  Created by MYMAc on 2018/8/21.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LawInfoCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *TypeLB;

@property (weak, nonatomic) IBOutlet UIView *RedView;
@property (weak, nonatomic) IBOutlet UILabel *ConcentLB;
@property (weak, nonatomic) IBOutlet UIView *LineView;

@property (weak, nonatomic) IBOutlet UIImageView *RightImg;



@end

//
//  LawMeetingCell.h
//  TheLawyer
//
//  Created by MYMAc on 2018/8/18.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LawMeetingCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *timeLB;
@property (weak, nonatomic) IBOutlet UILabel *TypeLb;

@property (weak, nonatomic) IBOutlet UIImageView *PersonImage;

@property (weak, nonatomic) IBOutlet UILabel *PersonImaeg;

@property (weak, nonatomic) IBOutlet UIButton *PriceBtn;

@property (weak, nonatomic) IBOutlet UILabel *MeetTimeL;




@property (weak, nonatomic) IBOutlet UILabel *meetTypeLb;
@property (weak, nonatomic) IBOutlet UILabel *PersonPhone;


@property (weak, nonatomic) IBOutlet UIButton *RefuseBtn;

@property (weak, nonatomic) IBOutlet UIButton *AgreeBtn;


@end

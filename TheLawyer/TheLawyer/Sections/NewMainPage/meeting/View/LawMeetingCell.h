//
//  LawMeetingCell.h
//  TheLawyer
//
//  Created by MYMAc on 2018/8/18.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LawMessageModel.h"
typedef void (^Block)(NSInteger index, NSString *meetid);
@interface LawMeetingCell : UITableViewCell

@property(copy, nonatomic) Block ChangeStatusBlock;
@property (weak, nonatomic) IBOutlet UILabel *timeLB;
@property (weak, nonatomic) IBOutlet UILabel *TypeLb;

@property (weak, nonatomic) IBOutlet UIImageView *PersonImage;

@property (weak, nonatomic) IBOutlet UILabel *PersonImaeg;

@property (weak, nonatomic) IBOutlet UIButton *PriceBtn;

@property (weak, nonatomic) IBOutlet UILabel *MeetTimeL;

@property (strong , nonatomic) LawMessageModel * model ;


@property (weak, nonatomic) IBOutlet UILabel *meetTypeLb;
@property (weak, nonatomic) IBOutlet UILabel *PersonPhone;


@property (weak, nonatomic) IBOutlet UIButton *RefuseBtn;

@property (weak, nonatomic) IBOutlet UIButton *AgreeBtn;

@property (weak, nonatomic) IBOutlet UIView *RedView;
@property (weak, nonatomic) IBOutlet UILabel *priceLB;

@property (weak, nonatomic) IBOutlet UILabel *ShowStatusLB;


@property (weak, nonatomic) IBOutlet UIButton *OverBtn;

- (IBAction)btnAction:(UIButton *)sender;


@property (weak, nonatomic) IBOutlet UIButton *TelBtn;

- (IBAction)telAction:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ConTainViewHeight;



@end

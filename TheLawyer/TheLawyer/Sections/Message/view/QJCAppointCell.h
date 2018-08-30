//
//  QJCAppointCell.h
//  TheLawyer
//
//  Created by MYMAc on 2017/11/4.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QJCAppointModel.h"
@interface QJCAppointCell : UITableViewCell
typedef  void(^Action)(NSString * type, NSString *id);
@property (weak, nonatomic) IBOutlet UIImageView *HeaderImageView;
@property (weak, nonatomic) IBOutlet UILabel *NameLB;

@property (weak, nonatomic) IBOutlet UILabel *AddressLB;
@property (weak, nonatomic) IBOutlet UILabel *meetType;
@property (weak, nonatomic) IBOutlet UILabel *meetTimeLB;

@property (weak, nonatomic) IBOutlet UILabel *contactLB;

@property (weak, nonatomic) IBOutlet UILabel *meetAddressLB;

@property (weak, nonatomic) IBOutlet UIButton *AgreeBtn;
@property (strong ,nonatomic) Action Block;

@property (weak, nonatomic) IBOutlet UIButton *refuseBtn;
@property (strong ,nonatomic) QJCAppointModel * model;
@property (weak, nonatomic) IBOutlet UILabel *PaytypeLb;
@property (weak, nonatomic) IBOutlet UILabel *Paytype;


- (IBAction)agreeAction:(id)sender;

- (IBAction)refuseAction:(id)sender;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *AgreeWidth;


@end

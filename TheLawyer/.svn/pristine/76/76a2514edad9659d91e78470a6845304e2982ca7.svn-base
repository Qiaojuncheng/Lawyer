//
//  AppointmentCell.h
//  TheLawyer
//
//  Created by yaoyao on 17/7/29.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppointmentModel.h"
@interface AppointmentCell : UITableViewCell
{
    void (^refusedCancelBlock)();
    void (^agreeCancelBlock)();
}
@property(nonatomic,strong) AppointmentModel *commentsModel;

@property (weak, nonatomic) IBOutlet UIImageView *headerImg;

@property (weak, nonatomic) IBOutlet UILabel *nameLable;

@property (weak, nonatomic) IBOutlet UILabel *adressLable;

@property (weak, nonatomic) IBOutlet UILabel *typeL;

@property (weak, nonatomic) IBOutlet UILabel *telLable;

@property (weak, nonatomic) IBOutlet UILabel *yuyueAdressL;

@property (weak, nonatomic) IBOutlet UIButton *refusedBtn;

@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;

@property (weak, nonatomic) IBOutlet UILabel *timeLable;
- (IBAction)refuseBtnClick:(id)sender;

- (IBAction)agreeBtnClick:(id)sender;
-(void)refusedCancelBlock:(void (^)())Block;
-(void)agreeCancelBlock:(void (^)())Block;
@end

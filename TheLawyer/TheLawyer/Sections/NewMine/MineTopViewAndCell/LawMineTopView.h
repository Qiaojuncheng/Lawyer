//
//  LawMineTopView.h
//  TheLawyer
//
//  Created by MYMAc on 2018/8/11.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyInfoModel.h"
typedef void (^BtnTouchActionBlock)(NSInteger index);
@interface LawMineTopView : UIView
@property(nonatomic,strong) MyInfoModel *infoModel;

@property (weak, nonatomic) IBOutlet UILabel *PhoneLb;

@property (weak, nonatomic) IBOutlet UILabel *certifi;
@property (weak, nonatomic) IBOutlet UIImageView *HeaderImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *CertifiCon;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *LeftConcent;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *TopConcent;


@property (weak, nonatomic) IBOutlet UIButton *EditBtn;
@property (copy, nonatomic) BtnTouchActionBlock TouchBtnBlock;
- (IBAction)BtnAction:(UIButton *)sender;






@end

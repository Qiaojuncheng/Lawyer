//
//  MessageDetailController.h
//  TheLawyer
//
//  Created by MYMAc on 2017/11/4.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import "BaseViewController.h"
#import "QJCMEssageDetailModel.h"
@interface MessageDetailController : BaseViewController
typedef void (^Block)( );
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *BackViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ConcentHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *RepyViewHeight;

@property (weak, nonatomic) IBOutlet UIImageView *HeaderImageView;
@property (weak, nonatomic) IBOutlet UILabel *AskNameLB;
@property (weak, nonatomic) IBOutlet UILabel *ConsultType;

@property (weak, nonatomic) IBOutlet UILabel *TimeLB;
@property (weak, nonatomic) IBOutlet UILabel *ConsultTitleLB;

@property (weak, nonatomic) IBOutlet UILabel *ConsultCOncentLB;

@property (weak, nonatomic) IBOutlet UILabel *RepyACtionLB;

@property (weak, nonatomic) IBOutlet UILabel *RepyNameLB;

@property (weak, nonatomic) IBOutlet UILabel *RepyConcentLB;

@property(strong , nonatomic) QJCMEssageDetailModel * detailModel;
@property (strong , nonatomic) NSString * zixunID;
@property (strong, nonatomic) Block  reloadDataBlock;

@end

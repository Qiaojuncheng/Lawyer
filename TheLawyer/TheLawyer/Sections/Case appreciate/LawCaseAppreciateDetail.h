//
//  LawCaseAppreciateDetail.h
//  TheLawyer
//
//  Created by MYMAc on 2018/8/18.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "BaseViewController.h"
#import "LawCaseNewModel.h"
typedef void (^changBlock) (NSString * iscollect);
@interface LawCaseAppreciateDetail : BaseViewController

 
@property (strong , nonatomic) LawCaseNewModel * model;
@property (copy , nonatomic) changBlock  ChangCollectStatus;

@end

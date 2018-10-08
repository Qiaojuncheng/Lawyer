//
//  LawPlatformAuthViewController.h
//  TheLawyer
//
//  Created by MYMAc on 2018/8/22.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "BaseViewController.h"
#import "LawPlatformModel.h"
@interface LawPlatformAuthViewController : BaseViewController
@property (strong , nonatomic) LawPlatformModel * model ;
@property (assign , nonatomic) BOOL  CanEidt ;// yes能修改  no 不能修改
@end

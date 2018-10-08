//
//  LawConsultDetailViewController.h
//  TheLawyer
//
//  Created by MYMAc on 2018/8/16.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "BaseViewController.h"
#import "LawMainConsultCellMoldel.h"
typedef void (^ReloadData)(void);
@interface LawConsultDetailViewController : BaseViewController

@property (strong , nonatomic) LawMainConsultCellMoldel *model;
@property (strong , nonatomic) NSString * type ;
@property (strong , nonatomic) NSString * mid ;
@property (strong , nonatomic) NSString * constultId ;

@property (copy  , nonatomic)   ReloadData reloadBlock;
@end

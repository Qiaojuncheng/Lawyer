//
//  LawSeletAreaViewController.h
//  TheLawyer
//
//  Created by MYMAc on 2018/8/23.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^selectBlock)(NSString * Proid,NSString * Cityid,NSString * Areamid, NSString *areaStr);

@interface LawSeletAreaViewController : BaseViewController

@property (copy, nonatomic) selectBlock SelectAreaBlock;

@property (strong , nonatomic) NSString * ProviStr;
@property (strong , nonatomic) NSString * CityStr;
@property (strong , nonatomic) NSString * AreaStr;


@end

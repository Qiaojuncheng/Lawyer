//
//  LawBankCardViewController.h
//  TheLawyer
//
//  Created by MYMAc on 2018/8/24.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "BaseViewController.h"
typedef void (^selectDic) (NSDictionary * BandDic);
@interface LawBankCardViewController : BaseViewController
@property (copy ,nonatomic) selectDic  selectBankCarDic;
@end

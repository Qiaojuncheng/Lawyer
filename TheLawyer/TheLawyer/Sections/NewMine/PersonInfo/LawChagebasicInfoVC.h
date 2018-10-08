//
//  LawChagebasicInfoVC.h
//  TheLawyer
//
//  Created by MYMAc on 2018/8/23.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "BaseViewController.h"
typedef void (^changeBlock)(NSString * changeValueStr);
@interface LawChagebasicInfoVC : BaseViewController

@property (strong , nonatomic) NSString * titleStr;
@property (strong , nonatomic) NSString * placherStr;

@property (copy, nonatomic) changeBlock ChangValue;

@property (weak, nonatomic) IBOutlet UITextField *ChangeTextField;




@end

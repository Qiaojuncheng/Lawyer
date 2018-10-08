//
//  LawCardSMSViewController.h
//  TheLawyer
//
//  Created by MYMAc on 2018/8/28.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "BaseViewController.h"
#import "CountButton.h"
@interface LawCardSMSViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UILabel *ConcentLB;
@property (weak, nonatomic) IBOutlet UITextField *CardTextField;

@property (copy,nonatomic) NSString * phoneNumber;
@property (copy,nonatomic) NSString * CardNumber;
@property (copy,nonatomic) NSString * idcard;
@property (copy,nonatomic) NSString * bankname;
@property (copy,nonatomic) NSString * name;


@property (weak, nonatomic) IBOutlet CountButton *GetCardBtn;

- (IBAction)GetCardBtn:(id)sender;

- (IBAction)notReviceBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *AddCarBtn;
- (IBAction)AddbtnAction:(id)sender;




@end

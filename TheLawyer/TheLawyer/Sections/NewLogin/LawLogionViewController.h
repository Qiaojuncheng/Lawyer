//
//  LawLogionViewController.h
//  TheLawyer
//
//  Created by MYMAc on 2018/9/7.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "BaseViewController.h"
#import "CountButton.h"
@interface LawLogionViewController : BaseViewController


@property (weak, nonatomic) IBOutlet UIImageView *iconImaeVeiw;

@property (weak, nonatomic) IBOutlet UITextField *PhoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *PassWorldTextField;

@property (weak, nonatomic) IBOutlet CountButton *CodeBtn;

@property (weak, nonatomic) IBOutlet UIButton *FirstBtn;

@property (weak, nonatomic) IBOutlet UIButton *SecondBtn;

@property (weak, nonatomic) IBOutlet UIButton *XieYiBtn;

- (IBAction)CodeAction:(id)sender;

- (IBAction)FirstBtn:(id)sender;

- (IBAction)SecondAction:(id)sender;

- (IBAction)XieBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *XieLb;


@property (weak, nonatomic) IBOutlet UILabel *PhoneLB;


@end

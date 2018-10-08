//
//  LawAddCardViewController.h
//  TheLawyer
//
//  Created by MYMAc on 2018/8/24.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "BaseViewController.h"

@interface LawAddCardViewController : BaseViewController


@property (weak, nonatomic) IBOutlet UITextField *CardNumberTextField;
@property (weak, nonatomic) IBOutlet UIImageView *Cardimage;
@property (weak, nonatomic) IBOutlet UILabel *CardName;



@property (weak, nonatomic) IBOutlet UIButton *NextBtn;

- (IBAction)NextBtnAction:(id)sender;


@end

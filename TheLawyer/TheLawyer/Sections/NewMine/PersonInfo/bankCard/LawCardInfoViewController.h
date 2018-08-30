//
//  LawCardInfoViewController.h
//  TheLawyer
//
//  Created by MYMAc on 2018/8/24.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "BaseViewController.h"

@interface LawCardInfoViewController : BaseViewController



@property (weak, nonatomic) IBOutlet UITextField *cardTExtFiled;

@property (weak, nonatomic) IBOutlet UITextField *numberTextfield;

@property (weak, nonatomic) IBOutlet UITextField *PhoneTextField;
@property (weak, nonatomic) IBOutlet UILabel *AgreemenLB;

@property (weak, nonatomic) IBOutlet UIButton *AgreeBtn;
@property (weak, nonatomic) IBOutlet UIImageView *whatImage;


- (IBAction)AgreeBtnACtion:(id)sender;




@end

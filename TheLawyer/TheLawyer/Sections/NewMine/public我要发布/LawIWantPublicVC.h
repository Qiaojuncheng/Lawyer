//
//  LawIWantPublicVC.h
//  TheLawyer
//
//  Created by MYMAc on 2018/9/30.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "BaseViewController.h"
#import "LPlaceholderTextView.h"
@interface LawIWantPublicVC : BaseViewController<UITextViewDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *TitleTextField;

@property (weak, nonatomic) IBOutlet UILabel *TypeLb;
@property (weak, nonatomic) IBOutlet LPlaceholderTextView *ContentTextView;

@property (weak, nonatomic) IBOutlet UIImageView *ImageView;

- (IBAction)PubAction:(UIButton *)sender;

 
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *TopHeight;


@end

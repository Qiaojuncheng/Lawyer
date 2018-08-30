//
//  LoginViewController.h
//  TheLawyer
//
//  Created by yaoyao on 17/8/3.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import "BaseViewController.h"
#import "MyInfoModel.h"

@interface LoginViewController : BaseViewController
{
    void (^loginSuccessBlock)(MyInfoModel *infModel);
}


@property (weak, nonatomic) IBOutlet UIView *CoreView;

@property (weak, nonatomic) IBOutlet UITextField *telTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;

- (IBAction)loginBtnClick:(id)sender;

- (IBAction)forgetPasswordBtnClick:(id)sender;

- (IBAction)reginBtnClick:(id)sender;
-(void)loginSuccessBlock:(void (^)(MyInfoModel *infModel))Block;


- (IBAction)QQlongin:(id)sender;

- (IBAction)WXLogin:(id)sender;



@end

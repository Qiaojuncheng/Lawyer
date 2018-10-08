//
//  LawChangInfoIntroductVC.m
//  TheLawyer
//
//  Created by MYMAc on 2018/9/19.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawChangInfoIntroductVC.h"

@interface LawChangInfoIntroductVC ()

@end

@implementation LawChangInfoIntroductVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCenterLabelWithTitle:@"简介" titleColor:nil];
    MJWeakSelf
    [self addRightButtonWithTitle:@"保存" titleColor:[UIColor colorWithHex:0x3181FE] actionBlock:^{
        [weakSelf SaveAction];
    }];
    self.PLpaceholdText.placeholderText= @"请输入您的简介";
    self.PLpaceholdText.text = self.instru;
    self.view.backgroundColor = BackViewColor;

    // Do any additional setup after loading the view from its nib.
}

-(void)SaveAction{
    
    //     先提交信息，在返回
    self.ChangValue(self.PLpaceholdText.text);
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

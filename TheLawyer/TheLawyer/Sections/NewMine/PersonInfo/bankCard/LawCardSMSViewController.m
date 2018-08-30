//
//  LawCardSMSViewController.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/28.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawCardSMSViewController.h"

@interface LawCardSMSViewController ()

@end

@implementation LawCardSMSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

- (IBAction)GetCardBtn:(id)sender {
     sender  = (CountButton *)sender ;
    [sender startTime];
}
/**/
- (IBAction)notReviceBtnAction:(id)sender {
    UIAlertController * alvc =[UIAlertController alertControllerWithTitle:@"收不到验证码？" message:@"1.请确认188****8888是否是中国建设 银行**1234尾号银行卡的预留手机号码 2.请检查短信是否被手机安全软件拦截" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * sureAction =  [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alvc addAction:sureAction];
    [self presentViewController:alvc animated:YES completion:nil];
    
}
@end

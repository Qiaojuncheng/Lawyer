//
//  LawChangeSexViewController.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/23.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawChangeSexViewController.h"

@interface LawChangeSexViewController (){

}

@end

@implementation LawChangeSexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCenterLabelWithTitle:@"设置性别" titleColor:nil];
    [self addRightButtonWithTitle:@"完成" titleColor:[UIColor colorWithHex:0x3181FE] actionBlock:^{
        
    }];
    if ( [self.sex isEqualToString:@"1"]) {
        self.manBtn.selected = YES;
        self.WomanBtn.selected = NO ;
    }else{
        
        self.manBtn.selected = NO ;
        self.WomanBtn.selected =YES ;
        
    }
    
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

- (IBAction)BtnSelect:(UIButton *)sender {
    
    self.manBtn.selected = NO;
    self.WomanBtn.selected = NO;
    sender.selected = YES;
    
//     先提交信息，在返回
    if (sender == self.manBtn) {
        self.SexBlock(@"1");
    }else{
        self.SexBlock(@"2");
        
    }
    [self.navigationController popViewControllerAnimated:YES];
}
@end

//
//  GrabSucessViewController.m
//  TheLawyer
//
//  Created by yaoyao on 17/7/30.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import "GrabSucessViewController.h"
#import "PGDatePicker.h"

@interface GrabSucessViewController ()<UITextFieldDelegate,PGDatePickerDelegate>
@property (nonatomic, strong) UIButton *okBt;

@end

@implementation GrabSucessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCenterLabelWithTitle:@"抢单信息" titleColor:[UIColor whiteColor]];
    self.PriceTextField.delegate = self;
    [self.view addSubview:self.okBt];
    [self.OverTimeLB whenTapped:^{
        [self makeTime];
    }];
    // Do any additional setup after loading the view from its nib.
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
  
    
    return  YES;
}
-(void)makeTime{
    
    PGDatePicker *datePicker = [[PGDatePicker alloc]init];
    datePicker.delegate = self;
    [datePicker show];
    datePicker.datePickerMode = PGDatePickerModeDate;
}

#pragma mark PGDatePickerDelegate
- (void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents {
    NSLog(@"dateComponents = %@", dateComponents);
    self.OverTimeLB.text = [NSString stringWithFormat:@"%ld/%ld/%ld",dateComponents.year,dateComponents.month,dateComponents.day];
 
}

// 提交按钮
- (UIButton *)okBt {
    if (!_okBt) {
        _okBt = [UIButton buttonWithType:UIButtonTypeCustom];
        _okBt.layer.masksToBounds = YES;
        _okBt.layer.cornerRadius = 5;
        _okBt.backgroundColor = THEMECOLOR;
        [_okBt setNormalTitle:@"抢单"];
        _okBt.frame = CGRectMake(75, SCREENHEIGHT-60, SCREENWIDTH-150, 40);
        [_okBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_okBt addClickTarget:self action:@selector(okClick:)];
    }
    return _okBt;
}
-(void)okClick:(UIButton * )Btn{
     NSLog(@"抢单");
    NSMutableDictionary * dic  =[[NSMutableDictionary alloc]init];
    QJCQIANGDAN
    NSMutableDictionary *   valueDic =[[NSMutableDictionary alloc]init];
    [valueDic setObject:UserId forKey:@"user_id"];
    [valueDic setObject:self.law_id forKey:@"law_id"];
    [valueDic setObject:self.type forKey:@"type"];
    
    [valueDic setObject:self.PriceTextField.text   forKey:@"money"];
    [valueDic setObject:self.OverTimeLB.text forKey:@"finish_time"];
 
    NSString * baseStr = [NSString getBase64StringWithArray:valueDic];
    [dic setValue:baseStr forKey:@"value"];
     [self showHudInView:self.view hint:nil];
    [HttpAfManager postWithUrlString:BASE_URL parameters:dic success:^(id data) {
        NSLog(@"%@",data);
         NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            [self showHint:data[@"msg"]];
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"UPGARAT" object:nil];

            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        [self hideHud];

    } failure:^(NSError *error) {
        [self hideHud];
        NSLog(@"%@",error);
    }];
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

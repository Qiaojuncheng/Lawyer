//
//  FeedbackViewController.m
//  TheLawyer
//
//  Created by yaoyao on 17/7/30.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import "FeedbackViewController.h"


@interface FeedbackViewController ()<UITextViewDelegate>
@property (nonatomic,strong) UILabel *holderLabel;
@property (nonatomic,strong) UITextView *textView;
//okBt
@property (nonatomic,strong) UIButton *okBt;
@end

@implementation FeedbackViewController
// 输入View
- (UITextView *)textView {
    if (!_textView) {
        _textView = [UITextView new];
        [_textView setFont:[UIFont systemFontOfSize:14]];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.layer.cornerRadius = 5;
        _textView.layer.masksToBounds = YES;
        _textView.delegate = self;
        
        //是否可以滚动
        _textView.scrollEnabled = NO;
        
        _textView.textColor = RGBMCOLOR(153);
    }
    return _textView;
}

// 提示文字
- (UILabel *)holderLabel {
    if (!_holderLabel) {
        NSString *text = @"留下您宝贵的意见，我们会努力改进";
        
//        CGSize size = [PublicMethod getContentSizeWithContent:text width:SCREENWIDTH - 50 font:[UIFont systemFontOfSize:14]];
        
//        _holderLabel = [[UILabel alloc] initWithFrame:CGRectMake(11, 11, SCREENWIDTH - 42, size.height)];
        _holderLabel = [[UILabel alloc] init];
        _holderLabel.text = text;
        [_holderLabel setNormalFont:14];
        _holderLabel.numberOfLines = 0;
        _holderLabel.textColor =RGBMCOLOR(153);
    }
    return _holderLabel;
}
// 提交按钮
- (UIButton *)okBt {
    if (!_okBt) {
        _okBt = [UIButton buttonWithType:UIButtonTypeCustom];
        _okBt.layer.masksToBounds = YES;
        _okBt.layer.cornerRadius = 5;
        _okBt.backgroundColor = [UIColor whiteColor];
        [_okBt setNormalTitle:@"提交"];
        [_okBt setTitleColor:DEEPTintColor forState:UIControlStateNormal];
        [_okBt addClickTarget:self action:@selector(okClick:)];
    }
    return _okBt;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCenterLabelWithTitle:@"意见反馈" titleColor:DEEPTintColor];
    [self.view addSubview:self.textView];
    [self.textView addSubview:self.holderLabel];
    [self.view addSubview:self.okBt];
    self.textView.frame  = CGRectMake(10, 15+NavStatusBarHeight, SCREENWIDTH-20, 160);
    self.holderLabel.frame=CGRectMake(11, 11, SCREENWIDTH-42, 15);
    self.okBt.frame = CGRectMake(10, SCREENHEIGHT-100, SCREENWIDTH-20, 40);
}


#pragma mark UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    // holder显隐
    if (textView.text.length > 0) {
        self.holderLabel.hidden = YES;
    } else {
        self.holderLabel.hidden = NO;
    }
}
// 完成按钮
- (void)okClick:(UIButton *)sender {
    //网络
    
    [self.textView resignFirstResponder];
    
    NSDictionary * dic  =[[NSMutableDictionary alloc]init];
    QJAddvicefeedback
    if( [UserId length] < 1){
        return ;
    }
    NSDictionary * valudic  = @{@"content":self.textView.text,@"id":UserId,@"type":@"2"};
    NSString * baseStr = [NSString getBase64StringWithArray:valudic];
    [dic setValue:baseStr forKey:@"value"];
    
    [self showHudInView:self.view hint:nil];
    
    
    [HttpAfManager postWithUrlString:BASE_URL parameters:dic success:^(id data) {
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            [self performAction];
        }else{
            
        }
        [self hideHud];
    } failure:^(NSError *error) {
        [self hideHud];
        NSLog(@"%@",error);
    }];
    


}
// 提交完成
-(void)performAction{
    
    UIAlertController * al =[UIAlertController  alertControllerWithTitle:@"提交成功" message:@"您的宝贵意见已经提交至后台，客服专员会对您的意见作出改进，谢谢！" preferredStyle:UIAlertControllerStyleAlert];
    
    [al addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }]];
    
    
    [self presentViewController:al animated:YES completion:nil];
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

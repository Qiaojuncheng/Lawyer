//
//  MidddleCell.m
//  JiuXiao
//
//  Created by 赵耀 on 16/9/5.
//  Copyright © 2016年 Ed. All rights reserved.
//

#import "MidddleCell.h"
#import "AppointmentViewController.h"//
#import "MyMessageViewController.h"//
#import "ConsultingViewController.h"//咨询
#import "LoginViewController.h"
#import "RegisteredViewController.h"

@implementation MidddleCell

- (UILabel *)middleLable {
    if (!_middleLable) {
        _middleLable = [[UILabel alloc] init];
        _middleLable.userInteractionEnabled = YES;
        _middleLable.backgroundColor = [UIColor clearColor];
        _middleLable.textAlignment = NSTextAlignmentCenter;
        _middleLable.font = [UIFont systemFontOfSize:12];
        _middleLable.text = @"我的咨询";
        _middleLable.textColor = [UIColor whiteColor];
    }
    return _middleLable;
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self newView];
    }
    return self;
}
-(void)newView{
    self.contentView.backgroundColor = [UIColor clearColor];
    UIView *BottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 60*self.scale)];
    BottomView.backgroundColor = RGBCOLOR(125, 126, 120);
    
    NSInteger num = 3;
    NSArray *lableArry  = @[@"我的咨询",@"我的预约",@"我的消息"];
    NSArray *imageArry = @[@"我的咨询",@"我的预约",@"我的消息"];
    //创建3个按钮
    for (int index = 0;index < lableArry.count;index++) {
        int n =  SCREENWIDTH /3;  //每个的宽度
        int x = (int)(index % 3) * n ;   //x
        int y = (int)(index / 3) * n ;      //y
        
        CGRect singleFrame = CGRectMake(x, y, n, 75);
        UIView *singleView = [[UIView alloc]initWithFrame:singleFrame];
        singleView.tag = 1 + index;
        
        CGRect imgFrame = CGRectMake(n / 2 - 23 / 2, 15, 23, 23);
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:imgFrame];//imgFrame
        imgView.userInteractionEnabled = YES;
        [imgView setImage:[UIImage imageNamed:imageArry[index]]];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showDetail:)];
        
        [singleView addGestureRecognizer:tap];//
        //文字UIlable
        CGRect labelFrame = CGRectMake(0,imgView.bottom+10,n,75-30-23-10);
        
        
        UILabel *lable = [[UILabel alloc] initWithFrame:labelFrame];
        lable.userInteractionEnabled = YES;
        lable.backgroundColor = [UIColor clearColor];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.font = [UIFont systemFontOfSize:12];
        lable.textColor = [UIColor whiteColor];
        lable.text = lableArry[index];
        
        
        [singleView addSubview:imgView];
        [singleView addSubview:lable];
        
        [BottomView addSubview:singleView];
    }
    [self.contentView addSubview:BottomView];
}
-(void)showDetail:(UIGestureRecognizer*)tap
{
    
    UIView*imageView = (UIView*)tap.view;
    
    switch (imageView.tag) {
        case 1:
        {
            WS(ws);
            ConsultingViewController *consult  = [[ConsultingViewController alloc] init];
            [ws.viewController.navigationController pushViewController:consult animated:YES];
//            [PublicMethod jumpLoginViewControllerBlock:^{
//                [ws.viewController.navigationController pushViewController:consult animated:YES];
//            }];
            
            
        }
            break;
        case 2:
        {
            WS(ws);
            AppointmentViewController *apit  = [[AppointmentViewController alloc] init];
            [ws.viewController.navigationController pushViewController:apit animated:YES];
//            [PublicMethod jumpLoginViewControllerBlock:^{
//                [ws.viewController.navigationController pushViewController:apit animated:YES];
//            }];
            
            
        }
            break;
        case 3:
        {
            WS(ws);
//            MyMessageViewController *myMessage = [[MyMessageViewController alloc] init];
//            [ws.viewController.navigationController pushViewController:myMessage animated:YES];
            
//            LoginViewController *loginVC = [[LoginViewController alloc] init];
//            [ws.viewController.navigationController pushViewController:loginVC animated:YES];
            
            
            
            
            MessageViewController *messageVC = [[MessageViewController alloc] init];
            [ws.viewController.navigationController pushViewController:messageVC animated:YES];
            
//            RegisteredViewController *regVC = [[RegisteredViewController alloc] init];
//            [ws.viewController.navigationController pushViewController:regVC animated:YES];
            
            
//            [PublicMethod jumpLoginViewControllerBlock:^{
//                [ws.viewController.navigationController pushViewController:myMessage animated:YES];
//            }];
        }
            break;
        default:
            break;
    }
}

-(void)ImageBlock:(void (^)())Block
{
    ImageBlock =[Block copy];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

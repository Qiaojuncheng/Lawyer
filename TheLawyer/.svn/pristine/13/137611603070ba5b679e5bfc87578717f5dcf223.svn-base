//
//  RecordViewController.m
//  TheLawyer
//
//  Created by yaoyao on 17/7/27.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import "RecordViewController.h"
#import "QJCSerViceVC.h"
@interface RecordViewController ()<UIScrollViewDelegate>{
    UIScrollView *segmentScrollView;//视图上部选项卡按钮
    NSArray      *segmentArray;
    UIView       *yellowView;//黄色小滑块儿
    UIButton     *signButton;//标记当前选中的按钮
    UIScrollView *bottomScrollView;
}

@end

@implementation RecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self makeBackItem];
   
    [self addCenterLabelWithTitle:@"我的服务" titleColor:[UIColor whiteColor]];
    [self creatView];
    // Do any additional setup after loading the view from its nib.
}
-(void)creatView{
    segmentArray = @[@"代写文书",@"案件委托",@"合同审查",@"发律师函"];
    segmentScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,NavStatusBarHeight, SCREENWIDTH, 40)];
    segmentScrollView.scrollEnabled  = NO;
    segmentScrollView.backgroundColor =  [UIColor whiteColor];
    segmentScrollView.showsHorizontalScrollIndicator = NO;
    segmentScrollView.contentSize = CGSizeMake((SCREENWIDTH/.0)*segmentArray.count, 46);
    [self.view addSubview:segmentScrollView];
    
    for (int i =0; i <segmentArray.count; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*(SCREENWIDTH/4.0), 0, SCREENWIDTH/4.0, segmentScrollView.height - 2);
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:segmentArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHex:0x333333] forState:UIControlStateNormal];
        [button setTitleColor:THEMECOLOR forState:UIControlStateSelected];
        button.tag = 10+i;
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button addTarget:self action:@selector(segmentButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [segmentScrollView addSubview:button];
        if (i == 0) {
            button.selected = YES;
            signButton = button;
        }
    }
    
    yellowView = [[UIView alloc]initWithFrame:CGRectMake(0, segmentScrollView.height -2, SCREENWIDTH/4.0, 2)];
    yellowView.backgroundColor = THEMECOLOR;
    [segmentScrollView addSubview:yellowView];
    
    bottomScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 42 + NavStatusBarHeight, SCREENWIDTH, SCREENHEIGHT- 42 - NavStatusBarHeight)];
    bottomScrollView.delegate = self;
    bottomScrollView.pagingEnabled = YES;
    bottomScrollView.contentSize = CGSizeMake(segmentArray.count*SCREENWIDTH, 0);
  [self.view addSubview:bottomScrollView];

    for (int i = 0; i <4 ; i ++) {
        QJCSerViceVC *view = [[QJCSerViceVC alloc]init];
        view.Type = [NSString stringWithFormat:@"%d",3+i];
        view.view.frame = CGRectMake(i *SCREENWIDTH, 0, SCREENWIDTH, bottomScrollView.height);
        [bottomScrollView addSubview:view.view];
        [self addChildViewController:view];
    }
    
 }

-(void)segmentButtonClick:(UIButton *)button{
    signButton.selected = NO;
    button.selected = YES;
    signButton = button;
    
    [UIView animateWithDuration:0.3 animations:^{
        //        if (button.tag > 12) {
        //            segmentScrollView.contentOffset = CGPointMake(ConentViewWidth/4.0, 0);
        //        }else
        //        {
        //            segmentScrollView.contentOffset = CGPointMake(0, 0);
        //        }
        bottomScrollView.contentOffset = CGPointMake((button.tag-10)*SCREENWIDTH, 0);
        yellowView.frame = CGRectMake(CGRectGetMinX(button.frame),segmentScrollView.height-2, SCREENWIDTH/4.0, 2);
    }];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView != bottomScrollView) {
        return;
    }
    NSInteger index = scrollView.contentOffset.x/SCREENWIDTH;
    UIButton *button = (UIButton *)[self.view viewWithTag:10+index];
    signButton.selected = NO;
    button.selected = YES;
    signButton = button;
    //    if (10+index > 12) {
    //        [UIView animateWithDuration:0.3 animations:^{
    //            segmentScrollView.contentOffset = CGPointMake(ConentViewWidth/4.0, 0);
    //
    //        }];
    //    }else{
    [UIView animateWithDuration:0.3 animations:^{
        segmentScrollView.contentOffset = CGPointMake(0, 0);
        
    }];
    //    }
    [UIView animateWithDuration:0.3 animations:^{
        yellowView.frame = CGRectMake(CGRectGetMinX(button.frame),segmentScrollView.height-2, SCREENWIDTH/4.0, 2);
    }];
}



@end

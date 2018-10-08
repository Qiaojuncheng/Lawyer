//
//  LawMianPageMessageCenter.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/16.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawMianPageMessageCenter.h"
#import "LawMianPageMessageList.h"
@interface LawMianPageMessageCenter ()<UIScrollViewDelegate>{
    
    UIScrollView * backScreeView;
    UIButton * selectBtn ;
    UIView * linview;
}

@end

@implementation LawMianPageMessageCenter

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =BackViewColor;
    [self addCenterLabelWithTitle:@"消息中心" titleColor:nil];
    [self addView ];
    // Do any additional setup after loading the view.
}
-(void)addView{
//    backScreeView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,NavStatusBarHeight +  48, SCREENWIDTH, SCREENHEIGHT  - NavStatusBarHeight- 48 )];
    backScreeView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,NavStatusBarHeight, SCREENWIDTH, SCREENHEIGHT  - NavStatusBarHeight )];

    backScreeView.pagingEnabled = YES;
//    backScreeView.contentSize = CGSizeMake(SCREENWIDTH * 2, backScreeView.height);
 
    
    linview  = [[UIView alloc]initWithFrame:CGRectMake(0,NavStatusBarHeight+ 46, 60, 2)];
    linview.hidden = YES;
    linview.backgroundColor = [UIColor colorWithHex:0x4483F6];
    [self.view addSubview:linview];
    
    [self.view addSubview:backScreeView];
    for (int i = 0; i< 1; i++) {
////        button
//        UIButton * ItemBtn =[UIButton buttonWithType:UIButtonTypeCustom];
//        ItemBtn.frame = CGRectMake(SCREENWIDTH/2 * i, NavStatusBarHeight, SCREENWIDTH/2, 46);
//        if (i== 0) {
//            [ItemBtn setTitle:@"订单服务提醒" forState:UIControlStateNormal];
//            selectBtn = ItemBtn;
//             linview.centerX= selectBtn.centerX;
//        }else{
//            [ItemBtn setTitle:@"系统消息" forState:UIControlStateNormal];
//            ItemBtn.titleLabel.font   = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
//
//        }
//        ItemBtn.tag = 20+i;
//        selectBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
//        [ItemBtn addTarget:self action:@selector(selectionAction:) forControlEvents:UIControlEventTouchUpInside];
//
//        [ItemBtn setTitleColor:ShallowTintColor forState:UIControlStateNormal];
//        [ItemBtn setTitleColor:ShallowTintColor forState:UIControlStateSelected];
//
//        [self.view addSubview:ItemBtn];
////        line
        
        LawMianPageMessageList * listView  =[[LawMianPageMessageList alloc]init];
         listView.view.frame = CGRectMake(SCREENWIDTH * i, 0, SCREENWIDTH, backScreeView.height);
        [ backScreeView addSubview:listView.view];
        [self addChildViewController:listView];
    }
    
}
-(void)selectionAction:(UIButton *)sender{
    selectBtn.titleLabel.font   = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    sender.titleLabel.font= [UIFont fontWithName:@"PingFangSC-Medium" size:16];
    selectBtn.selected = !selectBtn.selected;
    sender.selected = !sender.selected;
    selectBtn  = sender;
    [UIView animateWithDuration:0.3f animations:^{
        linview.centerX= selectBtn.centerX;
        
    }];

    if (sender.tag == 20) {
        backScreeView.contentOffset = CGPointMake(0, 0);
    }else{
        backScreeView.contentOffset = CGPointMake(SCREENWIDTH, 0);
    }
    
    
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

//
//  LawMainTopView.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/15.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawMainTopView.h"
#import "LawNewHeaterModel.h"
@implementation LawMainTopView 

-(void)makeDataWithScrollLBArray:(NSArray * )titleArray{
    
    [Utile makeCorner:self.ConsultRed.width/2 view:self.ConsultRed];
    [Utile makeCorner:self.ConsultRed.width/2 view:self.PhoneRed];
    [Utile makeCorner:self.ConsultRed.width/2 view:self.MeetRed];
    [Utile makeCorner:self.ConsultRed.width/2 view:self.serviceRed];
    
    NSUserDefaults * UserDefaults = [NSUserDefaults standardUserDefaults];
    
    self.ConsultRed.hidden =  [UserDefaults boolForKey:@"constultN"];
    self.PhoneRed.hidden =  [UserDefaults boolForKey:@"phoneN"];
    self.MeetRed.hidden =  [UserDefaults boolForKey:@"meetN"];
    self.serviceRed.hidden =  [UserDefaults boolForKey:@"servicN"];

 
    _scrollTextView.delegate            = self;
    _scrollTextView.textStayTime        = 2;
    _scrollTextView.scrollAnimationTime = 1;
    _scrollTextView.textColor           = [UIColor colorWithHex:0x2D7FFF];
    _scrollTextView.textFont            = [UIFont boldSystemFontOfSize:13.f];
    _scrollTextView.textAlignment       = NSTextAlignmentLeft;
    _scrollTextView.touchEnable         = YES;
    
    
    
    NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithString:@"这是最后一条数据："];
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
//    textAttachment.image = [UIImage imageNamed:@"icon"];
    textAttachment.bounds = CGRectMake(0, -4, 15, 15);
    NSAttributedString *attachmentAttrStr = [NSAttributedString attributedStringWithAttachment:textAttachment];
    [attrStr insertAttributedString:attachmentAttrStr atIndex:attrStr.length];
    NSMutableArray * titArray =[[NSMutableArray alloc]init];
    for (LawNewHeaterModel * model  in titleArray) {
        [titArray addObject:[NSString stringWithFormat:@"%@律师细心解答，收到心意%@元",model.lawyer_name,model.money]];
    }
    
    _scrollTextView.textDataArr =titArray;
    
    
    [_scrollTextView startScrollBottomToTopWithNoSpace];
}
- (void)scrollTextView2:(LMJScrollTextView2 *)scrollTextView clickIndex:(NSInteger)index content:(NSString *)content{
    if (self.adsselectBlock) {
        self.adsselectBlock(index);
    }
//    NSLog(@"#####点击的是：第%ld条信息 内容：%@",index,content);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)TopBtnACtion:(UIButton *)sender {
    
    if(self.ItemselectBlock){
        self.ItemselectBlock(sender.tag);
    }
}
@end

//
//  LawMainTopView.h
//  TheLawyer
//
//  Created by MYMAc on 2018/8/15.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMJScrollTextView2.h"
@interface LawMainTopView : UIView <LMJScrollTextView2Delegate>
typedef void (^selectAdsIndexBlock)(NSInteger index);
typedef void (^selectItemBlock)(NSInteger index);
@property (weak, nonatomic) IBOutlet LMJScrollTextView2 *scrollTextView;

@property (copy, nonatomic) selectAdsIndexBlock adsselectBlock;
@property (copy, nonatomic) selectItemBlock ItemselectBlock;

@property (weak, nonatomic) IBOutlet UIView *ConsultRed;

@property (weak, nonatomic) IBOutlet UIView *PhoneRed;

@property (weak, nonatomic) IBOutlet UIView *MeetRed;

@property (weak, nonatomic) IBOutlet UIView *serviceRed;







-(void)makeDataWithScrollLBArray:(NSArray * )titleArray;
- (IBAction)TopBtnACtion:(UIButton *)sender;

@end

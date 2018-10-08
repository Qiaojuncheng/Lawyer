//
//  LawChangeSexViewController.h
//  TheLawyer
//
//  Created by MYMAc on 2018/8/23.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "BaseViewController.h"
typedef void (^Blockacs)(NSString * sexStr);
@interface LawChangeSexViewController : BaseViewController
@property (strong, nonatomic) Blockacs SexBlock;
@property (weak, nonatomic) IBOutlet UIButton *manBtn;

@property (weak, nonatomic) IBOutlet UIButton *WomanBtn;
@property (copy, nonatomic) NSString * sex;

- (IBAction)BtnSelect:(UIButton *)sender;


@end

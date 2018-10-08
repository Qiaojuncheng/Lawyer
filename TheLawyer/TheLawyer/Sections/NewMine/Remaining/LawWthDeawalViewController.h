//
//  LawWthDeawalViewController.h
//  TheLawyer
//
//  Created by MYMAc on 2018/8/20.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "BaseViewController.h"

@interface LawWthDeawalViewController : BaseViewController
@property (strong , nonatomic )NSString * price ;
@property (strong , nonatomic )NSString * cardName ;


@property (weak, nonatomic) IBOutlet UILabel *PriceLB;

@property (weak, nonatomic) IBOutlet UILabel *CardNaem;


@property (weak, nonatomic) IBOutlet UIButton *SuccessBtn;

- (IBAction)SuccesssAction:(id)sender;


@end

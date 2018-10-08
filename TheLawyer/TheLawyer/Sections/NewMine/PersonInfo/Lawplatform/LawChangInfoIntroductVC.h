//
//  LawChangInfoIntroductVC.h
//  TheLawyer
//
//  Created by MYMAc on 2018/9/19.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "BaseViewController.h"
#import "LPlaceholderTextView.h"

typedef void (^changeBlock)(NSString * changeValueStr);

@interface LawChangInfoIntroductVC : BaseViewController
@property (weak, nonatomic) IBOutlet LPlaceholderTextView *PLpaceholdText;
@property (strong , nonatomic) NSString * instru;
@property (copy, nonatomic) changeBlock ChangValue;


@end

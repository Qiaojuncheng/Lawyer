//
//  LawSquarServiceFootView.h
//  TheLawyer
//
//  Created by MYMAc on 2018/8/17.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LPlaceholderTextView.h"
@interface LawSquarServiceFootView : UIView 

@property (weak, nonatomic) IBOutlet UILabel *TitileLB;

@property (weak, nonatomic) IBOutlet UIView *PriceView;

@property (weak, nonatomic) IBOutlet UITextField *PriceTextField;
@property (weak, nonatomic) IBOutlet LPlaceholderTextView *ContentTextView;

@property (copy , nonatomic) NSString *PriceStr;//无数据则输入，有则显示

@end

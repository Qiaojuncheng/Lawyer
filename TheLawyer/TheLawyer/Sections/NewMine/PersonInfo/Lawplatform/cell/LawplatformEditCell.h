//
//  LawplatformEditCell.h
//  TheLawyer
//
//  Created by MYMAc on 2018/8/23.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^moneyBlock) (NSString * money);
@interface LawplatformEditCell : UITableViewCell<UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UILabel *TitleLB;
@property (weak, nonatomic) IBOutlet UIView *LineView;

@property (weak, nonatomic) IBOutlet UITextField *PriceTextField;

@property (copy ,nonatomic) moneyBlock textFieldBlock;




@end

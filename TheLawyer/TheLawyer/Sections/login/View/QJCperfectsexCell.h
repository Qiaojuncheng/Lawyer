//
//  QJCperfectsexCell.h
//  TheLawyer
//
//  Created by MYMAc on 2017/11/8.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QJCperfectsexCell : UITableViewCell
typedef void (^SexBlock)(NSInteger SexIndex);//
@property (weak, nonatomic) IBOutlet UIButton *womanBtn;
@property (weak, nonatomic) IBOutlet UIButton *manBtn;
@property(strong , nonatomic) SexBlock SelectBlock;// 1 男 2 女
- (IBAction)womanAction:(id)sender;
- (IBAction)manAction:(id)sender;



@end

//
//  QJCSerViceVC.h
//  TheLawyer
//
//  Created by MYMAc on 2017/11/6.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import "BaseViewController.h"

@interface QJCSerViceVC : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    
    UITableView * _TV;
    NSMutableArray * DataArray;
}

@property(strong , nonatomic) NSString * Type;

@end

//
//  QJFAQViewController.h
//  Lawyer
//
//  Created by MYMAc on 2017/4/14.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "BaseViewController.h"

@interface QJFAQViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>{


    UITableView * _tv ;
    
    NSMutableArray * AccountArray;// 账户问题数组
    NSArray * UseingArray; // 使用账户数组
    NSArray * userJiFen ;  // 用纠纷数组


}

@end

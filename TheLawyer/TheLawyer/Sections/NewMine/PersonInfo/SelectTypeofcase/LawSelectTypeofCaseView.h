//
//  LawSelectTypeofCaseView.h
//  TheLawyer
//
//  Created by MYMAc on 2018/8/23.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LawSelectTypeofCaseView : UIView<UITableViewDelegate,UITableViewDataSource>{
   
    UITableView * _leftTv;
    UITableView * _rightTv;

    
    NSArray *leftDataArray;
    NSArray *rightDataArray;
    
     NSMutableArray * rightselectIDArray ;//根据id判断选中未选中
    
    
    NSInteger  leftselect;
    
    UIView * centerView;

}

@property (strong , nonatomic) NSMutableArray * dataArray;



@end

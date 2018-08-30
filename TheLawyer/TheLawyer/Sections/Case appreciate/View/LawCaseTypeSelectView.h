//
//  LawCaseTypeSelectView.h
//  TheLawyer
//
//  Created by MYMAc on 2018/8/18.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LawCaseTypeSelectView : UIView<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>{
    UITableView * _leftTv;
    UITableView * _rightTv;

    NSArray *leftDataArray;
    NSArray *rightDataArray;
    
    NSInteger  leftselect ;
    NSInteger rightselect ;

}
@property (copy , nonatomic) NSMutableArray * DataArray;
@property (assign , nonatomic) CGFloat TableViewHeight;
@end

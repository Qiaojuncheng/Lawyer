//
//  LawAppreSelectCaseTypeView.h
//  TheLawyer
//
//  Created by MYMAc on 2018/9/25.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LawConsultTypeModel.h"
typedef void(^selectBock)(LawConsultTypeModel * selectModel);

@interface LawAppreSelectCaseTypeView : UIView<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>{
    UITableView * _leftTv;
    UITableView * _rightTv;
    NSMutableArray *rightDataArray;
    
    NSInteger  leftselect ;
    NSInteger rightselect ;

}
@property (strong , nonatomic )NSMutableArray *DataArray;
@property (copy, nonatomic) selectBock  seleAreaBlock;
@property (assign , nonatomic) CGFloat TableViewHeight;

@property (strong , nonatomic )NSString  *LeftSelectID;
@property (strong , nonatomic )NSString *RightSelectID;

@end

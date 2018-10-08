//
//  LawCaseTypeSelectView.h
//  TheLawyer
//
//  Created by MYMAc on 2018/8/18.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^selectBock)(NSString * Proid,NSString * Cityid,NSString * Areamid, NSString *areaStr);
@interface LawCaseTypeSelectView : UIView<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>{
    UITableView * _leftTv;
    UITableView * _rightTv;
    UITableView * _thredtTv;

    NSMutableArray *leftDataArray;
    NSMutableArray *rightDataArray;
    NSMutableArray *thridDataArray;
    
    NSInteger  leftselect ;
    NSInteger rightselect ;
    NSInteger ThirdSelect;
}
@property (copy , nonatomic) NSMutableArray * DataArray;
@property (copy, nonatomic) selectBock  seleAreaBlock;
@property (assign , nonatomic) CGFloat TableViewHeight;
@property (strong , nonatomic) NSString * ProviStr;
@property (strong , nonatomic) NSString * CityStr;
@property (strong , nonatomic) NSString * AreaStr;
-(void)makeSubView;
@end

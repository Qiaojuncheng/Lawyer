//
//  QJCSelectView.h
//  TheLawyer
//
//  Created by MYMAc on 2017/11/6.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QJCSelectView :UIView<UIPickerViewDelegate,UIPickerViewDataSource>{
    
    NSArray * FirstDataArray;
    NSArray * SecondDataArray;
    NSArray * ThirdDataArray;
    
    
}
@property (nonatomic ,strong)  UIPickerView * selectAreaPick;



//  IsCerta;n   YES   确定按钮  并传地区  NO 取消不传地区

@property (strong , nonatomic) NSMutableArray * dataArray;

typedef void(^blockl)(BOOL IsCertain,NSString *dateString  ,NSString * prvId,NSString *cityId,NSString * AreaId) ;

-(void)ShowPicker;
@property(nonatomic, strong) blockl CertainBlock;


@end

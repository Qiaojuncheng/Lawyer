//
//  LawMoneyDetailModel.h
//  TheLawyer
//
//  Created by MYMAc on 2018/9/26.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LawMoneyDetailModel : NSObject
/*
 "id":"5",
 "lid":"27",
 "money":"25.00",
 "type":"1",
 "remark":"送心意",
 "time":"1536766740"
 */
@property (strong ,nonatomic) NSString * id;
@property (strong ,nonatomic) NSString * lid;
@property (strong ,nonatomic) NSString * money;
@property (strong ,nonatomic) NSString * type;
@property (strong ,nonatomic) NSString * remark;
@property (strong ,nonatomic) NSString * time;

@end

//
//  XLoginResultModel.m
//  TheLawyer
//
//  Created by yaoyao on 17/7/24.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface XLoginResultModel : NSObject

@property (nonatomic, copy) NSString *openId;

@property (nonatomic, copy) NSString *password;

@property (nonatomic, assign) NSInteger userId;

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, copy) NSString *birthday;

@property (nonatomic, copy) NSString *headImgUrl;

@property (nonatomic, copy) NSString *creditPoint;

@property (nonatomic, copy) NSString *trueName;

@property (nonatomic, copy) NSString *balance;

@property (nonatomic, copy) NSString *nickName;

@property (nonatomic, assign) NSNumber *sex;

@end

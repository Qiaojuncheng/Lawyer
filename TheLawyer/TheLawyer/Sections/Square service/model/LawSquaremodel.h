//
//  LawSquaremodel.h
//  TheLawyer
//
//  Created by MYMAc on 2018/10/9.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LawSquaremodel : NSObject
/*
 avatar = "/Uploads/home/avatar/2018-09-04/1536072038_16005989655b8e9966c2e90.jpg";
 "cate_name" = "\U503a\U6743\U503a\U52a1";
 city = "\U90d1\U5dde\U5e02";
 content ="\U662f\U6211\U6839\U672c\U6ca1\U94b1\U8fd8\U4ed6\U3002";
 "create_time" = 1538276687;
 id = 2;
 "lawyer_num" = 0;
 money = "600.00";
 name = "\U738b\U5ca9";
 "pay_type" = 3;  // 1
 province = "\U6cb3\U5357\U7701";
 status = 1;
 type = 2;
 "type_name" = "\U5408\U540c\U5ba1\U67e5";
 "user_money" = 0;
 */

@property (strong ,nonatomic ) NSString * avatar ;
@property (strong ,nonatomic ) NSString * cate_name ;
@property (strong ,nonatomic ) NSString * city ;
@property (strong ,nonatomic ) NSString * content ;
@property (strong ,nonatomic ) NSString * create_time ;
@property (strong ,nonatomic ) NSString * id ;
@property (strong ,nonatomic ) NSString * lawyer_num ;
@property (strong ,nonatomic ) NSString * money ;
@property (strong ,nonatomic ) NSString * name ;
@property (strong ,nonatomic ) NSString * pay_type ; //1 微信 2 余额 3 套餐
@property (strong ,nonatomic ) NSString * province ;
@property (strong ,nonatomic ) NSString * status ;
@property (strong ,nonatomic ) NSString * type ;// 服务类型
@property (strong ,nonatomic ) NSString * type_name ;
@property (strong ,nonatomic ) NSString * user_money ;

@end

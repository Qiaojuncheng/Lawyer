//
//  LawMessageModel.h
//  TheLawyer
//
//  Created by MYMAc on 2018/8/16.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LawMessageModel : NSObject
/*
 "id":"6",
 "pay_type":"2",
 "status":"1",
 "phone":"18503866892",
 "money":"600.00",
 "meet_time":"0",
 "create_time":"1536114781",
 "name":"王岩",
 "avatar":"/Uploads/home/avatar/2018-09-04/1536072038_16005989655b8e9966c2e90.jpg",
 "cate_name":"刑事"
 

pay_type
1、微信支付
2、余额支付
3、套餐支付
 status
1 付款成功 （拒绝/同意）
2 已同意 服务中...
3 已拒绝
4 律师结束
5 用户结束
 */
@property (strong, nonatomic) NSString * id;
@property (strong, nonatomic) NSString * pay_type;
@property (strong, nonatomic) NSString * status;
@property (strong, nonatomic) NSString * phone;
@property (strong, nonatomic) NSString * money;
@property (strong, nonatomic) NSString * meet_time;
@property (strong, nonatomic) NSString * create_time;
@property (strong, nonatomic) NSString * name;
@property (strong, nonatomic) NSString * avatar;
@property (strong, nonatomic) NSString * cate_name;
@property (strong, nonatomic) NSString * meet_Type;// 1 电话 2 见面
@end

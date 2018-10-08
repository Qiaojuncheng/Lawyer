//
//  LawMyTicketModel.h
//  TheLawyer
//
//  Created by MYMAc on 2018/9/26.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LawMyTicketModel : NSObject
/*
 "id":"1",
 "type":"5",
 "time":"1536329701",
 "status":"1",
 "money":"0.00",
 "user_name":"王岩",
 "type_name":"见面预约"
 */

@property (strong, nonatomic) NSString * id;
@property (strong, nonatomic) NSString * type;
@property (strong, nonatomic) NSString * time;
@property (strong, nonatomic) NSString * status;
@property (strong, nonatomic) NSString * money;
@property (strong, nonatomic) NSString * user_name;
@property (strong, nonatomic) NSString * type_name;


@end

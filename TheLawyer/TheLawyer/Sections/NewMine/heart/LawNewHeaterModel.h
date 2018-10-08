//
//  LawNewHeaterModel.h
//  TheLawyer
//
//  Created by MYMAc on 2018/9/26.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LawNewHeaterModel : NSObject
/*
 "id":"1",
 "uid":"1",
 "lid":"1",
 "money":"45",
 "create_time":"1536113940",
 "user_name":"王岩",
 "user_avatar":"/Public/avatar.png",
 "lawyer_name":"张三",
 "avatar":"/Uploads/home/avatar/2018-09-04/1536072038_16005989655b8e9966c2e90.jpg"
 */
@property(strong , nonatomic )NSString * id;
@property(strong , nonatomic )NSString * uid;
@property(strong , nonatomic )NSString * lid;
@property(strong , nonatomic )NSString * money;
@property(strong , nonatomic )NSString * create_time;
@property(strong , nonatomic )NSString * user_name;
@property(strong , nonatomic )NSString * user_avatar;
@property(strong , nonatomic )NSString * lawyer_name;
@property(strong , nonatomic )NSString * avatar;
@end

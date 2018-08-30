//
//  LawMainConsultCellMoldel.h
//  TheLawyer
//
//  Created by MYMAc on 2018/8/29.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LawMainConsultCellMoldel : NSObject
/*
 "id": "37",
 "content": "乡镇农机站，在农村合作社的时代，免费占用我们小队的土地10亩，现在确权，我们想收回属于我们自己小队的这10亩土地，我们通过怎样的方式，才能合理，合法的收回？",
 "reply_count": "0",
 "create_time": "前天 15:09",
 "status": "1",
 "name": "潘梦飞",
 "avatar": "\/Uploads\/wap\/avatar\/2018-08-27\/1535357180_15612162575b83b0fcf25f5.JPG",
 "province": "江苏省",
 "city": "无锡市",
 "cate_name": "一般民事"*/
@property (strong, nonatomic)   NSString * id;
@property (strong, nonatomic)   NSString * content;
@property (strong, nonatomic)   NSString * reply_count;
@property (strong, nonatomic)   NSString * create_time;
@property (strong, nonatomic)   NSString * status;
@property (strong, nonatomic)   NSString * name;
@property (strong, nonatomic)   NSString * avatar;
@property (strong, nonatomic)   NSString * province;
@property (strong, nonatomic)   NSString * city;
@property (strong, nonatomic)   NSString * cate_name;
 
@end

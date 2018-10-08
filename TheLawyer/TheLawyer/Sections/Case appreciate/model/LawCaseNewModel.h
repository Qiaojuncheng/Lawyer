//
//  LawCaseNewModel.h
//  TheLawyer
//
//  Created by MYMAc on 2018/9/26.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LawCaseNewModel : NSObject
/*
 "id":"2",
 "title":"案例分析",
 "cate_id":"13",
 "thumb":"/Uploads/admin/Article/2018-09-14/1536909171_9848539755b9b5f7381cc3.jpg",
 "create_time":"1536909175",
 "click":"2",
 "cate_name":"房屋拆迁",
 "is_collect":0    0 未收藏  1 已收藏
 */
@property (strong ,nonatomic )NSString * id;
@property (strong ,nonatomic )NSString * title;
@property (strong ,nonatomic )NSString * cate_id;
@property (strong ,nonatomic )NSString * thumb;
@property (strong ,nonatomic )NSString * create_time;
@property (strong ,nonatomic )NSString * click;
@property (strong ,nonatomic )NSString * cate_name;
@property (strong ,nonatomic )NSString * is_collect;


@end

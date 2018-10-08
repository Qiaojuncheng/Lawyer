//
//  LawNewMessageMM.h
//  TheLawyer
//
//  Created by MYMAc on 2018/9/28.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LawNewMessageMM : NSObject
/*
 "id":"10",
 "lid":"1",
 "title":"您参与回答的咨询已被采纳。",
 "time":"1536768019",
 "type":"3",
 "status":"0",
 "tid":"0"
 */
@property (strong , nonatomic) NSString * id;
@property (strong , nonatomic) NSString * lid;
@property (strong , nonatomic) NSString * title;
@property (strong , nonatomic) NSString * time;
@property (strong , nonatomic) NSString * type;
@property (strong , nonatomic) NSString * status;
@property (strong , nonatomic) NSString * tid;
@end

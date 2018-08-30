//
//  LawConsultDetailReplayModel.h
//  TheLawyer
//
//  Created by MYMAc on 2018/8/29.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LawConsultDetailReplayModel : NSObject
/*
 "content":"咨询回复内容",
 "time":"29分钟前",
 "lawyer_name":"张三律师",
 "avatar":"/Uploads/admin/Sys/2018-07-24/2bf12433b2c2b5554d53fb136cef25275b56ded36ab45.png"
 */

@property (strong, nonatomic) NSString * content;
@property (strong, nonatomic) NSString * time;
@property (strong, nonatomic) NSString * lawyer_name;
@property (strong, nonatomic) NSString * avatar;
@property (assign, nonatomic) CGFloat   cellHeight;



@end

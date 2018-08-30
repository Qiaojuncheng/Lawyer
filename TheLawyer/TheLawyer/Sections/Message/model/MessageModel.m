//
//  MessageModel.m
//  TheLawyer
//
//  Created by yaoyao on 17/7/28.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"commentsId" : @"id"};
}
@end

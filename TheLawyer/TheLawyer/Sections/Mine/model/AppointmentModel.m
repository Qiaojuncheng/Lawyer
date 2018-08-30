//
//  AppointmentModel.m
//  TheLawyer
//
//  Created by yaoyao on 17/7/29.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import "AppointmentModel.h"

@implementation AppointmentModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"commentsId" : @"id"};
}
@end

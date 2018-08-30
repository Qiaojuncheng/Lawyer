//
//  AppointmentModel.h
//  TheLawyer
//
//  Created by yaoyao on 17/7/29.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppointmentModel : NSObject


@property (nonatomic, copy) NSString *address;
@property (nonatomic, assign) NSInteger commentsId;
@property (nonatomic, copy) NSString *meetAddress;
@property (nonatomic, assign) NSInteger meetTime;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger phone;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, copy) NSString *headerImg;

@end

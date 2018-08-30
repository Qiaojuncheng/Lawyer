//
//  HttpAfManager.h
//  Lawyer
//
//  Created by MYMAc on 2017/8/7.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpAfManager : NSObject

//宏定义请求成功block 回调成功后得到的信息
typedef void (^HttpSuccess)(id data);
//宏定义请求失败block 回调失败后得到的信息
typedef void (^HttpFailure)(NSError *error);
//get请求
+(void)getWithUrlString:(NSString *)urlString success:(HttpSuccess)success failure:(HttpFailure)failure;

//post请求
+(void)postWithUrlString:(NSString *)urlString parameters:(NSDictionary *)parameters success:(HttpSuccess)success failure:(HttpFailure)failure;


@end

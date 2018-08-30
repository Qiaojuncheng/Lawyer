//
//  AFManagerHelp.h
//  TheLawyer
//
//  Created by yaoyao on 17/7/18.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

//成功上传图片的回调
typedef void(^SuccessUploadImageBlock)(id responseObject);
//上传失败
typedef void(^FailtureUploadImageBlock)(NSError *error);

@interface AFManagerHelp : NSObject

@property (nonatomic) AFNetworkReachabilityStatus status;

/**
 *  类方法
 */
// 配置manager
+ (AFHTTPSessionManager *)AFHTTPSessionManagerWithUrl:(NSString *)urlStr parameters:(id)parameters;

// GET请求
+ (void)Get:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObjeck)) success failure:(void (^)(NSError *error)) failure;

// POST请求
+ (void)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObjeck)) success failure:(void (^)(NSError *error)) failure;


/**
 *  对象方法
 */
// 单利
+ (instancetype)shareAFManagerHelp;

// 对象方法公用接口GET请求
- (void)Get:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObjeck)) success failure:(void (^)(NSError *error)) failure;

// POST请求
- (void)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObjeck)) success failure:(void (^)(NSError *error)) failure;

// 一般默认上传文件接口固定，不需留参数
/**
 *  文件上传
 *
 *  @param fileData   文件二进制
 *  @param name       服务器用来解析的字段
 *  @param fileName   要保存在服务器上的[文件名]
 *  @param mimeType   上传文件的[mimeType]
 type :http://www.iana.org/assignments/media-types/media-types.xhtml
 *  @param parameters 预留参数，暂时没用
 *  @param success    成功回调
 *  @param failture   失败回调
 */
+ (void)asyncUploadFileWithData:(NSData *)fileData name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType parameters:(id)parameters success:(SuccessUploadImageBlock)success failture:(FailtureUploadImageBlock)failture;


/**
 *  监控网络状态
 */
- (void)openMonitoringNetwork;

@end

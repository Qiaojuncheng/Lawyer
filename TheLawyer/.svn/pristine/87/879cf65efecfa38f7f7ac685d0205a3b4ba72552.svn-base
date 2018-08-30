//
//  AFManagerHelp.m
//  TheLawyer
//
//  Created by yaoyao on 17/7/18.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import "AFManagerHelp.h"
#import "NSString+Password.h"

@implementation AFManagerHelp

#pragma mark 类方法实现
// 配置manager
+ (AFHTTPSessionManager *)AFHTTPSessionManagerWithUrl:(NSString *)urlStr parameters:(id)parameters {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    manager.securityPolicy = [AFSecurityPolicy defaultPolicy];
    
    manager.reachabilityManager = [AFNetworkReachabilityManager sharedManager];

    return manager;
}

/**
 *  GET请求
 */
+ (void)Get:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObjeck)) success failure:(void (^)(NSError *error)) failure {
    AFHTTPSessionManager *manager = [self AFHTTPSessionManagerWithUrl:URLString parameters:parameters];
    
    [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {//并且code = 正确
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

/**
 *  POST请求
 */
+ (void)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObjeck)) success failure:(void (^)(NSError *error)) failure {
    AFHTTPSessionManager *manager = [self AFHTTPSessionManagerWithUrl:URLString parameters:parameters];
    
    [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
        
    }];
}

#pragma mark 创建单例
/**
 *  创建单例
 *  @return 请求单例
 */
+ (instancetype )shareAFManagerHelp {
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

#pragma mark 对象方法
// 配置AFManager
- (AFHTTPSessionManager *)AFHTTPSessionManager {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    //    [manager.requestSerializer setValue:<#(nullable NSString *)#> forHTTPHeaderField:<#(nonnull NSString *)#>]
    return manager;
}

/**
 *  GET请求
 */
- (void)Get:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObjeck)) success failure:(void (^)(NSError *error)) failure {
    AFHTTPSessionManager *manager = [self AFHTTPSessionManager];
    
    [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {//并且code = 正确
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

/**
 *  POST请求
 */
- (void)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObjeck)) success failure:(void (^)(NSError *error)) failure {
    AFHTTPSessionManager *manager = [self AFHTTPSessionManager];
    [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
        
    }];
}

#pragma mark 上传
/**
 *  图片上传接口实现
 *
 *  @param fileData   上传文件的二进制数据
 *  @param name       服务器用来解析的字段
 *  @param fileName   要保存在服务器上的[文件名]
 *  @param mimeType   上传文件的[mimeType]
 *  @param parameters 预留参数，暂时没用
 *  @param success    成功回调
 *  @param failture   失败回调
 */
+ (void)asyncUploadFileWithData:(NSData *)fileData name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType parameters:(id)parameters success:(SuccessUploadImageBlock)success failture:(FailtureUploadImageBlock)failture {

    AFHTTPSessionManager *manager = [self AFHTTPSessionManagerWithUrl:LS_UPLODE parameters:parameters];
    
    [manager POST:LS_UPLODE parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        //fileName:上传图片名称 fileName.jpg
        /*
         fileName 类型对应下面 mimeType
         
         //例如：png格式对应--	image/png
         
         */
        
        
        //mimeType:格式 image/jpeg
        [formData appendPartWithFileData:fileData name:name fileName:fileName mimeType:mimeType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        DLog(@"---%llu---%llu",uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DLog(@"%@",responseObject);
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog(@"%@",error.localizedDescription);
        if (failture) {
            failture(error);
        }
    }];
}

#pragma mark - 网络监控
- (void)openMonitoringNetwork {
    // 检测网络连接状态
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 连接状态回调处理
//    AFNetworking的Block内使用self须改为weakSelf, 避免循环强引用, 无法释放
    __weak typeof(self) weakSelf = self;
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status)
     {
         weakSelf.status = status;
         switch (status)
         {
             case AFNetworkReachabilityStatusUnknown:
                 DLog(@"Unknown");
                 break;
             case AFNetworkReachabilityStatusNotReachable:
                 DLog(@"NotReachable");
                 break;
             case AFNetworkReachabilityStatusReachableViaWWAN:
                 DLog(@"WWAN");
                 break;
             case AFNetworkReachabilityStatusReachableViaWiFi:
                 DLog(@"WiFi");
                 break;
             default:
                 break;
         }
     }];
}

@end

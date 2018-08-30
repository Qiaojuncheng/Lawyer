//
//  PublicMethod.h
//  TheLawyer
//
//  Created by yaoyao on 17/7/18.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface PublicMethod : NSObject

// 单例
+ (instancetype)sharedManager;

/**
 *  获得指定宽度大小的label的size
 */
+(CGSize)getContentSizeWithContent:(NSString *)content width:(NSInteger)width font:(UIFont *)font;

/**
 *  获取AppDelegate
 *
 *  @return AppDelegate
 */
+ (AppDelegate *)getWfgAppDelegate;

/**
 *  颜色转换为背景图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 *  获取宽高比
 */
+ (CGFloat)accordWidthAndHeight:(CGFloat)width :(CGFloat)height;

/**
 *  版本号和资源获取
 */
+ (void)getVersionWithFileName:(NSString *)name versionUrl:(NSString *)versionUrl downUrl:(NSString *)downUrl resourceId:(NSInteger)resourceId;

/**
 *  下载资源
 *
 *  @param downUrl 下载地址
 *  @param path    文件名
 */
+ (void)downWithUrl:(NSString *)downUrl andPath:(NSString *)path;

// 根据文件名获取本地文件
+ (id)getLocationDataWithFileName:(NSString *)name;

// 根据文件名获取文件路径
+ (NSString *)getFilePathWithFileName:(NSString *)name;

// 根据字典和文件名向本地存储文件
+ (void)saveData:(NSDictionary *)dic withFileName:(NSString *)fileName;

/**
 *  获取userId
 */
+ (NSString *)getUserId;

/**
 *  分割线
 */
+ (UIView *)creatDividerWithFrame:(CGRect)frame;

/**
 *  获取当前显示的视图控制器
 */
+ (UIViewController *)getCurrentDisplayedViewController;

// alert
- (void)alertBox:(NSString *)title
         message:(NSString *)message
cancelButtonTitle:(NSString *)cancelButtonTitle
otherButtonTitle:(NSString *)otherButtonTitle
  alertViewStyle:(UIAlertViewStyle)alertViewStyle
cancelClickBlock:(void (^) (void))cancelClickBlock
 otherClickBlock:(void (^) (NSString *text))otherClickBlock;

/**
 *  参考价格划线方法
 */
+ (void)setReferencePriceLabel:(UILabel *)referencePriceLabel;

/**
 *  参数Encode
 */
+ (NSString *)urlEncodedString:(NSString *)string;

/**
 *  价格处理
 *  @return 处理后的价格
 */
+ (NSString *)managePrice:(double)price;

/**
 *  验证签名
 */
+ (BOOL)verifySign:(NSString *)result;

/**
 *  标签栏跳转
 */
+ (void)jumpTabbarItem:(NSInteger)index;

/**
 *  字典转字符串
 */
+ (NSString*)getJsonWith:(NSDictionary*)dic;

// 计算文件大小，返回B
+ (long long)fileSizeAtPath:(NSString*)filePath;
// 遍历文件夹获得文件夹大小，返回多少B
+ (long long)folderSizeAtPath:(NSString*)folderPath;
// 删除文件夹下的所有文件
+ (void)removeFileInFolderPath:(NSString *)folderPath;

/**
 *  跳转登录页面
 */
+ (void)jumpLoginViewControllerBlock:(void(^)(void))block;

/**
 *  数量处理
 */
+ (NSString *)dealNumber:(NSString *)number;

/**
 *  获取当前时间
 */
+ (NSString *)getCurrentDate;

@end

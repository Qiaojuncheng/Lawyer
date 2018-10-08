//
//  PublicMethod.m
//  TheLawyer
//
//  Created by yaoyao on 17/7/18.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import "PublicMethod.h"
#import "XVersionModel.h"
 
@interface PublicMethod ()<UIAlertViewDelegate>

@property (nonatomic, copy) void(^cancelBlock)(void);
@property (nonatomic, copy) void(^otherBlock)(NSString *text);
@property (nonatomic, strong) NSArray *versionArr;

@end

@implementation PublicMethod

// 单例
+ (instancetype)sharedManager {
    static id _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

+(CGSize)getContentSizeWithContent:(NSString *)content width:(NSInteger)width font:(UIFont *)font
{
    CGSize size;
    if (MJCURRENTDEVICE >= 7.0) {
        CGRect rect = [content boundingRectWithSize:CGSizeMake(width, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
        size = rect.size;
    }else{
        size = [content sizeWithFont:font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    }
    return size;
}

+ (AppDelegate *)getWfgAppDelegate
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

#pragma mark -- 颜色转换为背景图片

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (CGFloat)accordWidthAndHeight:(CGFloat)width :(CGFloat)height
{
    return width / height;
}

#pragma mark -- 查询版本号
+ (void)getVersionWithFileName:(NSString *)name versionUrl:(NSString *)versionUrl downUrl:(NSString *)downUrl resourceId:(NSInteger)resourceId {
    
    NSString *filePath = [PublicMethod getFilePathWithFileName:name];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // 判断文件是否存在
    if ([fileManager fileExistsAtPath:filePath]) {
        
        NSDictionary *dic = [PublicMethod getLocationDataWithFileName:name];
        
        // 版本号
        NSString *version = dic[@"version"];
        if ([PublicMethod sharedManager].versionArr) {
            for (NSDictionary *dic in [PublicMethod sharedManager].versionArr) {
                XVersionModel *tempModel = [XVersionModel mj_objectWithKeyValues:dic];
                if (tempModel.resourceId == resourceId) {
                    if ([tempModel.version integerValue] != [version integerValue]) {
                        [PublicMethod downWithUrl:downUrl andPath:filePath];
                    }
                    break;
                }
            }
        } else {
            [AFManagerHelp Get:versionUrl parameters:nil success:^(id responseObjeck) {
                [PublicMethod sharedManager].versionArr = [NSArray mj_objectWithKeyValues:responseObjeck[@"result"]];
                for (NSDictionary *dic in [PublicMethod sharedManager].versionArr) {
                    XVersionModel *tempModel = [XVersionModel mj_objectWithKeyValues:dic];
                    if (tempModel.resourceId == resourceId) {
                        if ([tempModel.version integerValue] != [version integerValue]) {
                            [PublicMethod downWithUrl:downUrl andPath:filePath];
                        }
                        break;
                    }
                }
            } failure:^(NSError *error) {
                
            }];
        }
    } else {
        // 不存在，直接下载
        [PublicMethod  downWithUrl:downUrl andPath:filePath];
    }

}

+ (void)downWithUrl:(NSString *)downUrl andPath:(NSString *)path {
    //获取所有分类信息
    [AFManagerHelp POST:downUrl parameters:nil success:^(id responseObjeck) {
        NSDictionary *dic = responseObjeck[@"result"];
        
        if (dic && ![dic isKindOfClass:[NSNull class]]) {
            NSError *error;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
            
            // 判断文件是否存在
            NSFileManager *fileManager = [NSFileManager defaultManager];
            if ([fileManager fileExistsAtPath:path]) {
                NSError *err;
                [fileManager removeItemAtPath:path error:&err];
            }
            
            [jsonData writeToFile:path options:NSDataWritingWithoutOverwriting error:&error];
            DLog(@"下载成功");
        }
    } failure:^(NSError *error) {
        DLog(@"下载失败，downUrl:%@, error:%@", downUrl, error);
    }];
}

+ (NSString *)getFilePathWithFileName:(NSString *)name {
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:name];
    
    return filePath;
}

+ (id)getLocationDataWithFileName:(NSString *)name {
    // 存在，取出
    NSString *filePath = [PublicMethod getFilePathWithFileName:name];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
        NSError *error;
        NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
        id object = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
        return object;
    }
    return nil;
}

+ (void)saveData:(NSDictionary *)dic withFileName:(NSString *)fileName {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    
    // 判断文件是否存在
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *path = [PublicMethod getFilePathWithFileName:fileName];
    DLog(@"本地文件路径:%@", path);
    if ([fileManager fileExistsAtPath:path]) {
        NSError *err;
        [fileManager removeItemAtPath:path error:&err];
    }
    
    [jsonData writeToFile:path options:NSDataWritingWithoutOverwriting error:&error];
}

+ (NSString *)getUserId
{
    return [UD objectForKey:@"userID"];
}

/**
 *  分割线
 */
+ (UIView *)creatDividerWithFrame:(CGRect)frame
{
    UIView *line = [[UIView alloc] initWithFrame:frame];
    line.backgroundColor = RGBMCOLOR(230);
    return line;
}

+ (UIViewController *)getCurrentDisplayedViewController
{
    //获取当前屏幕显示的viewcontroller
    UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [PublicMethod findBestViewController:viewController];
}

+ (UIViewController *)findBestViewController:(UIViewController *)vc {
    if (vc.presentedViewController) {
        // Return presented view controller
        return [PublicMethod findBestViewController:vc.presentedViewController];
    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
        // Return right hand side
        UISplitViewController *svc = (UISplitViewController *)vc;
        if (svc.viewControllers.count > 0)
            return [PublicMethod findBestViewController:svc.viewControllers.lastObject];
        else
            return vc;
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        // Return top view
        UINavigationController *svc = (UINavigationController *)vc;
        if (svc.viewControllers.count > 0)
            return [PublicMethod findBestViewController:svc.topViewController];
        else
            return vc;
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        // Return visible view
        UITabBarController *svc = (UITabBarController *)vc;
        if (svc.viewControllers.count > 0)
            return [PublicMethod findBestViewController:svc.selectedViewController];
        else
            return vc;
    } else {
        // Unknown view controller type, return last child view controller
        return vc;
    }
}

// alert
- (void)alertBox:(NSString *)title
         message:(NSString *)message
cancelButtonTitle:(NSString *)cancelButtonTitle
otherButtonTitle:(NSString *)otherButtonTitle
  alertViewStyle:(UIAlertViewStyle)alertViewStyle
cancelClickBlock:(void (^) (void))cancelClickBlock
 otherClickBlock:(void (^) (NSString *text))otherClickBlock{
    
    self.cancelBlock = cancelClickBlock;
    self.otherBlock = otherClickBlock;
    
    if (iOS8) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        if (alertViewStyle == UIAlertViewStylePlainTextInput) {
            [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                
            }];
        }
        
        
        // Create the actions.
        if (cancelButtonTitle) {
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                if (self.cancelBlock) {
                    self.cancelBlock();
                }
            }];
            [alertController addAction:cancelAction];
        }
        
        
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            if (self.otherBlock) {
                self.otherBlock(alertController.textFields.firstObject.text);
            }
        }];
        
        // Add the actions.
        [alertController addAction:otherAction];
        
        [[PublicMethod getCurrentDisplayedViewController] presentViewController:alertController animated:YES completion:nil];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitle, nil];
        
        [alertView setAlertViewStyle:alertViewStyle];
        [alertView show];
    }
    
}

#pragma mark -UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0 && self.cancelBlock) {
        self.cancelBlock();
    }
    if (buttonIndex == 1 && self.otherBlock) {
        if (alertView.alertViewStyle == UIAlertViewStylePlainTextInput) {
            UITextField *textField = [alertView textFieldAtIndex:0];
            self.otherBlock(textField.text);
        } else {
            self.otherBlock(nil);
        }
        
    }
}

#pragma mark 参考价格划线方法
+ (void)setReferencePriceLabel:(UILabel *)referencePriceLabel {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:referencePriceLabel.text];
    [attributedString addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [attributedString length])];
    [referencePriceLabel setAttributedText:attributedString];
}

+ (NSString *)urlEncodedString:(NSString *)string
{
    NSString * encodedString = (__bridge_transfer  NSString*) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)string, NULL, (__bridge CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8 );
    
    return encodedString;
}

#pragma mark 价格处理的方法
+ (NSString *)managePrice:(double)price {
    if (price - (NSInteger)price != 0) {
        return [NSString stringWithFormat:@"%.2f", price];
    } else {
        return [NSString stringWithFormat:@"%ld", (long)(NSInteger)price];
    }
}

// 验证签名
//+ (BOOL)verifySign:(NSString *)result
//{
//    NSArray *resultArray = [result componentsSeparatedByString:@"&"];
//    NSString *success;
//    NSString *sign;
//    for (NSString *string in resultArray) {
//        if ([string hasPrefix:@"success"]) {
//            success = [[string componentsSeparatedByString:@"="] lastObject];
//        }
//        if ([string hasPrefix:@"sign="]) {
//            sign = [[string componentsSeparatedByString:@"sign="] lastObject];
//        }
//    }
//    DLog(@"sign:%@",sign);
//    
//    NSMutableString *temp = [NSMutableString stringWithString:sign];
//    NSRange range1;
//    range1.length = 1;
//    range1.location = 0;
//    [temp replaceCharactersInRange:range1 withString:@""];
//    
//    NSRange range2;
//    range2.length = 1;
//    range2.location = temp.length - 1;
//    [temp replaceCharactersInRange:range2 withString:@""];
//    
//    NSString *param = [[result componentsSeparatedByString:@"&sign_type"] firstObject];
//    id<DataVerifier> ver = CreateRSADataVerifier(AlipayPubKey);
//    BOOL v = [ver verifyString:param withSign:temp];
//    BOOL s = [success isEqualToString:@"\"true\""];
//    if (s && v) {
//        return YES;
//    }
//    return NO;
//}

//+ (void)jumpTabbarItem:(NSInteger)index
//{
//    [[PublicMethod getWfgAppDelegate].mainTabbar.tabBarView tabBarButtonClicked:[[PublicMethod getWfgAppDelegate].mainTabbar.tabBarView.buttonArray objectAtIndex:index]];
//}

+ (NSString *)getJsonWith:(NSDictionary*)dic {
    
    NSString *json = nil;
    
    if ([NSJSONSerialization isValidJSONObject:dic]) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:0 error:&error];
        if(!error) {
            json =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        }
    }
    return json;
}

// 计算文件大小
+ (long long)fileSizeAtPath:(NSString *)filePath {
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}
//遍历文件夹获得文件夹大小，返回多少B
+ (long long)folderSizeAtPath:(NSString *)folderPath {
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize;
}

// 删除文件夹下的所有文件
+ (void)removeFileInFolderPath:(NSString *)folderPath {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *contents = [fileManager contentsOfDirectoryAtPath:folderPath error:NULL];
    NSEnumerator *e = [contents objectEnumerator];
    NSString *filename;
    while ((filename = [e nextObject])) {
        [fileManager removeItemAtPath:[folderPath stringByAppendingPathComponent:filename] error:NULL];
    }
}

//#pragma mark 跳转登陆
//+ (void)jumpLoginViewControllerBlock:(void(^)(void))block {
//    if ([UD objectForKey:@"userID"]) {
//        block();
//    } else {
//        LoginViewController *loginVC = [LoginViewController new];
//        loginVC.stateLR = 0;
//        loginVC.xLoginResultBlock = block;
//        [[self getCurrentDisplayedViewController].navigationController pushViewController:loginVC animated:YES];
//    }
//}

#pragma mark - Method
/**
 *  数量处理
 */
+ (NSString *)dealNumber:(NSString *)number
{
    if ([number length] > 4) {
        NSInteger interBefore = [number integerValue] / 10000;
        NSInteger interAfter  = [number integerValue] / 1000;
        return [NSString stringWithFormat:@"%ld.%ld万", interBefore, interAfter - interBefore * 10];
    }
    return number;
}

/**
 *  获取当前时间
 */
+ (NSString *)getCurrentDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    return dateString;
}

@end

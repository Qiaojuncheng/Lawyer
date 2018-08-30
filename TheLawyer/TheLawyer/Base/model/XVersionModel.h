//
//  XVersionModel.h
//  TheLawyer
//
//  Created by yaoyao on 17/7/18.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface XVersionModel : NSObject

@property (nonatomic, assign) NSInteger resourceId;
@property (nonatomic, copy) NSString *version;


@property (nonatomic, copy) NSString *upgradeContent;

@property (nonatomic, assign) NSInteger isForceUpdate;

@property (nonatomic, copy) NSString *downloadUrl;

@end

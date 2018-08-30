//
//  QJCJQuestionSubModel.h
//  Lawyer
//
//  Created by MYMAc on 2017/9/27.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QJCJQuestionSubModel : NSObject

/*
 "id": "15", 
 "title": "帐户注册只能用手机注册吗？", //标题 
 "content": "手机电脑都能注册" //内容
 */

@property (nonatomic, strong) NSString * id;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * content;


@end

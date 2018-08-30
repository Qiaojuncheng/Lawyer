//
//  QJCJQuestionModel.h
//  Lawyer
//
//  Created by MYMAc on 2017/9/27.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QJCJQuestionSubModel.h"
@interface QJCJQuestionModel : NSObject

/*
 id": "16", 
 "cate_name": "帐户问题", //分类名称 
 "arcList": [ { "id": "15", "title": "帐户注册只能用手机注册吗？", //标题 "content": "手机电脑都能注册" //内容 }],
 */


@property (nonatomic, strong) NSString * id;
@property (nonatomic, strong) NSString * cate_name;
@property (nonatomic, strong) NSMutableArray * arcLists;

+(QJCJQuestionModel *)makeModelWithDic:(NSDictionary *)dic;

@end

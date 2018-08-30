//
//  QJCJQuestionModel.m
//  Lawyer
//
//  Created by MYMAc on 2017/9/27.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJCJQuestionModel.h"

@implementation QJCJQuestionModel

+(QJCJQuestionModel *)makeModelWithDic:(NSDictionary *)dic{

    QJCJQuestionModel * model =[QJCJQuestionModel yy_modelWithDictionary:dic];
    model.arcLists =[[NSMutableArray alloc]init];
    for (NSDictionary * datadic in dic[@"arcList"]) {
 
        QJCJQuestionSubModel * SubModel = [QJCJQuestionSubModel yy_modelWithDictionary:datadic];
        [model.arcLists addObject:SubModel];
    }
     
    return model;

}



@end

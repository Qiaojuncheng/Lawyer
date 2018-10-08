//
//  LawPlatformModel.m
//  TheLawyer
//
//  Created by MYMAc on 2018/9/19.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawPlatformModel.h"
#import "LawConsultTypeModel.h"
@implementation LawPlatformModel
+(NSDictionary *)modelContainerPropertyGenericClass {
    
    return @{@"cate":[LawConsultTypeModel class]};
    
}
@end

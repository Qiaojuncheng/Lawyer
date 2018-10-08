//
//  LawAddressModel.m
//  TheLawyer
//
//  Created by MYMAc on 2018/9/3.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawAddressModel.h"

@implementation LawAddressModel
+(NSDictionary *)modelContainerPropertyGenericClass {
 return @{@"child":[LawAddressModel class]};
}
@end

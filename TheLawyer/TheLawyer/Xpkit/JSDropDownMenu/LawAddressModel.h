//
//  LawAddressModel.h
//  TheLawyer
//
//  Created by MYMAc on 2018/9/3.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LawAddressModel : NSObject
@property (strong , nonatomic) NSString *  id;
@property (strong , nonatomic) NSString *  name;
@property (copy , nonatomic) NSMutableArray  *  child;


@end

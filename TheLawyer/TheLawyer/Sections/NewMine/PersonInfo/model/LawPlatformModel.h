//
//  LawPlatformModel.h
//  TheLawyer
//
//  Created by MYMAc on 2018/9/19.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LawPlatformModel : NSObject
/*
 
 cate
 certificate = " ";
 company = "\U6c5f\U82cf\U53cc\U6c47\U5f8b\U5e08\U4e8b\U52a1\U6240";
 id = 29;
 "lawyer_code" = 0;
 "meet_money" = "20.00";
 "phone_money" = "20.00";
 */

@property(strong, nonatomic)  NSMutableArray * cate;// 规格数组
 @property(strong, nonatomic) NSString  * certificate;
@property(strong, nonatomic) NSString  * company;
@property(strong, nonatomic) NSString  * id;
@property(strong, nonatomic) NSString  * lawyer_code;
@property(strong, nonatomic) NSString  * meet_money;
@property(strong, nonatomic) NSString  * phone_money;
@property(strong, nonatomic) NSString  * instru;

@end

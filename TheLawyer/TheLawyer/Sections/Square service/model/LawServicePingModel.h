//
//  LawServicePingModel.h
//  TheLawyer
//
//  Created by MYMAc on 2018/11/28.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LawServicePingModel : NSObject
/*
 "id":"1",
 "time":"1543240562",
 "name":"方大同",
 "describe":"合同审查竞标",
 "avatar":"/Uploads/app/Avatar/2018-11-09/1541741907_3338.jpg"
 
*/
@property (strong, nonatomic ) NSString * id;
@property (strong, nonatomic ) NSString * time;
@property (strong, nonatomic ) NSString * name;
@property (strong, nonatomic ) NSString * describe;
@property (strong, nonatomic ) NSString * avatar;

@property (assign, nonatomic ) CGFloat  cellHeight;
-(void)MakeCellHeight;
@end

NS_ASSUME_NONNULL_END

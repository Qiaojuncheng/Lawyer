//
//  QJCAppointModel.h
//  TheLawyer
//
//  Created by MYMAc on 2017/11/4.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QJCAppointModel : NSObject
/*
 address = "\U6c5f\U82cf\U7701 \U65e0\U9521\U5e02 \U6ee8\U6e56\U533a";
 avator = "/Uploads/Avatar/user/2017-10-31/9cbb4a8f74b2b2a04dfee1c237ec9fd559f8184e94c5f.jpg";
 id = 19;
 meetAddress = "\U6c5f\U82cf\U7701 \U65e0\U9521\U5e02 \U6ee8\U6e56\U533a\U7ea2\U661f\U8def350\U53f7";
 meetTime = 1512207420;
 name = "\U738b\U5ca9";
 phone = 18503866892;
 status = 4;
 type = "\U9884\U7ea6\U89c1\U9762";
 pay_type

 */
@property (strong ,nonatomic) NSString  * address ;
@property (strong ,nonatomic) NSString  * avator ;
@property (strong ,nonatomic) NSString  * id ;
@property (strong ,nonatomic) NSString  * meetAddress ;
@property (strong ,nonatomic) NSString  * meetTime ;
@property (strong ,nonatomic) NSString  * name ;
@property (strong ,nonatomic) NSString  * phone ;
@property (strong ,nonatomic) NSString  * status ; //  1同意、拒绝 2 已同意 完成按钮 3 已拒绝 4 待评价 5 服务已完成
@property (strong ,nonatomic) NSString  * type ;// 1 电话 2 地址
@property (strong ,nonatomic) NSString  * typeName ;
@property (strong ,nonatomic) NSString  * pay_type ;//支付的方式
@property (assign ,nonatomic) CGFloat   cellHeight ;
-(void)MakeCellHeight;
@end

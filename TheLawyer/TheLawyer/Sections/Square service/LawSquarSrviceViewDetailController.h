//
//  LawSquarSrviceViewDetailController.h
//  TheLawyer
//
//  Created by MYMAc on 2018/8/17.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "BaseViewController.h"
#import "LawSquarServiceFootView.h"
@interface LawSquarSrviceViewDetailController : BaseViewController
@property (strong ,nonatomic) LawSquarServiceFootView * FootView;
@property (strong ,nonatomic) NSString * Serviceid ;//服务id

@property (copy ,nonatomic) void(^ReladBlock)(NSString * number);
@end

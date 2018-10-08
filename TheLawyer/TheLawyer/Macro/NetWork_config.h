//
//  NetWork_config.h
//  TheLawyer
//
//  Created by yaoyao on 17/7/18.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//
//http://www.huirongfa.com/App/Index/api
#pragma mark ----------- 地址
#if 1  /*正式地址*/

//#define BASE_URL @"http://www.huirongfa.com/App/Index/api"
//#define Image_URL @"http://www.huirongfa.com"
#define BASE_URL  @"http://www.huirongfa.com/App/Index/api"
#define Image_URL @"http://www.huirongfa.com/"


#else  /*测试地址*/

#define BASE_URL @"http://122.114.208.180:92/App/Index/api"
#define Image_URL @"http://122.114.208.180:92"

//#define BaseURLWithStr(imageUrl) [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_URL,(imageUrl)]]

#define kGetImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]


#define BASE_WEBURL @""

#endif
#define  UserId [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"]
#define  APPPhone [[NSUserDefaults standardUserDefaults] objectForKey:@"400Phone"]

#define  UserPhone [[NSUserDefaults standardUserDefaults] objectForKey:@"phone"]


#pragma mark ----------- 接口

/*首页*/
#define LS_HOME [NSString stringWithFormat:@"%@%@",BASE_URL, @"/Home/QueryIndex"]
/*上传接口*/
#define LS_UPLODE [NSString stringWithFormat:@"%@%@",BASE_URL, @"/FileUpLoad/FileUpLoad"]
//抢单
#define LS_GRAB [NSString stringWithFormat:@"%@%@",BASE_URL, @"App/Lawyer/law"]

// 我的预约 
#define QJYUYUE      [dic setValue:@"App/Lawyer/yuyue" forKey:@"action"];
//我的预约 同意拒绝
#define QJYUYUEStaTus      [dic setValue:@"App/Lawyer/changYuyueStatus" forKey:@"action"];
// 我的预约 预约完成
#define QJYUYUE_Over      [dic setValue:@"App/Lawyer/yuyue_over" forKey:@"action"];


//我的咨询
#define QJCZIXUN      [dic setValue:@"App/Lawyer/zixun" forKey:@"action"];

// 回复
#define QJCZIXUNREPLY      [dic setValue:@"App/Lawyer/reply" forKey:@"action"];
//我的服务   App/Lawyer/history
#define QJCSERVICE      [dic setValue:@"App/Lawyer/history" forKey:@"action"];
// 我的服务完成  App/Lawyer/lawyer_over
#define QJLAWYEROVER      [dic setValue:@"App/Lawyer/lawyer_over" forKey:@"action"];

//接单 App/Lawyer/order
#define QJCQIANGDAN      [dic setValue:@"App/Lawyer/order" forKey:@"action"];
// 领域 三级联动
#define QJCQICATEGORY      [dic setValue:@"App/Lawyer/getCategory" forKey:@"action"];
// 个人资料
#define QJCPERSONINFO      [dic setValue:@"App/Lawyer/ziliao" forKey:@"action"];
//修改个人资料
#define QJCCHANGRINFO      [dic setValue:@"App/Lawyer/editZiliao" forKey:@"action"];
// 完善个人资料
#define QJCADDPERSONINFO      [dic setValue:@"App/Lawyer/addZiliao" forKey:@"action"];
//律师定位
#define QJCLayerLOCATION      [dic setValue:@"App/Lawyer/getLocation" forKey:@"action"];

//提现信息
#define QJTXINFO [dic setValue:@"App/Public/tx_info" forKey:@"action"];
// 提现接口
#define UserdoCash [dic setValue:@"App/Lawyer/tx" forKey:@"action"];

// 意见反馈
#define QJAddvice [dic setValue:@"App/Lawyer/fankui" forKey:@"action"];

//忘记密码
#define QJFINDPASS    [dic setValue:@"Base/User/find_user_password" forKey:@"action"];
//忘记密码获取验证码
#define QJFINDCODE     [dic setValue:@"Base/User/user_find_code" forKey:@"action"];

//第三方登录
#define QJTHREELOGIN     [dic setValue:@"App/Lawyer/threeLogin" forKey:@"action"];
// 绑定手机号 App/Lawyer/bindThree
#define QJTBangDingPhone     [dic setValue:@"App/Lawyer/bindThree" forKey:@"action"];



#define  QJCQUESTION   [dic setValue:@"App/User/question" forKey:@"action"];
// 资讯详情
#define INFODETAIL  @"/Wap/News/info/id"



#pragma  mark  新的接口
// 获取400 电话
#define NewGetPhone [dic setValue:@"App/Public/tel" forKey:@"action"];

// 上传位置
#define NewGetLocation  [dic setValue:@"App/Lawyer/getLocation" forKey:@"action"];

//咨询和首页咨询   传lawyer_id  为我的咨询  不传lawyer_id  为首页咨询
#define NewConsult  [dic setValue:@"App/Lawyer/consult" forKey:@"action"];
//咨询回复
#define NewConsultReply  [dic setValue:@"App/Lawyer/reply" forKey:@"action"];
//咨询详情
#define NewConsultDetail  [dic setValue:@"App/Lawyer/consultXq" forKey:@"action"];
//我的消息
#define NewMymessageList [dic setValue:@"App/Lawyer/message" forKey:@"action"];

//咨询地址的接口
#define NewConsultGetRegion  [dic setValue:@"App/Public/getRegion" forKey:@"action"];
//案件类型
#define NewConsultGetType  [dic setValue:@"App/Public/getCategory" forKey:@"action"];
//电话或者见面预约
#define NewMeetGetyuYue  [dic setValue:@"App/Lawyer/yuYue" forKey:@"action"];
// 预约服务结束
#define NewMeetyuYueOver  [dic setValue:@"App/Lawyer/yuYueOver" forKey:@"action"];
// 预约改变状态  
#define NewMeetYuYueStatus  [dic setValue:@"App/Lawyer/changYuYueStatus" forKey:@"action"];

// 案件欣赏
#define NewCaseNews  [dic setValue:@"App/Public/News" forKey:@"action"];
//收藏取消收藏
#define NewCaseNewscollect  [dic setValue:@"App/Public/collect" forKey:@"action"];


#pragma 我的  + 注册
// 我的信息
#define  NewGetInfor  [dic setValue:@"App/Lawyer/information" forKey:@"action"];
//更改信息
#define  NewAddInfor  [dic setValue:@"App/Lawyer/addInfo" forKey:@"action"];
//银行卡列表
#define  NewMyBankList  [dic setValue:@"App/Lawyer/myBank" forKey:@"action"];
// 银行卡获取验证码
#define  NewMyBankgetCode  [dic setValue:@"App/Lawyer/getCode" forKey:@"action"];
//添加银行卡
#define  NewMyBankbindBank  [dic setValue:@"App/Lawyer/bindBank" forKey:@"action"];
// 删除银行卡
#define  NewMyBankdelBank  [dic setValue:@"App/Lawyer/delBank" forKey:@"action"];
//认证信息
#define  NewMyInforRen  [dic setValue:@"App/Lawyer/renZheng" forKey:@"action"];

//我的收藏
#define NewCasemyCollect  [dic setValue:@"App/Lawyer/myCollect" forKey:@"action"];
// 常见问题
#define  NewPublicQuestion   [dic setValue:@"App/Public/question" forKey:@"action"];

//常见问题详情
#define  NewPublicQuestionDetail   @"Wap/News/question/id/" 

// 意见反馈
#define QJAddvicefeedback [dic setValue:@"App/Public/feedback" forKey:@"action"];
//账户余额
#define QJAddvicegetMoney [dic setValue:@"App/Public/getMoney" forKey:@"action"];
//明细
#define NewMoneydetailed [dic setValue:@"App/Lawyer/detailed" forKey:@"action"];
// 提现App/Lawyer/tx
#define NewMoneyTx [dic setValue:@"App/Lawyer/tx" forKey:@"action"];

//收到的心意
#define NewHetermind [dic setValue:@"App/Public/mind" forKey:@"action"];

//套餐券
#define NewMyticket [dic setValue:@"App/Lawyer/ticket" forKey:@"action"];
//兑换套餐券
#define NewticketChange [dic setValue:@"App/Lawyer/ticketChange" forKey:@"action"];

//我要发布
#define NewIWantPublic [dic setValue:@"App/Lawyer/release" forKey:@"action"];







// 注册获取验证码
#define  NewGetCode  [dic setValue:@"Base/User/regGetVerify" forKey:@"action"];
// 登录获取验证码
#define  NewLogGetCode  [dic setValue:@"Base/User/logGetVerify" forKey:@"action"];

// 注册并验证
#define  NewRegiste  [dic setValue:@"Base/User/appReg" forKey:@"action"];
// 登录
#define  NewLogin  [dic setValue:@"Base/User/appLog" forKey:@"action"];
//














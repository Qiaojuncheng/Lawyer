//
//  Common.h
//  TheLawyer
//
//  Created by yaoyao on 17/7/18.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#ifndef Common_h
#define Common_h

#pragma mark - 公共宏
#define  YelleColorTine [UIColor colorWithHex:0xffdb28]
#define  QingColor [UIColor colorWithHex:0x37c650]
#define  BlueColor [UIColor colorWithHex:0x1fa5fe]
#define  MainBlueColor [UIColor colorWithHex:0x216BB0]
#define  YellColoreDeep [UIColor colorWithHex:0xfd7c14]




/*iOS版本*/
// 版本号
#define MJCURRENTDEVICE [[[UIDevice currentDevice] systemVersion] floatValue]
// iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0 && [[UIDevice currentDevice].systemVersion doubleValue] < 8.0)
// iOS8
#define iOS8 ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0 && [[UIDevice currentDevice].systemVersion doubleValue] < 9.0)
// iOS9
#define iOS9 ([[UIDevice currentDevice].systemVersion doubleValue] >= 9.0 && [[UIDevice currentDevice].systemVersion doubleValue] < 10.0)
// iOS10
#define iOS10 ([[UIDevice currentDevice].systemVersion doubleValue] >= 10.0 ）

// iOS7及以后
#define iOS7_OR_Later ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0 )
// iOS8及以后
#define iOS8_OR_Later ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0 )
// iOS9及以后
#define iOS9_OR_Later ([[UIDevice currentDevice].systemVersion doubleValue] >= 9.0 )
// iOS9.1及以后
#define iOS9_1OR_Later ([[UIDevice currentDevice].systemVersion doubleValue] >= 9.1f )
// iOS10及以后
#define iOS10_OR_Later ([[UIDevice currentDevice].systemVersion doubleValue] >= 10.0 )


/*设备类型*/
// iPad
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
// iPhone
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
// 最大值
#define SCREEN_MAX_LENGTH (MAX(SCREENWIDTH, SCREENHEIGHT))
// iPhone4 iPhone4s
#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
// iPhone5 iPhone5s
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
// iPhone6 iPhone6s  iphone7
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
// iPhone6Plus iPhone6sPlus  iphone7plus
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)


/*颜色  色值*/
// 根据Red Green Blue
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
// 根据Red Green Blue Alpha
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f \
alpha:(a)]
// Red Green Blue一样
#define RGBMCOLOR(a) [UIColor colorWithRed:(a)/255.0f green:(a)/255.0f blue:(a)/255.0f alpha:1]

// 十六进制颜色值
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define RANDOMCOLOR RGBCOLOR(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
#define COlORBGRECORD DKColorPickerWithColors(DEFAULTBGCOLOR, RGBCOLOR(15, 16, 18), [UIColor whiteColor])
/*代码简化*/
// 通知中心
#define NC  [NSNotificationCenter defaultCenter]
// 本地存储
#define UD  [NSUserDefaults standardUserDefaults]
// 获取图片
#define GETIMG(name) [UIImage imageNamed:name]
// 设置字号
#define GETFONT(x) [UIFont systemFontOfSize:(x)]
// 获取屏幕
#define MainScreen [[UIScreen mainScreen] bounds]
// 屏幕宽度
#define SCREENWIDTH MainScreen.size.width

//屏幕宽度比
#define SCREENWIDTH_SCLE [[UIScreen mainScreen] bounds].size.height / 568.0

// 屏幕高度
#define SCREENHEIGHT MainScreen.size.height
// alert提示框(只有一个确定按钮)
#define ShowAlert(x) {UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:x delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil , nil];[alert show];}
// 判断返回值是否为空
#define StrIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length]<1 ? YES : NO )
// weakSelf
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

/*打印控制*/
//日志输出宏定义
#ifdef DEBUG
//调试状态
#define MyString [NSString stringWithFormat:@"%s", __FILE__].lastPathComponent
#define DLog(...) printf("%s: %s 第%d行: %s\n",[[PublicMethod getCurrentDate] UTF8String], [MyString UTF8String] ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String]);
#define DLogMethod() NSLog(@"%s", __func__)
#else
//发布状态
#define DLog(...)
#define DLogMethod()
#endif


/*常用宏*/
// 字体类型 Copperplate-Light (系统自带的字体样式)
#define FONTTYPE @"HelveticaNeue-Light"
// 导航栏 加 状态栏
#define NavStatusBarHeight (NavBarHeight + StatusBarHeight)
// 导航栏高度
#define NavBarHeight 44
//有导航控制器的时候 Tababar高度
#define NavTabBarHeight [self.navigationController.tabBarController.tabBar frame].size.height
//没导航控制器的时候 Tababar高度
#define TabBarHeight [self.tabBarController.tabBar frame].size.height
 // 状态栏高度
#define StatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height

//#define StatusBarHeight 20
// 分栏高度
//#define TabBarHeight 49
// 分页(每页条数)
#define PAGESIZE @"10"
// 视频播放器tag
#define PLAYERTAG 99999
// APP默认背景色
#define DEFAULTBGCOLOR RGBMCOLOR(242)

//RGBCOLOR(21, 103, 156);//21 103  156


// 主色 背景色 线条色
// 系统色
#define APPCOLOR  [UIColor whiteColor]//RGBCOLOR(250, 141, 45)
#define THEMECOLOR  [UIColor whiteColor] //[UIColor colorWithRed:21/255.0f green:103/255.0f blue:156/255.0f alpha:1]
#define MAINCOLOR [UIColor colorWithHex:0x216BB0]   // 主色
#define BackViewColor [UIColor colorWithHex:0xf5f5f5] // 背景颜色
#define LINECOLOR [UIColor colorWithHex:0xececec]//线条颜色
#define RandomColor  [UIColor randomColor] // 随机色


// 字体颜色
#define DEEPTintColor [UIColor colorWithHex:0x333333]//字体黑色颜色
#define TintColor [UIColor colorWithHex:0x666666]//字体灰色颜色
#define ShallowTintColor [UIColor colorWithHex:0x888888]//字体浅色颜色







// 字体灰
#define TEXTGRAY  RGBMCOLOR(153)     // 最暗字体
// 字体暗
#define TEXTDARK  RGBMCOLOR(102)     // 中等暗度字体
// 夜间模式颜色
#define BLACKBEST  RGBCOLOR(15, 16, 18)     // 最黑
#define BLACKNEXT  RGBCOLOR(30, 33, 36)     // 次黑
#define BLACKLIGHT RGBCOLOR(120, 132, 144)  // 亮黑
#define BLACKDARK  RGBCOLOR(72, 79, 86)     // 暗黑
// 首页数据库表
#define LISTTABLE @"ListTable"
// 详情页评论表
#define COMMENTTABLE @"CommentTable"
// 引导页
#define GUIDEVIEW @"Guide"
// 通知开关
#define NOTIFICATIONSWITCH @"NotificationSwitch"
#define LOCATONSHARESWITCH @"LocationShareSwitch"
#define TEXTFONTSTYLE @"TextFontStyle"

//title只有一种颜色
#define COlORTEXTWHITE_ONE DKColorPickerWithColors(RGBMCOLOR(255), RGBMCOLOR(255), RGBMCOLOR(255)) // 白亮
//导航条右边按钮颜色
#define COlORSELECT DKColorPickerWithColors(RGBMCOLOR(51), RGBCOLOR(120, 132, 144), [UIColor whiteColor])
// 导航栏
#define COLORNAV DKColorPickerWithColors(RGBCOLOR(250,141,45), RGBCOLOR(30,33,36), RGBMCOLOR(51))
// 背景
#define COlORBG DKColorPickerWithColors(DEFAULTBGCOLOR, RGBCOLOR(15, 16, 18), DEFAULTBGCOLOR)
// Cell背景
#define COlORCELLBG DKColorPickerWithColors([UIColor whiteColor], RGBCOLOR(30, 33, 36), [UIColor whiteColor])
// 线颜色
#define LINECOLOR RGBMCOLOR(237)
#define CHOOSE_BTN 40
// 判断是否问 ios 7
#define IS_IOS_7 ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)?YES:NO
// 线颜色
#define COlORLINE DKColorPickerWithColors(LINECOLOR, RGBCOLOR(15, 16, 18), RGBMCOLOR(51))
// 白色导航条标题颜色
#define COLORWHITENAV DKColorPickerWithColors(RGBMCOLOR(51), BLACKDARK, RGBMCOLOR(51))

#define RecordMaxTime 30.0f

//tabar高度
#define MainTabBarHeight 49
//
//#define TabarHeight 44
//#define BottomHeight 50
//#define NavBarHeight 0 //导航栏 加 状态栏
//#define NormalBarHeight 64
//#define statusBarHeight 20  // 状态栏
#define grayTextColor [UIColor colorWithRed:113/255.0 green:113/255.0 blue:113/255.0 alpha:1]
#define pinkTextColor [UIColor colorWithRed:21/255.0 green:103/255.0 blue:/255.0 alpha:1]
#define blackTextColor [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1]
#define DefaultFont(__scale) [UIFont systemFontOfSize:12*__scale];


//获取当前屏幕的高度
#define ConentViewHeight [UIScreen mainScreen].bounds.size.height - NavStatusBarHeight

//获取当前屏幕的宽度
#define ConentViewWidth  [UIScreen mainScreen].bounds.size.width


// 地区编码本地文件名
#define AreaFileName @"AreaList.json"
// 标签本地文件名称
#define TagFileName @"TagList.json"
// 会员等级规则文件名称
#define UserLVName @"UserLVRule.json"
// 图片压缩比例
#define ImageComRatio 0.7
//targetId
#define TARGETID @"1058"
// 手机号正则
#define REGEX [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^1\\d{10}$"]

/** @brief 登录状态变更的通知 */
#define KNOTIFICATION_LOGINSUCCESS @"loginStateChange"
 
#endif /* Common_h */

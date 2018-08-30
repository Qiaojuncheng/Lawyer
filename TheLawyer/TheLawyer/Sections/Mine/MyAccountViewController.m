//
//  MyAccountViewController.h
//  TheLawyer
//
//  Created by yaoyao on 17/7/24.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import "MyAccountViewController.h"
#import "XMyAccountCell.h"
#import "MyInfoModel.h"

typedef void(^XChangeHeadPicBlock)(UIImage *headPic);
typedef void(^XChangeSexBlock)(NSString *sex);

@interface MyAccountViewController ()<UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>

// TableView
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic,strong) MyInfoModel *infoModel;

// 数据源
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) XLoginResultModel *dataModel;

// block
@property (nonatomic, copy) XChangeHeadPicBlock xChangeHeadPicBlock;

// 头像
@property (nonatomic, copy) NSString *headImageUrl;

// 提示框
@property (nonatomic, strong) UIImagePickerController *imagePickController;

// 新昵称
@property (nonatomic, copy) NSString *nickName;


@end

@implementation MyAccountViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCenterLabelWithTitle:@"帐号信息" titleColor:[UIColor whiteColor]];

    [self initData];
    [self ReshData];
    [self.view addSubview:self.tableView];
    [self.naviBarView addSubview:self.rightButton];
}
- (void)initData {
    
    XSetVCModel *model = [XSetVCModel new];
    model.XTitle = @"头像";
    model.XSubTitle = @"";
    [self.dataArray addObject:model];
    // 姓名
    XSetVCModel *modelOne = [XSetVCModel new];
    modelOne.XTitle = @"姓名";
    modelOne.XSubTitle = @"张三";
    [self.dataArray addObject:modelOne];
    
    //从业年限
    XSetVCModel *modelTwo = [XSetVCModel new];
    modelTwo.XTitle = @"从业年限";
    modelTwo.XSubTitle = @"3年";//modelTwo
    [self.dataArray addObject:modelTwo];
    
    
    //事务所名称
    XSetVCModel *modelThree = [XSetVCModel new];
    modelThree.XTitle = @"事务所名称";
    modelThree.XSubTitle =[NSString stringWithFormat:@"汇融法事务所"];
    [self.dataArray addObject:modelThree];
    
    
    
    //出生日期
    XSetVCModel *modelFour = [XSetVCModel new];
    modelFour.XTitle = @"出生日期";
    modelFour.XSubTitle = @"1987-08-29";
    [self.dataArray addObject:modelFour];
    
    //职业证号
    
    XSetVCModel *modelFive = [XSetVCModel new];
    modelFive.XTitle = @"职业证号";
    modelFive.XSubTitle = @"2560865943";
    [self.dataArray addObject:modelFive];
    //擅长领域
    XSetVCModel *modelSix = [XSetVCModel new];
    modelSix.XTitle = @"擅长领域";
    modelSix.XSubTitle = @"劳务合同";
    [self.dataArray addObject:modelSix];
    //积分等级
    XSetVCModel *modelSeven = [XSetVCModel new];
    modelSeven.XTitle = @"积分等级";
    modelSeven.XSubTitle = @"1000积分";
    [self.dataArray addObject:modelSeven];

}
- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.backgroundColor = [UIColor clearColor];
        _rightButton.frame = CGRectMake(SCREENWIDTH-50, 20, 44, 44);
        [_rightButton setNormalTitle:@"保存"];
        [_rightButton setTitleColor:[UIColor whiteColor]];
        [_rightButton.titleLabel setNormalFont:15.0f];
        [_rightButton addClickTarget:self action:@selector(rightBar_Touched:)];
    }
    return _rightButton;
}

- (void)rightBar_Touched:(id)sender
{
    DLog(@"保存帐号信息");
}

//刷新数据
-(void)ReshData
{
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:hud];
    [self.view bringSubviewToFront:hud];
    hud.labelText = @"拼命加载中";
    hud.removeFromSuperViewOnHide = YES;
    [hud show:YES];
    //action、value
    NSDictionary *dic = @{
                          @"user_id":UserId
                          };
    
    NSError *dataError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:(NSJSONWritingOptions)0 error:&dataError];
    NSString *body = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    DLog(@"%@",body);
    NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [data base64EncodedStringWithOptions:0];
    DLog(@"%@",base64String);
    
    NSDictionary *parameter= @{
                               @"action":[NSString stringWithFormat:@"App/Lawyer/ziliao"],
                               @"value":base64String
                               };
    
    DLog(@"%@",parameter);
    WS(ws);
    [AFManagerHelp POST:BASE_URL parameters:parameter success:^(id responseObjeck) {
        // 处理数据
        DLog(@"%@",responseObjeck);
        [hud hide:YES];
        if ([responseObjeck[@"status"] integerValue] == 0) {
            _tableView.hidden = NO;
//            [UD setValue:[NSString stringWithFormat:@"%@",responseObjeck[@"data"][@"userid"]] forKey:@"userid"];
//            [UD setValue:[NSString stringWithFormat:@"%@",responseObjeck[@"data"][@"phone"]] forKey:@"phone"];
//            [UD setValue:[NSString stringWithFormat:@"%@",ws.passwordField.text] forKey:@"pass"];
//            
//            
//            [UD synchronize];
            ws.infoModel = [MyInfoModel mj_objectWithKeyValues:responseObjeck[@"data"]];
            [ws.tableView reloadData];
            [ws.tableView.mj_header endRefreshing];
            [ws.tableView.mj_footer resetNoMoreData];
            [ws.tableView.mj_footer endRefreshing];
        }else{
            [ShowHUD showWYBTextOnly:responseObjeck[@"msg"] duration:2 inView:ws.view];
        }
    } failure:^(NSError *error) {
        [hud hide:YES];
        [ShowHUD showWYBTextOnly:@"你的网络好像不太给力\n请稍后再试" duration:2 inView:ws.view];
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
//    [self ReshData];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavStatusBarHeight, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStylePlain];//UITableViewStyleGrouped
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.hidden = YES;
        _tableView.showsVerticalScrollIndicator = NO;
        
        // 注册
        [self.tableView registerClass:[XMyAccountCell class] forCellReuseIdentifier:@"XMyAccountCell"];
    }
    return _tableView;
}
// 数据源
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


- (XLoginResultModel *)dataModel {
    if (!_dataModel) {
        _dataModel = [XLoginResultModel new];
    }
    return _dataModel;
}

- (UIImagePickerController *)imagePickController {
    if (!_imagePickController) {
        _imagePickController = [[UIImagePickerController alloc] init];
        
        _imagePickController.delegate = self;
        _imagePickController.allowsEditing = YES;
    }
    return _imagePickController;
}


#pragma mark -- UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 74;
    } else {
        
        return 48;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
        return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        XMyAccountCell *cell = [XMyAccountCell new];
        cell.headView.hidden = NO;
        cell.subTitleLabel.hidden = YES;
        cell.titleLabel.text = @"头像";
        [cell.headView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.tempModel.avatar]] placeholderImage:[UIImage imageNamed:@"头像"]];
        self.xChangeHeadPicBlock = ^(UIImage *headPic){
            [cell.headView setImage:headPic];
        };
        return cell;
    } else  if (indexPath.row ==1){
        XMyAccountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XMyAccountCell"];
        cell.titleLabel.text = [NSString stringWithFormat:@"姓名："];
        cell.subTitleLabel.text = [NSString stringWithFormat:@"%@",self.infoModel.name];

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row==2) {
        XMyAccountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XMyAccountCell"];
        cell.titleLabel.text = [NSString stringWithFormat:@"从业年限："];
        cell.subTitleLabel.text = [NSString stringWithFormat:@"%@",self.infoModel.worktime];
        return cell;
    }else if (indexPath.row ==3){
        XMyAccountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XMyAccountCell"];
        cell.titleLabel.text = [NSString stringWithFormat:@"事务所名称："];
        cell.subTitleLabel.text = [NSString stringWithFormat:@"%@",self.infoModel.company];
        //company
        return cell;
    }else if (indexPath.row==4) {
        XMyAccountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XMyAccountCell"];
        cell.titleLabel.text = [NSString stringWithFormat:@"出生日期："];
        cell.subTitleLabel.text = [NSString stringWithFormat:@"%@",self.infoModel.birth];
        return cell;
    }else if (indexPath.row ==5){
        XMyAccountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XMyAccountCell"];
        cell.titleLabel.text = [NSString stringWithFormat:@"执业证号："];
        cell.subTitleLabel.text = [NSString stringWithFormat:@"%ld",(long)self.infoModel.lawyercode];
        return cell;
    }else if (indexPath.row==6) {
        XMyAccountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XMyAccountCell"];
        cell.titleLabel.text = [NSString stringWithFormat:@"擅长领域："];
        cell.subTitleLabel.text = [NSString stringWithFormat:@"%@",self.infoModel.lingyu];
        return cell;
    }else{
        XMyAccountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XMyAccountCell"];
        cell.titleLabel.text = [NSString stringWithFormat:@"积分等级："];
        cell.subTitleLabel.text = [NSString stringWithFormat:@"%@",self.infoModel.jf];
        return cell;
    }

    
}

#pragma mark -- cell点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 设置选中动画
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        // 修改头像
        if (iOS8) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"更改头像" message:nil preferredStyle: UIAlertControllerStyleActionSheet];
            
            __weak typeof(self) weakSelf = self;
            UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                DLog(@"拍照");
                
                [weakSelf addPicEventWithSourceType:UIImagePickerControllerSourceTypeCamera];
            }];
            
            UIAlertAction *pictureAction = [UIAlertAction actionWithTitle:@"从图库选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                DLog(@"图库");
                
                [weakSelf addPicEventWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            }];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                DLog(@"取消");
            }];
            
            [alert addAction:photoAction];
            [alert addAction:pictureAction];
            [alert addAction:cancelAction];
            
            //弹出提示框；
            [self presentViewController:alert animated:YES completion:nil];
        } else {
            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"更改头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从图库选择", nil];
            
            actionSheet.tag = 120;
            actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
            [actionSheet showInView:self.view];

        }
        
        
        
    } else if (indexPath.section == 0 && indexPath.row == 1) {
        //姓名
    } else if (indexPath.section == 0 && indexPath.row == 2) {
        // 从业年限
    } else if (indexPath.section == 0 && indexPath.row == 3) {
        //事务所名称
        
    }else if (indexPath.section == 0 && indexPath.row == 4) {
        //出生日期
        
    } else if (indexPath.section == 0 && indexPath.row == 5) {
        //执业证号
    }else if (indexPath.section == 0 && indexPath.row == 4) {
        //擅长领域
        
    } else if (indexPath.section == 0 && indexPath.row == 5) {
        //积分
    }
    
}


#pragma mark -- 调用系统相机
// 调用相机
- (void) addPicEventWithSourceType:(UIImagePickerControllerSourceType)sourceType
{
    // 先设定sourceType为相机，然后判断相机是否可用（ipod）没相机，不可用将sourceType设定为相片库
    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    self.imagePickController.sourceType = sourceType;
    
    [self presentViewController:self.imagePickController animated:YES completion:^{
        
    }];
}

// delegate
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    
    [self performSelector:@selector(saveImage:)
               withObject:image
               afterDelay:0.5];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

// 照片处理
- (void)saveImage:(UIImage *)image {
#warning mark   先不请求网络
    
    //是否将照片保存到相册
//    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    
    /*
     {
     "param": {
     "UserId":1                         //用户ID
     "AvatarPicUrl": "13512345678.jpg", //头像
     }
     }
     
     */
    
//    NSDictionary *dic = @{
//                          @"uploadType":@"6"
//                          };
    // 上传
    NSData *imageData = UIImageJPEGRepresentation(image, 0.1);
    __weak typeof(self) weakSelf = self;
    
    [AFManagerHelp asyncUploadFileWithData:imageData name:@"FileUpLoad" fileName:@"HeadPic.jpg" mimeType:@"image/jpeg" parameters:nil success:^(id responseObject) {
        DLog(@"%@",responseObject);

        NSString *urlString = responseObject[@"result"][@"url"];
        
        // 修改图片
        if (weakSelf.xChangeHeadPicBlock) {
            weakSelf.xChangeHeadPicBlock(image);
        }

#warning 修改头像接口
        DLog(@"%@", urlString);
        NSDictionary *dic = @{@"param":@{
                                      @"UserId":[UD valueForKey:@"userID"],
                                      @"AvatarPicUrl":urlString}
                              };
        DLog(@"%@",[UD valueForKey:@"userID"]);
    
        [AFManagerHelp POST:@"xcvbnm" parameters:dic success:^(id responseObjeck) {
            if ([responseObject[@"errorCode"] integerValue] == 0) {
                DLog(@"%@",responseObject);
                // 修改图片
                if (self.xChangeHeadPicBlock) {
                    self.xChangeHeadPicBlock(image);
                }
                [ShowHUD showWYBTextOnly:@"修改成功" duration:2 inView:self.view];
            } else {
                DLog(@"修改失败，%@", responseObject);
                [ShowHUD showWYBTextOnly:@"修改失败" duration:2 inView:self.view];
            }
        } failure:^(NSError *error) {
            DLog(@"修改失败，error:%@", error);
            [ShowHUD showWYBTextOnly:@"你的网络好像不太给力\n请稍后再试" duration:2 inView:self.view];
        }];
        
    } failture:^(NSError *error) {
        DLog(@"上传失败，error:%@", error);
    }];
    
}

#pragma mark -- 昵称输入框内容改变事件
- (void)ifTFHasChange:(UITextField *)sender {
    self.nickName = sender.text;
}

#pragma mark -- actionSheet
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (actionSheet.tag == 120) {
        // 头像
        if (buttonIndex == 0) {
            // 拍照
            [self addPicEventWithSourceType:UIImagePickerControllerSourceTypeCamera];
        } else if (buttonIndex == 1) {
            // 图库
            [self addPicEventWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        }
        
    } else if (actionSheet.tag == 121) {
        // 性别
        if (buttonIndex == 0) {
            // 男
//            [self setUserSex:@0];
        } else if (buttonIndex == 1) {
            // 女
//            [self setUserSex:@1];
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  PerfectViewController.m
//  TheLawyer
//
//  Created by yaoyao on 17/8/3.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import "PerfectViewController.h"
#import "InfoModel.h"
#import "QJInfoCell.h"
#import "QJSelectCell.h"
 #import "QJSelectArea.h"
#import "QJCSelectView.h"
#import "QJCSelectLingyuCell.h"

#import "QJCperfectsexCell.h"
#import "QJCIntroCell.h"


@interface PerfectViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UITextViewDelegate>{
    UITableView *_tableview;
    NSMutableArray * TitileDataArray;
    NSMutableArray * textplacholdArray;
    
    NSMutableArray * Titile;
    InfoModel * MyInfomodel;// 个人信息model
    UIImage * selcetedImage;
    UIImagePickerController *_picker;
    NSString * imageString;// 选中的图片
    NSString * SelectDateStr;// 选中的日期
    NSMutableDictionary * valueDic;
    QJSelectArea * selectAreaPick;// 区域选择器
    NSString * selectAreaId;//选中的 地区id
    NSString * selectAreaStr; //选中的 地区
    
    QJCSelectView * selectLingyuPick;//    领域选择器
    NSString * selectLingyuId;
    NSMutableArray * LingyuDataArray; // 领域的数据源
    NSMutableArray * LingyuIdDataArray;// 领域的id数组
    NSMutableArray * LingyuNameDataArray; // 领域的名字数组
    
}
@end

@implementation PerfectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MyInfomodel =[[InfoModel alloc]init];
    [self addCenterLabelWithTitle:@"完善信息" titleColor:[UIColor whiteColor]];
    [self makeUI];
    [self makeLawyerCategory];
     valueDic =[[NSMutableDictionary alloc]init];
    LingyuNameDataArray =[[NSMutableArray alloc]init];
    LingyuIdDataArray =[[NSMutableArray alloc]init];
    // Do any additional setup after loading the view.
}
-(void)makeUI{
    TitileDataArray =[[NSMutableArray alloc]initWithObjects:@"头像",@"真实姓名",@"性别",@"个人简介",@"单位名称",@"职务",@"邮箱",@"常驻城市",@"详细地址",@"执业证号",@"发证机关",@"从业年限",@"擅长领域",@"电话预约价格",@"见面预约价格",nil];
    textplacholdArray =[[NSMutableArray alloc]initWithObjects:@"头像",@"姓名",@"性别",@"请输入个人简介",@"请输入单位名称",@"请输入职务",@"请输入邮箱",@"请选择常驻城市",@"请输入详细地址",@"请输入执业证号",@"请输入发证机关",@"请输入从业年限",@"请选择擅长领域",@"价格",@"价格",nil];
    _tableview =[[UITableView alloc]initWithFrame:CGRectMake(0, NavStatusBarHeight, SCREENWIDTH, SCREENHEIGHT - NavStatusBarHeight) style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    
    UIView * footView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 100)];
    UIButton * changeBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    changeBtn.frame = CGRectMake(30, 30, SCREENWIDTH - 60, 40);
    [changeBtn setTitle:@"提交审核" forState:UIControlStateNormal];
    changeBtn.backgroundColor = THEMECOLOR;
    [changeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [footView addSubview:changeBtn];
    [Utile makeCorner:6 view:changeBtn];
    [changeBtn addTarget:selectAreaStr action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
    _tableview.tableFooterView =footView;
    
    [self.view addSubview:_tableview];
}
-(void)saveAction{
    
    NSMutableDictionary * dic  =[[NSMutableDictionary alloc]init];
    QJCADDPERSONINFO
    
    [valueDic setObject:self.PersonId forKey:@"user_id"];
     [valueDic setObject:[LingyuIdDataArray componentsJoinedByString:@","] forKey:@"category"];
 
    
    NSString * baseStr = [NSString getBase64StringWithArray:valueDic];
    [dic setValue:baseStr forKey:@"value"];
    [HttpAfManager postWithUrlString:BASE_URL parameters:dic success:^(id data) {
        NSLog(@"%@",data);
        NSString * status = [NSString stringWithFormat:@"%@",data[@"status"]];
        if ([status isEqualToString:@"0"]) {
            [self showHint:@"完善信息成功,等待管理员审核！"];
            [UD setValue:[NSString stringWithFormat:@"%@",self.PersonId] forKey:@"userid"];
            [UD setValue:[NSString stringWithFormat:@"%@",data[@"data"][@"lawyer_id"]] forKey:@"lawyer_id"];

            
            
            [UD synchronize];
            [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINSUCCESS object:@(YES)];

        }else{
            [self showHint:data[@"msg"]];
        }
        
    } failure:^(NSError *error) {
        
        [self showHint:@"完善信息失败"];
        
    }];
    
    
}
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return TitileDataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        QJSelectCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell ==  nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"QJSelectCell" owner:self options:nil]lastObject];
        }
        cell.NameLB.text = TitileDataArray[indexPath.row];
        if (selcetedImage) {
            cell.HeaderImage.image = selcetedImage;
        }else{
            [cell.HeaderImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_URL,MyInfomodel.avatar]] placeholderImage:[UIImage imageNamed:@"touxiang"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                NSData *data = UIImageJPEGRepresentation(image, 0.001);
                imageString = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
                
                [valueDic setValue:imageString forKey:@"avatar"];
                
            }];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 2){
        QJCperfectsexCell * cell =[[[NSBundle mainBundle] loadNibNamed:@"QJCperfectsexCell" owner:self options:nil]lastObject];
        if ([MyInfomodel.sex isEqualToString:@"1"]) {
            cell.manBtn.selected = YES;
            [valueDic setObject:@"1" forKey:@"sex"];
            MyInfomodel.sex = @"1";

        }else{
            cell.womanBtn.selected = YES;
            [valueDic setObject:@"2" forKey:@"sex"];
            MyInfomodel.sex = @"2";

        }

        cell.SelectBlock = ^(NSInteger SexIndex) {
            [valueDic setObject:[NSString stringWithFormat:@"%ld",SexIndex] forKey:@"sex"];
            MyInfomodel.sex = [NSString stringWithFormat:@"%ld",SexIndex];
            if (SexIndex ==1) {
                 NSLog(@"男");
            }else{
                NSLog(@"女");
            }
        };
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 3){
        QJCIntroCell * cell =[[[NSBundle mainBundle] loadNibNamed:@"QJCIntroCell" owner:self options:nil]lastObject];
        cell.IntroTextVeiw.placeholderText = textplacholdArray[indexPath.row];
        cell.IntroTextVeiw.text = MyInfomodel.instru;
        cell.IntroTextVeiw.delegate = self;
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
        return cell;
    }else if(indexPath.row == 12){
        QJCSelectLingyuCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell9"];
        if (cell ==  nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"QJCSelectLingyuCell" owner:self options:nil]lastObject];
        }
        if (LingyuNameDataArray.count >  0) {
            cell.DetailTextFiled.hidden = YES;
        }else{
            cell.DetailTextFiled.hidden = NO;
            
        }
        WS(ws)
        cell.NameLB.text = TitileDataArray[indexPath.row];
        [cell.BackScroller whenTapped:^{
            selectLingyuPick =[[QJCSelectView alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, 250)];
            [self.view addSubview:selectLingyuPick];
            selectLingyuPick.dataArray = LingyuDataArray;
            [selectLingyuPick ShowPicker];
            __block  UITableView * WeakTv = _tableview;
            
            selectLingyuPick.CertainBlock = ^(BOOL IsCertain, NSString *dateString, NSString *prvId, NSString *cityId, NSString *AreaId) {
                
                if (IsCertain) {
                    if (LingyuIdDataArray.count > 2) {
                        [ws showHint:@"最多可以选择三个领域"];
                        return ;
                    }
                    NSArray * nameArray =[dateString componentsSeparatedByString:@" "];
                     if (nameArray.count == 1) {
                        if (![LingyuIdDataArray containsObject:prvId]) {
                            [LingyuIdDataArray addObject:prvId];
                            [LingyuNameDataArray addObject:[nameArray lastObject]];
                        }
                         
                     }else if (nameArray.count ==2){
                        if (![LingyuIdDataArray containsObject:cityId]) {
                            [LingyuIdDataArray addObject:cityId];
                            [LingyuNameDataArray addObject:[nameArray lastObject]];
                        }
                    }else if (nameArray.count ==3){
                        if (![LingyuIdDataArray containsObject:AreaId]) {
                            [LingyuIdDataArray addObject:AreaId];
                            [LingyuNameDataArray addObject:[nameArray lastObject]];
                        }
                    }
                    NSString * SelectlingyuidStr =[LingyuIdDataArray componentsJoinedByString:@","];
                    
                    [WeakTv reloadData];
                }else{
                    
                }
            };
            
        }];
        cell.DetailTextFiled.enabled = NO;
        cell.DetailTextFiled.placeholder = textplacholdArray[indexPath.row];
        [cell makeLabelDataArray:LingyuNameDataArray];
        cell.ClearBlock = ^(NSInteger index) {
            [LingyuNameDataArray removeObjectAtIndex:index];
            [LingyuIdDataArray removeObjectAtIndex:index];
            
            [_tableview reloadData];
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        QJInfoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cellid"];
        if (cell ==  nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"QJInfoCell" owner:self options:nil]lastObject];
        }
        cell.DetailTextFiled.enabled = YES;
        cell.DetailTextFiled.delegate= self;
        cell.DetailTextFiled.tag = 60+indexPath.row;
        if (indexPath.row == 1) {
            cell.DetailTextFiled.text = [NSString changeNullString:MyInfomodel.name];
        }else if (indexPath.row == 4){
            cell.DetailTextFiled.text = [NSString changeNullString:MyInfomodel.company];
            
        }
        else if (indexPath.row == 5){
            cell.DetailTextFiled.text = [NSString changeNullString:MyInfomodel.offer];
            
        }
        else if (indexPath.row ==  6){
            cell.DetailTextFiled.text = [NSString changeNullString:MyInfomodel.email];
            
        }
        
        else if (indexPath.row ==  7){
            cell.DetailTextFiled.text = [NSString changeNullString:MyInfomodel.region];
            
        }
        else if (indexPath.row ==8){
            cell.DetailTextFiled.text = [NSString changeNullString:MyInfomodel.address];
            
        }
        else if (indexPath.row == 9 ){
            cell.DetailTextFiled.text = [NSString changeNullString:MyInfomodel.lawyer_code];
            
        }else if (indexPath.row == 10){
            cell.DetailTextFiled.text = [NSString changeNullString:MyInfomodel.lawyer_codeOrgan];
  
        }
        else if (indexPath.row == 11){
            cell.DetailTextFiled.text = [NSString changeNullString:MyInfomodel.work_time];
            
        }else if (indexPath.row == 12){
            cell.DetailTextFiled.text = [NSString changeNullString:MyInfomodel.lingyu];
            
        }else if (indexPath.row == 13){
            cell.DetailTextFiled.text = [NSString changeNullString:MyInfomodel.phone_price];
            
        }else if (indexPath.row == 14){
            cell.DetailTextFiled.text = [NSString changeNullString:MyInfomodel.meet_price];
            
        }
        
        cell.NameLB.text = TitileDataArray[indexPath.row];
        cell.DetailTextFiled.enabled = YES;
        
        if (  indexPath.row == 7 || indexPath.row == 12) {
            cell.DetailTextFiled.enabled = NO;
        }
        cell.DetailTextFiled.placeholder = textplacholdArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WS(ws);
    if (indexPath.row == 0) {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"拍照上传" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (!_picker) {
                _picker = [[UIImagePickerController alloc]init];
            }
            _picker.delegate = self;
            _picker.allowsEditing = YES;
            //        _picker.videoQuality = UIImagePickerControllerQualityTypeLow;
            self.modalPresentationStyle=UIModalPresentationOverCurrentContext;
            _picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:_picker animated:YES completion:^{
                
            }];
        }];
        UIAlertAction *secondAction = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.delegate = self;
            picker.allowsEditing = YES;
            [self presentViewController:picker animated:YES completion:^{
                
            }];
            
        }];
        UIAlertAction *thiredAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertC addAction:firstAction];
        [alertC addAction:secondAction];
        [alertC addAction:thiredAction];
        [self presentViewController:alertC animated:YES completion:^{
        }];
    }else if (indexPath.row == 7 ){
        
        selectAreaPick =[[QJSelectArea alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, 250)];
        [self.view addSubview:selectAreaPick];
        
        [selectAreaPick ShowAreaPicker];
        __block  UITableView * WeakTv = _tableview;
        
        selectAreaPick.CertainBlock = ^(BOOL IsCertain, NSString *dateString, NSString *prvId, NSString *cityId, NSString *AreaId) {
            if (IsCertain) {
                selectAreaId = [NSString stringWithFormat:@"%@,%@,%@",prvId,cityId,AreaId] ;
                MyInfomodel.region  = dateString;
                MyInfomodel.provice = prvId;
                MyInfomodel.city = cityId;
                MyInfomodel.area = AreaId;
                [valueDic setObject:prvId forKey:@"province"];
                [valueDic setObject:cityId forKey:@"city"];
                [valueDic setObject:AreaId forKey:@"area"];

                [WeakTv reloadData];
            }else{
                
            }
        };
        
    }else if (indexPath.row == 12 ){
        
        selectLingyuPick =[[QJCSelectView alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, 250)];
        [self.view addSubview:selectLingyuPick];
        selectLingyuPick.dataArray = LingyuDataArray;
        [selectLingyuPick ShowPicker];
        __block  UITableView * WeakTv = _tableview;
        
        selectLingyuPick.CertainBlock = ^(BOOL IsCertain, NSString *dateString, NSString *prvId, NSString *cityId, NSString *AreaId) {
            
            if (IsCertain) {
                if (LingyuIdDataArray.count > 2) {
                    [ws showHint:@"最多可以选择三个领域"];
                    return ;
                }
                NSArray * nameArray =[dateString componentsSeparatedByString:@" "];
                if (nameArray.count == 1) {
                    if (![LingyuIdDataArray containsObject:prvId]) {
                  [LingyuIdDataArray addObject:prvId];
                    [LingyuNameDataArray addObject:[nameArray lastObject]];
                    }
                }else if (nameArray.count ==2){
                     if (![LingyuIdDataArray containsObject:cityId]) {
                    [LingyuIdDataArray addObject:cityId];
                         [LingyuNameDataArray addObject:[nameArray lastObject]];
                     }
                }else if (nameArray.count ==3){
                    if (![LingyuIdDataArray containsObject:AreaId]) {
                     [LingyuIdDataArray addObject:AreaId];
                        [LingyuNameDataArray addObject:[nameArray lastObject]];
                    }
                }
                [WeakTv reloadData];
            }else{
                
            }
        };
        
    }
}
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        
        selcetedImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        UIImageOrientation imageOrientation=selcetedImage.imageOrientation;
        if(imageOrientation!=UIImageOrientationUp)
        {
            // 原始图片可以根据照相时的角度来显示，但UIImage无法判定，于是出现获取的图片会向左转９０度的现象。
            // 以下为调整图片角度的部分
            UIGraphicsBeginImageContext(selcetedImage.size);
            [selcetedImage drawInRect:CGRectMake(0, 0, selcetedImage.size.width, selcetedImage.size.height)];
            selcetedImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            // 调整图片角度完毕
        }
    }else
    {
        selcetedImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        UIImageOrientation imageOrientation=selcetedImage.imageOrientation;
        if(imageOrientation!=UIImageOrientationUp)
        {
            // 原始图片可以根据照相时的角度来显示，但UIImage无法判定，于是出现获取的图片会向左转９０度的现象。
            // 以下为调整图片角度的部分
            UIGraphicsBeginImageContext(selcetedImage.size);
            
            [selcetedImage drawInRect:CGRectMake(0, 0, selcetedImage.size.width, selcetedImage.size.height)];
            selcetedImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            // 调整图片角度完毕
        }
    }
    NSData *data = UIImageJPEGRepresentation(selcetedImage, 0.001);
    [_tableview reloadData];
    
    imageString = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    [valueDic setValue:imageString forKey:@"avatar"];
    //    self.perImg.image = selcetedImage;
    NSLog(@"选中的图片！在这里");
    [self dismissViewControllerAnimated:NO completion:^{
        //        [self requestDataZiLiao];
    }];
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 3) {
        return 120;
    }
    return 50;
}
 //业务领域三级联动
 -(void)makeLawyerCategory{
    NSMutableDictionary * dic  =[[NSMutableDictionary alloc]init];
    QJCQICATEGORY
    NSMutableDictionary *   valueDic =[[NSMutableDictionary alloc]init];
    NSString * baseStr = [NSString getBase64StringWithArray:valueDic];
    [dic setValue:baseStr forKey:@"value"];
    [HttpAfManager postWithUrlString:BASE_URL parameters:dic success:^(id data) {
        NSLog(@"%@",data);
        NSString * status = [NSString stringWithFormat:@"%@",data[@"status"]];
        if ([status isEqualToString:@"0"]) {
            LingyuDataArray = [[NSMutableArray alloc]initWithArray:data[@"data"]];
        }
        
    } failure:^(NSError *error) {
    }];
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    
    MyInfomodel.instru = textView.text;
    if (textView.text.length > 0) {
        [valueDic setObject:textView.text forKey:@"instru"];
    }
    
}
 -(void)textFieldDidEndEditing:(UITextField *)textField{
     
       if (textField.tag == 61) {
         MyInfomodel.name = textField.text;
           [valueDic setObject:textField.text forKey:@"name"];
       }else if (textField.tag == 64) {
           MyInfomodel.company = textField.text;
           [valueDic setObject:textField.text forKey:@"company"];

       }else if (textField.tag == 65) {
           MyInfomodel.offer = textField.text;
           [valueDic setObject:textField.text forKey:@"offer"];
           
       }else if (textField.tag == 66) {
           MyInfomodel.email = textField.text;
           [valueDic setObject:textField.text forKey:@"email"];
           
       }else if (textField.tag == 69) {
           MyInfomodel.lawyer_code = textField.text;
           [valueDic setObject:textField.text forKey:@"lawyer_code"];
       }else if (textField.tag == 68) {
           MyInfomodel.address = textField.text;
           [valueDic setObject:textField.text forKey:@"address"];
       }
    else if (textField.tag == 70) {
        MyInfomodel.lawyer_codeOrgan = textField.text;
        [valueDic setObject:textField.text forKey:@"authority"];
    }
    else if (textField.tag == 71) {
        MyInfomodel.work_time = textField.text;
        [valueDic setObject:textField.text forKey:@"work_time"];
    }
    else if (textField.tag == 73) {
        MyInfomodel.phone_price = textField.text;
        [valueDic setObject:textField.text forKey:@"phone_price"];
    }  else if (textField.tag == 74) {
        MyInfomodel.meet_price = textField.text;
        [valueDic setObject:textField.text forKey:@"meet_price"];
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

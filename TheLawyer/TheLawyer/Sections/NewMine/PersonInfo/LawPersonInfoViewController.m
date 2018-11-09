//
//  LawPersonInfoViewController.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/21.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawPersonInfoViewController.h"
#import "LawInfoCell.h"
#import "LawInforImageCell.h"
#import "LawPlatformAuthViewController.h"
#import "LawBankCardViewController.h"

#import "LawChagebasicInfoVC.h"
#import "LawChangeSexViewController.h"
#import "LawSeletAreaViewController.h"
#import "LawJCImageSelect.h"
#import "LawPlatformModel.h"
@interface LawPersonInfoViewController ()<selectImagedelegate,UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray * dataArrray ;
    UITableView * _tableView;
    NSArray * titleArray;
    NSArray * contentArray;
    LawPlatformModel * platforModel;
}


@end

@implementation LawPersonInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCenterLabelWithTitle:@"个人信息" titleColor:nil];
    titleArray = @[@"头像",@"姓名",@"性别",@"联系电话",@"地区",@"银行卡"];
      self.view.backgroundColor  =   BackViewColor;
    
     [self addView];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [self makePersonInfo];
}
-(void)addView{
    
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0,  NavStatusBarHeight+1  , SCREENWIDTH, SCREENHEIGHT  -  NavStatusBarHeight  -1) style:UITableViewStylePlain];
    _tableView.delegate=  self;
    _tableView.backgroundColor = BackViewColor;
    _tableView.dataSource = self;
    _tableView.separatorInset = UIEdgeInsetsMake(0,SCREENWIDTH, 0, 0);
    _tableView.tableFooterView = [[UIView alloc]init];
  
     [self.view addSubview:_tableView];
}
 -(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     if(section==0){
         return  titleArray.count;
     }else{
         return 1;
     }
     
 
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return  0.01;
    }else{
        return 10;
    }
 
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return [[UIView alloc]init];
    }else{
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 10)];
        headerView.backgroundColor = BackViewColor;
        return headerView;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0){
        if(indexPath.row == 0){
        LawInforImageCell  * cell  =[tableView dequeueReusableCellWithIdentifier:@"cells"];
        if (cell == nil) {
            cell  =[[[NSBundle mainBundle ]loadNibNamed:@"LawInforImageCell" owner:self options:nil]lastObject];
        }
            if (self.infoModel.avatar) {
                [cell.PersonImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_URL,self.infoModel.avatar]] placeholderImage:[UIImage imageNamed:@"touxiang"]];
            }
             cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell ;
        }
        else{
            LawInfoCell  * cell  =[tableView dequeueReusableCellWithIdentifier:@"cell"];

            if (cell == nil) {
                cell  =[[[NSBundle mainBundle ]loadNibNamed:@"LawInfoCell" owner:self options:nil]lastObject];
            }
            
            cell.RightImg.hidden  =  NO ;

            cell.TypeLB.text =[NSString stringWithFormat:@"%@",titleArray[indexPath.row]];
//            cell.ConcentLB.text =[NSString stringWithFormat:@"%@",contentArray[indexPath.row]];
             cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.LineView.hidden = NO;
            if (indexPath.row == titleArray.count -1) {
                cell.LineView.hidden = YES;

            }
            if (indexPath.row == 1) {
                cell.ConcentLB.text = self.infoModel.name?self.infoModel.name:@"姓名";
            }else if (indexPath.row ==2){
            cell.ConcentLB.text = [self.infoModel.sex isEqualToString:@"1"] ?@"男":@"女";
            }else if (indexPath.row ==3){
                cell.ConcentLB.text = self.infoModel.phone?self.infoModel.phone:@"";
                cell.RightImg.hidden = YES;
//                cell.accessoryType = UITableViewCellAccessoryNone;
             }else if (indexPath.row ==4){
                 
                 cell.ConcentLB.text = self.infoModel.area?[NSString stringWithFormat:@"%@ %@ %@",self.infoModel.province,self.infoModel.city,self.infoModel.area]:@"";

             }else if (indexPath.row ==5){
                 cell.ConcentLB.text = [self.infoModel.is_bind isEqualToString:@"1"]?@"已绑定":@"未绑定";

             }
            
            return  cell ;
        }
    }else if(indexPath.section == 1){
        LawInfoCell  * cell  =[tableView dequeueReusableCellWithIdentifier:@"cells"];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle ]loadNibNamed:@"LawInfoCell" owner:self options:nil]lastObject];
        }
        cell.TypeLB.text =[NSString stringWithFormat:@"平台认证"];
         if ([self.infoModel.renzheng isEqualToString:@"0"]) {
            cell.ConcentLB.text = @"去认证";
             cell.RedView.hidden = NO;

        }else if ([self.infoModel.renzheng isEqualToString:@"1"]){
            cell.ConcentLB.text = @"审核中";
            cell.RedView.hidden = NO;

        }else{
            cell.ConcentLB.text = @"已认证";
            cell.RedView.hidden = YES;
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.LineView.hidden = YES;
        return  cell ;
        
    }
    
    return [[UITableViewCell alloc]init];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==1) {
        if (indexPath.row == 0) {
            LawPlatformAuthViewController * law =[[LawPlatformAuthViewController alloc]init];
            law.model = platforModel;
            if([self.infoModel.renzheng isEqualToString:@"1"]){
                law.CanEidt  = NO ;
//                law.CanEidt  = YES ;

            }else{
                law.CanEidt  = YES ;
            }
            
            [self.navigationController pushViewController:law animated:YES];
        }
    }else{
        if(indexPath.row == 0){
            LawJCImageSelect * selectImage =[LawJCImageSelect defaultSelectImage];
            selectImage.delegate = self;
         [ selectImage showInViewController:self];
        }
      else  if ( indexPath.row == 1){
//            LawChagebasicInfoVC * changeName =[[LawChagebasicInfoVC alloc]init];
         
          LawChagebasicInfoVC * changeName =[[LawChagebasicInfoVC alloc]init];


          changeName.titleStr =@"修改昵称";
            changeName.placherStr= self.infoModel.name?self.infoModel.name:@"请输入您的名字";
          
          changeName.ChangValue = ^(NSString *changeValueStr) {
                 [self   ChangInformationWithDic:@{@"name":changeValueStr} ];

             };
            [self.navigationController pushViewController:changeName animated:YES];
        }else if(indexPath.row == 2){
            LawChangeSexViewController * lawSex =[[LawChangeSexViewController alloc]init];
            //           判断显示
            lawSex.sex = self.infoModel.sex;
            lawSex.SexBlock = ^(NSString *sexStr) {
                [self   ChangInformationWithDic:@{@"sex":sexStr} ];
            };
            [self.navigationController pushViewController:lawSex animated:YES];
            
        } else if(indexPath.row == 4 ){
            LawSeletAreaViewController * area =[[LawSeletAreaViewController alloc]init];
           
            area.ProviStr =self.infoModel.province;
            area.CityStr =self.infoModel.city;
            area.AreaStr =self.infoModel.area;
 
            
            
            area.SelectAreaBlock = ^(NSString *Proid, NSString *Cityid, NSString *Areamid, NSString *areaStr) {
                [self   ChangInformationWithDic:@{@"province":Proid,@"city":Cityid,@"area":Areamid} ];

            };
            [self.navigationController pushViewController:area animated:nil];
        }else if (indexPath.row == 5){
            LawBankCardViewController * card =[[LawBankCardViewController alloc]init];
            [self.navigationController pushViewController:card animated:YES];
            
        }
        
    }
    
    
//    LawCaseAppreciateDetail * detail =[[LawCaseAppreciateDetail alloc]init];
//    [self.navigationController pushViewController:detail animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0 && indexPath.row == 0){
        return 100;
    }else{
        return 60;
    }
}

#pragma mark  选择图片的代理
-(void)seleWithImage:(UIImage *)selectImage{
    
    NSData   * imageData  = UIImageJPEGRepresentation(selectImage, 0.01);
    
    NSMutableDictionary *valuedic =[[NSMutableDictionary alloc]init];
    [valuedic setValue:UserId forKey:@"lawyer_id"];
    
    NSString * base64String =[NSString getBase64StringWithArray:valuedic];
    
    NSMutableDictionary  *dic =[[NSMutableDictionary alloc]init] ;
    NewAddInfor ;
    [dic setValue:base64String forKey:@"value"];
    [AFManagerHelp   asyncUploadFileWithData:imageData name:@"avatar" fileName:@"PersonHeadPic.jpg" mimeType:@"image/jpeg" parameters:dic success:^(id responseObject) {
      
        if ([responseObject[@"status"] integerValue] == 0) {
            [self  makePersonInfo];
            
        }else{
            [ShowHUD showWYBTextOnly:responseObject[@"msg"] duration:2 inView:self.view];
        }
        
        [self hideHud];
    } failture:^(NSError *error) {
        [self hideHud];

    }];

    
}
-(void)cancelSelecImage{
    
    
}
// 更改基本信息
-(void)ChangInformationWithDic:(NSDictionary *)dicc{
 
    NSMutableDictionary *valuedic =[[NSMutableDictionary alloc]initWithDictionary:dicc];
    [valuedic setValue:UserId forKey:@"lawyer_id"];
 
    NSString * base64String =[NSString getBase64StringWithArray:valuedic];
    
    NSMutableDictionary  *dic =[[NSMutableDictionary alloc]init] ;
    NewAddInfor ;
    [dic setValue:base64String forKey:@"value"];
    WS(ws);
    [AFManagerHelp POST:BASE_URL parameters:dic success:^(id responseObjeck) {
        // 处理数据
        DLog(@" %@",responseObjeck);
        if ([responseObjeck[@"status"] integerValue] == 0) {
           

        }else{
            [ShowHUD showWYBTextOnly:responseObjeck[@"msg"] duration:2 inView:ws.view];
        }
        
        [self hideHud];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [self hideHud];
    }];

    
}

-(void)makePersonInfo{
 

//action、value
    NSDictionary *valuedic ;
    if (self.mid) {
        valuedic  = @{  @"lawyer_id":UserId,@"mid":self.mid };
    }else{
        valuedic  = @{  @"lawyer_id":UserId, };
    }

NSString * base64String =[NSString getBase64StringWithArray:valuedic];

NSMutableDictionary  *dic =[[NSMutableDictionary alloc]init] ;
NewGetInfor ;
[dic setValue:base64String forKey:@"value"];
WS(ws);
[AFManagerHelp POST:BASE_URL parameters:dic success:^(id responseObjeck) {
    // 处理数据
    DLog(@" %@",responseObjeck);
     if ([responseObjeck[@"status"] integerValue] == 0) {
        ws.infoModel = [MyInfoModel mj_objectWithKeyValues:responseObjeck[@"data"]];
        platforModel = [LawPlatformModel yy_modelWithJSON:responseObjeck[@"data"][@"renzhengInfo"]];
 
        [_tableView reloadData];
    }else{
        [ShowHUD showWYBTextOnly:responseObjeck[@"msg"] duration:2 inView:ws.view];
    }
    
    
} failure:^(NSError *error) {
  }];
}


//图片选择
//
//
//#pragma mark -实现图片选择器代理-（上传图片的网络请求也是在这个方法里面进行，这里我不再介绍具体怎么上传图片）
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
//    [picker dismissViewControllerAnimated:YES completion:^{}];
//    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage]; //通过key值获取到图片
//    //    _headerV.image = image;  //给UIimageView赋值已经选择的相片
//    if ([self.delegate respondsToSelector:@selector(seleWithImage:)]) {
//        [self.delegate seleWithImage:image];
//    }
//    
//    //上传图片到服务器--在这里进行图片上传的网络请求，这里不再介绍
//}
////当用户取消选择的时候，调用该方法
//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
//    [picker dismissViewControllerAnimated:YES completion:^{
//        if ([self.delegate  respondsToSelector:@selector(cancelSelecImage)]) {
//            [self.delegate cancelSelecImage];
//        }
//        
//    }];
//}


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

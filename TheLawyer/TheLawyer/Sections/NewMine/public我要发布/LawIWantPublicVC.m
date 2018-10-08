//
//  LawIWantPublicVC.m
//  TheLawyer
//
//  Created by MYMAc on 2018/9/30.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawIWantPublicVC.h"
#import "LawAppreSelectCaseTypeView.h"
#import "LawJCImageSelect.h"
#import "LawConsultTypeModel.h"
@interface LawIWantPublicVC ()<selectImagedelegate,UITextViewDelegate>{
    
    NSString * Cate_id;
    NSMutableArray * CaseTypeArray;
    NSData   * imageData ;
}
@property (strong, nonatomic) LawAppreSelectCaseTypeView * caseSelectView;

@end

@implementation LawIWantPublicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeTypeData];
    self.TopHeight.constant = NavStatusBarHeight + 11;
    [self addCenterLabelWithTitle:@"案例发布" titleColor:nil];
    self.ContentTextView.placeholderText = @"请详细描述您的案例内容（5-500字）";
    self.ContentTextView.delegate = self;
   
    [self.TypeLb whenTapped:^{
        [self showCaseTypeView];
    }];
    self.ImageView.userInteractionEnabled = YES ;
    [self.ImageView whenTapped:^{
        [self addImage];
    }];
    

    
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    [self.view addSubview:self.caseSelectView];

}
-(void)showCaseTypeView{
    MJWeakSelf;
     _caseSelectView.DataArray = [[NSMutableArray alloc]initWithArray:CaseTypeArray];
    _caseSelectView.seleAreaBlock = ^(LawConsultTypeModel *selectModel) {
        Cate_id = selectModel.id;
        weakSelf.TypeLb.text = selectModel.name;
        weakSelf.caseSelectView.hidden = YES ;

     };
    _caseSelectView.hidden = NO ;
    
}
-(LawAppreSelectCaseTypeView *)caseSelectView{
    if (!_caseSelectView) {
        _caseSelectView = [[LawAppreSelectCaseTypeView alloc]initWithFrame:CGRectMake(0, NavStatusBarHeight + 11, SCREENWIDTH, SCREENHEIGHT -  NavStatusBarHeight - 11)];
        _caseSelectView.hidden = YES;
        _caseSelectView.TableViewHeight =400;

     }
    return _caseSelectView;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
   
      if(textView.text.length > 500){
          if (text.length > 0) {
              return NO ;

          }else{
              return YES ;
          }
    }
    return YES ;
}
-(void)addImage{
    LawJCImageSelect * selectImage =[LawJCImageSelect defaultSelectImage];
    selectImage.delegate = self;
    [selectImage showInViewController:self];
}

#pragma mark  选择图片的代理
-(void)seleWithImage:(UIImage *)selectImage{
    self.ImageView.image = selectImage;
     imageData  = UIImageJPEGRepresentation(self.ImageView.image, 0.01);

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

- (IBAction)PubAction:(UIButton *)sender {
 
    if(self.TitleTextField.text.length == 0){
        [self showHint:@"请输入案件标题"];
        return ;
     }
    if(self.ContentTextView.text.length == 0){
        [self showHint:@"请输入案件内容"];
        return ;
}
    if (!imageData) {
        [self showHint:@"请先选择图片"];
        return ;
 }
    
    
    NSMutableDictionary *valuedic =[[NSMutableDictionary alloc]init];
    [valuedic setValue:UserId forKey:@"lawyer_id"];
    [valuedic setValue:self.TitleTextField.text forKey:@"title"];
    [valuedic setValue:Cate_id forKey:@"cate_id"];
    [valuedic setValue:self.ContentTextView.text forKey:@"content"];
 
    NSString * base64String =[NSString getBase64StringWithArray:valuedic];
    
    NSMutableDictionary  *dic =[[NSMutableDictionary alloc]init] ;
    NewIWantPublic ;
    [dic setValue:base64String forKey:@"value"];
    [AFManagerHelp   asyncUploadFileWithData:imageData name:@"thumb" fileName:@"PersonHeadPic.jpg" mimeType:@"image/jpeg" parameters:dic success:^(id responseObject) {
        
        if ([responseObject[@"status"] integerValue] == 0) {
            [self showHint:responseObject[@"msg"]];
             [self.navigationController popViewControllerAnimated:YES];
        }else{
            [self showHint:responseObject[@"msg"]];
        }
        [self hideHud];
    } failture:^(NSError *error) {
        [self hideHud];
    }];
    
    
    
}

//    获取分类

-(void)makeTypeData{
    CaseTypeArray  =[[NSMutableArray alloc]init];
    NSMutableDictionary * dic =[[NSMutableDictionary alloc]init];
    NewConsultGetType
    //    获取分类
    [AFManagerHelp POST:BASE_URL parameters:dic success:^(id responseObjeck) {
        // 处理数据
        if ([responseObjeck[@"status"] integerValue] == 0) {
            for (NSDictionary * proDic in responseObjeck[@"data"]) {
                
                LawConsultTypeModel * TypeModel =[LawConsultTypeModel yy_modelWithJSON:proDic];
                [CaseTypeArray addObject:TypeModel];
                
            }
            //            if (leftDataArray.count > 0) {
            //                LawConsultTypeModel  * TypeModel = leftDataArray[0];
            //                rightDataArray = TypeModel.second_child;
            //            }
            //
        }else{
            
        }
    } failure:^(NSError *error) {
    }];
    
}
@end

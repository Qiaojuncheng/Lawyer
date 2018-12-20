//
//  LawPlatformAuthViewController.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/22.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawPlatformAuthViewController.h"
#import "LawInfoCell.h"
#import "LawIntroducionCell.h"
#import "LawSelectTypeofCaseView.h"
#import "LawChagebasicInfoVC.h"
#import "LawConsultTypeModel.h"
#import "LawplatformEditCell.h"
#import "LawChangInfoIntroductVC.h"
#import "LawJCImageSelect.h"
@interface LawPlatformAuthViewController () <UITableViewDataSource,UITableViewDelegate,selectImagedelegate>{
    NSMutableArray * dataArrray ;
    UITableView * _tableView;
    NSArray * titleArray;
    NSArray * contentArray;
    NSMutableDictionary * renzhengDic;
    NSString *   cate_id; //擅长类型 1_2_3 最多选3个
    NSString *   cate_name; //擅长类型 1_2_3 最多选3个
    NSMutableArray * seleTypeArray; // 选中的擅长类型
   
    UIImage *  SelfselectImage ; //选中的图片
    
}
@property (strong , nonatomic) UIView * bottomView;
@property (strong , nonatomic) LawSelectTypeofCaseView * selectCaseTypeView;
@end

@implementation LawPlatformAuthViewController

- (void)viewDidLoad {
         [super viewDidLoad];
        [self addCenterLabelWithTitle:@"平台认证" titleColor:nil];
        titleArray = @[@"律所",@"擅长类型",@"电话咨询",@"预约面谈",@"执业年限",@"执业证号",@"简介"];
        contentArray = @[@"江南皮革律所",@"婚姻家庭",@"200",@"300",@"",@"10909321u3i435",@""];
        self.view.backgroundColor  =   BackViewColor;
 
    
    
    seleTypeArray = [[NSMutableArray alloc]initWithArray:self.model.cate];
     NSMutableArray * idArray =[[NSMutableArray alloc]init];
    NSMutableArray * nameArray =[[NSMutableArray alloc]init];
    for ( LawConsultTypeModel * model  in seleTypeArray) {
        [idArray addObject:model.id];
        [nameArray addObject:model.name];
    }
    
    cate_id = [idArray componentsJoinedByString:@"_"];
    cate_name = [nameArray componentsJoinedByString:@","];
    [self addView];
    [self.view addSubview:self.selectCaseTypeView];

        // Do any additional setup after loading the view.
    }
-(LawSelectTypeofCaseView *)selectCaseTypeView{
    if (!_selectCaseTypeView) {
        _selectCaseTypeView  =[[LawSelectTypeofCaseView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
        LawSelectTypeofCaseView *extractedExpr = _selectCaseTypeView;
       
        extractedExpr.dataArray = [[NSMutableArray alloc]initWithArray: self.model.cate];
        
        _selectCaseTypeView.hidden = YES;
        MJWeakSelf
        __weak typeof(_tableView) Weaktable = _tableView;
        _selectCaseTypeView.selectBlock = ^(NSArray *seleArray) {
            NSMutableArray * idArray =[[NSMutableArray alloc]init];
            NSMutableArray * nameArray =[[NSMutableArray alloc]init];
            for ( LawConsultTypeModel * model  in seleArray) {
                [idArray addObject:model.id];
                [nameArray addObject:model.name];
            }
            seleTypeArray = [[NSMutableArray alloc]initWithArray:seleArray];
            cate_id = [idArray componentsJoinedByString:@"_"];
            cate_name = [nameArray componentsJoinedByString:@","];
            
            [Weaktable reloadData];
        };
    }
    return _selectCaseTypeView;
}
    -(void)addView{
        
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0,  NavStatusBarHeight+10  , SCREENWIDTH, SCREENHEIGHT  -  NavStatusBarHeight  -10) style:UITableViewStylePlain];
        _tableView.delegate=  self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        _tableView.backgroundColor = BackViewColor;
        _tableView.separatorInset = UIEdgeInsetsMake(0,SCREENWIDTH, 0, 0);
        _tableView.tableFooterView =self.bottomView;
        
        [self.view addSubview:_tableView];
    }
    -(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
             return  titleArray.count;
        
        
    }


    
    -(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        if (indexPath.row < 6){
           
            if (indexPath.row == 2 || indexPath.row == 3||indexPath.row == 4) {
                
                 LawplatformEditCell  * cell  =[tableView dequeueReusableCellWithIdentifier:@"cells"];
                if (cell == nil) {
                    cell  =[[[NSBundle mainBundle ]loadNibNamed:@"LawplatformEditCell" owner:self options:nil]lastObject];
                }
                if (!self.CanEidt) {
                    cell.PriceTextField.userInteractionEnabled = NO ;
                }
                cell.TitleLB.text =[NSString stringWithFormat:@"%@",titleArray[indexPath.row]];
                if (indexPath.row ==2) {
                    cell.PriceTextField.placeholder =@"请输入价格";
                    cell.TypeLB.text =@"元";
                    cell.PriceTextField.text =[NSString stringWithFormat:@"%@",self.model.phone_money?self.model.phone_money:@""];
                    cell.textFieldBlock = ^(NSString *money) {
                        self.model.phone_money = money;
                    };
                }else if (indexPath.row ==3){
                    cell.PriceTextField.placeholder =@"请输入价格";
                    cell.TypeLB.text =@"元";

                    cell.PriceTextField.text =[NSString stringWithFormat:@"%@",self.model.meet_money?self.model.meet_money:@""];
                    cell.textFieldBlock = ^(NSString *money) {
                        self.model.meet_money = money;
                    };
                }else{
                    cell.PriceTextField.placeholder =@"请输入执业年限";
                    cell.TypeLB.text =@"年";

                    cell.PriceTextField.text =[NSString stringWithFormat:@"%@",self.model.practice_years?self.model.practice_years:@""];
                    cell.textFieldBlock = ^(NSString *money) {
                        self.model.practice_years = money;
                        
                    };
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.LineView.hidden = NO;
                 return  cell ;
            }
            
                 LawInfoCell  * cell  =[tableView dequeueReusableCellWithIdentifier:@"cell"];
                if (cell == nil) {
                    cell  =[[[NSBundle mainBundle ]loadNibNamed:@"LawInfoCell" owner:self options:nil]lastObject];
                }
                cell.TypeLB.text =[NSString stringWithFormat:@"%@",titleArray[indexPath.row]];
            if (indexPath.row == 0) {
                cell.ConcentLB.text =self.model.company?self.model.company:@"未填写";
                
            }else if (indexPath.row ==1){
                
               cell.ConcentLB.text =cate_name?cate_name:@"未填写";
            }else if (indexPath.row ==5){
                cell.ConcentLB.text= self.model.lawyer_code?self.model.lawyer_code:@"未填写";
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.LineView.hidden = NO;
                if (indexPath.row == titleArray.count -1) {
                    cell.LineView.hidden = YES;
                    
                }
                return  cell ;
        }else{
            LawIntroducionCell  * cell  =[tableView dequeueReusableCellWithIdentifier:@"cells"];
            if (cell == nil) {
                cell  =[[[NSBundle mainBundle ]loadNibNamed:@"LawIntroducionCell" owner:self options:nil]lastObject];
            }
            cell.ConcentLB.text =[NSString stringWithFormat:@"%@",self.model.instru?self.model.instru:@""];
            if (SelfselectImage) {
                cell.LeftImaeg.image = SelfselectImage;
            }else{
                [cell.LeftImaeg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",Image_URL,self.model.certificate]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                   SelfselectImage = image;

                }] ;
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
      
            if (self.CanEidt) {
            
            [cell.LeftImaeg whenTapped:^{
                LawJCImageSelect * selectImage =[LawJCImageSelect defaultSelectImage];
                selectImage.delegate = self;
                [ selectImage showInViewController:self];
            }];
                [cell.RightImage whenTapped:^{
                    
                }];
            }
            SelfselectImage = cell.LeftImaeg.image;
              return  cell ;
        }
    }
    
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        if (!self.CanEidt ) {
            return ;
        }
        if (indexPath.row == 0) {
            LawChagebasicInfoVC * changeName =[[LawChagebasicInfoVC alloc]init];
            changeName.titleStr =@"律所名称";
            changeName.placherStr =self.model.company?self.model.company:@"请填写您所在的律所名称";
            changeName.ChangValue = ^(NSString *changeValueStr) {
                self.model.company = changeValueStr;
                [_tableView reloadData];
            };
            [self.navigationController pushViewController:changeName animated:YES];

        }else if (indexPath.row == 1) {
            self.selectCaseTypeView.hidden = NO;
        }else   if (indexPath.row == 5) {
            LawChagebasicInfoVC * changeName =[[LawChagebasicInfoVC alloc]init];
            changeName.titleStr =@"执业证号";
            changeName.placherStr =self.model.lawyer_code?self.model.lawyer_code:@"请填写您的执业证号";
            changeName.ChangValue = ^(NSString *changeValueStr) {
                self.model.lawyer_code = changeValueStr;
                [_tableView reloadData];
            };
            [self.navigationController pushViewController:changeName animated:YES];
            
        }else if (indexPath.row == 6){
            LawChangInfoIntroductVC * changInfoVc =[[LawChangInfoIntroductVC alloc]init];
            changInfoVc.instru  = self.model.instru ;
            changInfoVc.ChangValue = ^(NSString *changeValueStr) {
                self.model.instru = changeValueStr;
                [_tableView reloadData];
            };
            [self.navigationController pushViewController:changInfoVc animated:YES];
        }
      
    }
    -(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        if( indexPath.row == 6){
            return 200;
        }else{
            return 60;
        }
    }
    - (void)didReceiveMemoryWarning {
        [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
    }
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 90)];
        _bottomView.backgroundColor = BackViewColor;
        UIButton * submitBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        submitBtn.frame = CGRectMake(15, 20, SCREENWIDTH - 30, 50);
        [submitBtn setBackgroundColor:[UIColor colorWithHex:0x3181FE]];
        [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        submitBtn.adjustsImageWhenHighlighted = NO;
        [submitBtn addTarget:self action:@selector(SubmitAction:) forControlEvents:UIControlEventTouchUpInside];
        [Utile makeCorner:23 view:submitBtn];
        [_bottomView addSubview:submitBtn];
    }
    return _bottomView;
}
#pragma mark  选择图片的代理
-(void)seleWithImage:(UIImage *)selectImage{
    
    SelfselectImage = selectImage;
    
    [_tableView reloadData];
}
-(void)cancelSelecImage{
    
    
}
-(void)SubmitAction:(UIButton *)sender{
    
    if (!self.CanEidt ) {
        [self showHint:@"正在审核，无法修改！"];

        return ;
    }
    if(!self.model.company){
        [self showHint:@"请输入您所在的律所名称！"];
        return ;
    }else if (!cate_id){
        [self showHint:@"请选择您的擅长领域！"];
      return ;
    }else if (!self.model.phone_money){
        [self showHint:@"请填写您电话预约价格！"];
      return ;
    }else if (!self.model.meet_money){
        [self showHint:@"请填写您见面咨询价格！"];
     return ;
    }else if (!self.model.practice_years){
        [self showHint:@"请填写您的执业年限！"];
        return ;
    }else if (!self.model.lawyer_code){
        [self showHint:@"请填写您的执业证号！"];
    return ;
    }else if (!self.model.instru){
        [self showHint:@"请输入您的简介！"];
        return ;
    }else if (!SelfselectImage){
        [self showHint:@"请上传您的执业证书"];
        return ;
    }
    
    NSLog(@"提交");
    NSData  * imageData  = UIImageJPEGRepresentation(SelfselectImage, 0.01);
    
    NSMutableDictionary *valuedic =[[NSMutableDictionary alloc]init];
    [valuedic setValue:UserId forKey:@"lawyer_id"];
    [valuedic setValue:self.model.company forKey:@"company"];
    [valuedic setValue:cate_id forKey:@"cate_id"];
    [valuedic setValue:self.model.phone_money forKey:@"phone_money"];
    [valuedic setValue:self.model.meet_money forKey:@"meet_money"];
    [valuedic setValue:self.model.lawyer_code forKey:@"lawyer_code"];
    [valuedic setValue:self.model.practice_years forKey:@"practice_years"];
    
    [valuedic setValue:self.model.instru forKey:@"instru"];
 
    NSString * base64String =[NSString getBase64StringWithArray:valuedic];
    NSLog(@"cate_id  = %@ ",cate_id);
    NSMutableDictionary  *dic =[[NSMutableDictionary alloc]init] ;
    NewMyInforRen ;
    [dic setValue:base64String forKey:@"value"];
    [AFManagerHelp   asyncUploadFileWithData:imageData name:@"certificate" fileName:@"certificate.jpg" mimeType:@"image/jpeg" parameters:dic success:^(id responseObject) {
        
        if ([responseObject[@"status"] integerValue] == 0) {
        [self.navigationController popToRootViewControllerAnimated:YES];
            
        }else{
      
        }

        [self showHint:responseObject[@"msg"]];
        [self hideHud];
    } failture:^(NSError *error) {
        [self hideHud];
        
    }];
    
}

@end

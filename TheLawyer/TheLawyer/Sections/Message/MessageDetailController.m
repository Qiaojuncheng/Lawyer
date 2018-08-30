//
//  MessageDetailController.m
//  TheLawyer
//
//  Created by MYMAc on 2017/11/4.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import "MessageDetailController.h"
#import "LPlaceholderTextView.h"

@interface MessageDetailController ()<UITextViewDelegate>{
    
    NSString * textViewStr;
    
}

@end

@implementation MessageDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.RepyNameLB.hidden = YES;
    self.RepyACtionLB.hidden = YES;
    [Utile makeCorner:25 view:self.HeaderImageView];
    [self addCenterLabelWithTitle:@"咨询详情" titleColor:[UIColor whiteColor]];
    [self makeData];
//    QJCMEssageDetailModel * model =[[QJCMEssageDetailModel alloc]init]; ;
//    model.title = @"标题";
//    model.avatar = @"/Uploads/Avatar/user/2017-10-31/9cbb4a8f74b2b2a04dfee1c237ec9fd559f8184e94c5f.jpg";
//    model.category_name = @"分类";
//    model.name = @"发布者";
//    model.create_time = @"2014/12/12 09:09:09";
//    model.content = @"我是发布内容我是发布内容我是发布内容我是发布内容我是发布内容我是发布内容我是发布内容我是发布内容";
//    model.answerContent = @"";

//    self.detailModel = model;
    // Do any additional setup after loading the view from its nib.
}
-(void)setDetailModel:(QJCMEssageDetailModel *)detailModel{
    _detailModel =detailModel;
    [self.HeaderImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Image_URL,detailModel.avatar]] placeholderImage:[UIImage imageNamed:@"头像"] completed:nil];
    self.AskNameLB.text = detailModel.name;
    self.ConsultType.text = detailModel.category_name;
    self.TimeLB.text =  [NSString timeWithTimeIntervalString:detailModel.create_time];
    self.ConsultTitleLB.text = [NSString stringWithFormat:@"标题:%@",detailModel.title];
    self.ConsultCOncentLB.text = detailModel.content;

//
    self.ConcentHeight.constant  = [self getheightWithConcent:_detailModel.content ] +  5;
//
//
    self.RepyConcentLB.text = detailModel.answerContent;
    self.RepyViewHeight.constant = [self getheightWithConcent:_detailModel.answerContent ] +  5;
    self.BackViewHeight.constant  = self.RepyConcentLB.bottom + 5;

    if (detailModel.answerContent.length ==  0) {
//        self.BackViewHeight.constant  = self.RepyACtionLB.bottom;
       
        self.RepyACtionLB.hidden = NO;
        self.RepyNameLB.hidden = YES;
        [self.RepyACtionLB whenTapped:^{
            [self showPingLun];
        }];
    }else{
        self.RepyNameLB.hidden = NO;
        self.RepyACtionLB.hidden = YES;
 
    }
   }
-(void)setReloadDataBlock:(block)reloadDataBlock{
    _reloadDataBlock = [reloadDataBlock copy];
}
-(CGFloat )getheightWithConcent:(NSString *)concent{
    CGSize  sizes = CGSizeMake(SCREENWIDTH - 81, 1000);
    NSDictionary *attributess = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:16] forKey:NSFontAttributeName];
    CGRect rects = [concent boundingRectWithSize:sizes
                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                  attributes:attributess
                                                     context:nil];
    return rects.size.height;

 }
-(void)showPingLun{
    
    UIView * BackView =[[UIView alloc]initWithFrame:CGRectMake(0, NavStatusBarHeight, self.view.width , self.view.height)];
    BackView.backgroundColor =[UIColor colorWithHex:0xffffff alpha:.5];
    BackView.tag = 23;
    [self.view addSubview:BackView];
//
    UIView * whitView =[[UIView alloc] initWithFrame:CGRectMake(30, self.view.height/2 - 150, self.view.width -  60, 200)];
    whitView.backgroundColor =[UIColor colorWithHex:0xececec];
    [Utile makeCorner:5 view:whitView];
    [BackView addSubview:whitView];
    
    LPlaceholderTextView * inputTextView =[[LPlaceholderTextView alloc]initWithFrame:CGRectMake(5, 35, whitView.width - 10, whitView.height - 40)];
    inputTextView.placeholderText = @"回复不超过300字。";
    inputTextView.delegate = self;
    [whitView addSubview:inputTextView];
    UIImageView * closeImage =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"close"]];
    closeImage.frame= CGRectMake(whitView.width - 25 , 11, 15, 15);
     [closeImage whenTapped:^{
        [BackView removeFromSuperview];
         textViewStr =@"";
    }];
    [whitView addSubview:closeImage];
    
    UILabel  * huifuLB =[[UILabel alloc]initWithFrame:CGRectMake(10 , 2, 50, 30)];
     huifuLB.text = @"回复";
     huifuLB.textColor =  [UIColor colorWithHex:0x333333];
     [whitView addSubview:huifuLB];
    
    
    
   UIButton * _okBt = [UIButton buttonWithType:UIButtonTypeCustom];
    _okBt.layer.masksToBounds = YES;
    _okBt.layer.cornerRadius = 5;
    _okBt.backgroundColor = THEMECOLOR;
    [_okBt setNormalTitle:@"提交"];
    _okBt.frame = CGRectMake(75, SCREENHEIGHT-60 - NavStatusBarHeight, SCREENWIDTH-150, 40);
    [_okBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_okBt addClickTarget:self action:@selector(okClick:)];
    [BackView addSubview:_okBt];
  }
-(void)textViewDidEndEditing:(UITextView *)textView{
    
    textViewStr = textView.text;
}
-(void)makeData{
    NSMutableDictionary * dic  =[[NSMutableDictionary alloc]init];
    QJCZIXUN
    NSMutableDictionary *   valueDic =[[NSMutableDictionary alloc]init];
    [valueDic setObject:UserId forKey:@"user_id"];
         [valueDic setObject:self.zixunID forKey:@"id"];
     NSString * baseStr = [NSString getBase64StringWithArray:valueDic];
    [dic setValue:baseStr forKey:@"value"];
    
    [self showHudInView:self.view hint:nil];
    [HttpAfManager postWithUrlString:BASE_URL parameters:dic success:^(id data) {
        NSLog(@"%@",data);
         NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            QJCMEssageDetailModel  *model =[QJCMEssageDetailModel yy_modelWithDictionary:data[@"data"][0]];
            self.detailModel = model;
            if (self.reloadDataBlock) {
                self.reloadDataBlock();
                
            }
        }
        [self hideHud];

    } failure:^(NSError *error) {
         [self hideHud];
        NSLog(@"%@",error);
    }];
}

-(void)okClick:(UIButton *)btn{
    NSLog(@"提交回复 %@",textViewStr);
    
    NSMutableDictionary * dic  =[[NSMutableDictionary alloc]init];
    QJCZIXUNREPLY
    NSMutableDictionary *   valueDic =[[NSMutableDictionary alloc]init];
    [valueDic setObject:UserId forKey:@"user_id"];
    [valueDic setObject:self.zixunID forKey:@"id"];
    [valueDic setObject:textViewStr forKey:@"content"];
    NSString * baseStr = [NSString getBase64StringWithArray:valueDic];
    [dic setValue:baseStr forKey:@"value"];
    
    [self showHudInView:self.view hint:nil];
    [HttpAfManager postWithUrlString:BASE_URL parameters:dic success:^(id data) {
        NSLog(@"%@",data);
        NSString  * str =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([str isEqualToString:@"0"]) {
            self.detailModel.answerContent  = textViewStr;
            self.detailModel = _detailModel;
            UIView * back =[self.view viewWithTag:23];
            [back removeFromSuperview];
        }
        [self showHint:data[@"msg"]];
        [self hideHud];
        
    } failure:^(NSError *error) {
        [self hideHud];
        NSLog(@"%@",error);
    }];
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

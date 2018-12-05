//
//  LawSquarSrviceViewDetailController.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/17.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawSquarSrviceViewDetailController.h"

#import "LawSquarServiceCell.h"
#import "LawSquarServiceDetailCell.h"
#import "LawServicePingModel.h"
#import "IQKeyboardManager.h"


@interface LawSquarSrviceViewDetailController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate>{
    NSMutableArray * dataArrray ;
    UITableView * _tableView;
    LawSquaremodel * Detailmodel ;
    NSString * Price ;
    UIView * bottom  ;
    
}


@end

@implementation LawSquarSrviceViewDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [IQKeyboardManager sharedManager].enable = NO;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    dataArrray =[[NSMutableArray alloc]init];
    [self addCenterLabelWithTitle:@"服务广场" titleColor:nil];
    self.view.backgroundColor = [UIColor whiteColor];
    [self makedata];
    [self addView ];
    [self addbottomView];

    // Do any additional setup after loading the view.
}
-(void)makedata{
    
    NSMutableDictionary * dic  =[[NSMutableDictionary alloc]init];
    NewSquarXq
    NSMutableDictionary *   valueDic =[[NSMutableDictionary alloc]init];
    [valueDic setObject:self.Serviceid forKey:@"id" ];
    [valueDic setObject:UserId   forKey:@"lawyer_id" ];
 
    NSString * baseStr = [NSString getBase64StringWithArray:valueDic];
    [dic setValue:baseStr forKey:@"value"];
    NSLog(@"dic = %@",dic);
         [self showHudInView:self.view hint:nil];
    [HttpAfManager postWithUrlString:BASE_URL parameters:dic success:^(id data) {
        NSLog(@"%@",data);
        
        NSString * codeStr =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([codeStr isEqualToString:@"0"]) {
            Detailmodel =  [LawSquaremodel yy_modelWithDictionary:data[@"data"]];
            [Detailmodel MakeCellHeight];

           NSString * Detailmodelbidding =[NSString stringWithFormat:@"%@",data[@"data"][@"bidding"]];
            for (NSDictionary * dics in data[@"data"][@"bidding_list"]) {
                LawServicePingModel * pinlunmodel =  [LawServicePingModel yy_modelWithDictionary:dics];
                
                [pinlunmodel MakeCellHeight];
                [dataArrray addObject:pinlunmodel];
                
            }
            if (![Detailmodel.type isEqualToString:@"1"]) {
                Price = Detailmodel.money;
            }
            if([Detailmodelbidding integerValue] == 0){
//                未投标
                bottom.hidden = NO ;
            }else{
//                已投标
                bottom.hidden   = YES ;
                 _tableView.frame  =  CGRectMake(0,  NavStatusBarHeight, SCREENWIDTH, SCREENHEIGHT -  NavStatusBarHeight) ;

            }
            [_tableView reloadData];
        }
        [self hideHud];
     } failure:^(NSError *error) {
        [self hideHud];
       
    }];

    
}
-(void)addView{
    
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0,  NavStatusBarHeight, SCREENWIDTH, SCREENHEIGHT -  NavStatusBarHeight- 68) style:UITableViewStylePlain];
    _tableView.delegate=  self;
    _tableView.dataSource = self;
    _tableView.separatorInset =  UIEdgeInsetsMake(0, SCREENWIDTH, 0, 0);
    _tableView.backgroundColor =[UIColor whiteColor];
    _tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:_tableView];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return 1;
    }
    return 10;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * header =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 10)];
    header.backgroundColor = BackViewColor;
    return header;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section ==0) {
        return 1;
    }else{
        return dataArrray.count;
    }
 
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        LawSquarServiceCell  * cell  =[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell  =[[[NSBundle mainBundle ]loadNibNamed:@"LawSquarServiceCell" owner:self options:nil]lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.modle = Detailmodel;
        return  cell ;
        
    }else{
        LawSquarServiceDetailCell  * cell  =[tableView dequeueReusableCellWithIdentifier:@"cellss"];
        if (cell == nil) {
            cell  =[[[NSBundle mainBundle ]loadNibNamed:@"LawSquarServiceDetailCell" owner:self options:nil]lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = dataArrray[indexPath.row];
        return  cell ;
        
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 0) {
        return Detailmodel.cellHeight;
    }else{
        LawServicePingModel * model =   dataArrray[indexPath.row];
        return model.cellHeight;
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 50;
    if(scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0,0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

-(void)addbottomView{
    
    
    
    
     bottom =[[UIView alloc]initWithFrame:CGRectMake(0, _tableView.bottom +1, SCREENWIDTH, 68)];
    bottom.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:bottom];
    
    UIButton* answerBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    answerBtn.frame = CGRectMake(38, 12, SCREENWIDTH - 76,44 );
    [answerBtn setImage:[UIImage imageNamed:@"botton_bidding"] forState:UIControlStateNormal];
    answerBtn.adjustsImageWhenHighlighted = NO;
    [answerBtn setTitle:@"参与竞标" forState:UIControlStateNormal];
    [answerBtn addTarget:self action:@selector(amserBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [Utile makeCorner:answerBtn.height/2 view:answerBtn];
    [answerBtn setBackgroundColor:[UIColor colorWithHex:0x4483F6]];
    [bottom addSubview:answerBtn];
    
    
    
    
    
}
-(LawSquarServiceFootView *)FootView{
    if (!_FootView) {
        _FootView =[[[NSBundle mainBundle]loadNibNamed:@"LawSquarServiceFootView" owner:self options:nil]lastObject];
                     
        _FootView.frame = CGRectMake(0, 0, SCREENWIDTH, 250);
        _FootView.PriceTextField.delegate = self;
        _FootView.ContentTextView.placeholderText =@"请简单描述";
        _FootView.ContentTextView.delegate = self;
        
        if(![Detailmodel.type isEqualToString:@"1"]){
            _FootView.PriceStr = Detailmodel.money;

        }else{
            
        }
    }
    
    return _FootView ;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    Price = textField.text;
}
-(void)amserBtnAction:(UIButton *)sureBtn{
    if([sureBtn.titleLabel.text  isEqualToString:@"参与竞标"]){
    [sureBtn setImage:nil forState:UIControlStateNormal];
    sureBtn.adjustsImageWhenHighlighted = NO;
    [sureBtn setTitle:@"确认竞标" forState:UIControlStateNormal];
        _tableView.tableFooterView =  self.FootView;
        [dataArrray removeAllObjects];
      
    }else{
        [self jingbiao];
        NSLog(@"提交");
    }
    [_tableView reloadData];

  
}
-(void)jingbiao{
    
    if (self.FootView.ContentTextView.text.length ==0 ) {
        [self showHint:@"请添加描述！"];
        return ;
    }else if(Price.length == 0){
        [self showHint:@"请输入价格！"];
        return ;

    }
    NSMutableDictionary * dic  =[[NSMutableDictionary alloc]init];
    NewSquarbidding
    NSMutableDictionary *   valueDic =[[NSMutableDictionary alloc]init];
    [valueDic setObject:self.Serviceid forKey:@"id" ];
    [valueDic setObject:UserId   forKey:@"lawyer_id" ];
    [valueDic setObject:self.FootView.ContentTextView.text   forKey:@"describe" ];
    [valueDic setObject:Price   forKey:@"money" ];
 
    NSString * baseStr = [NSString getBase64StringWithArray:valueDic];
    [dic setValue:baseStr forKey:@"value"];
    NSLog(@"dic = %@",dic);
    [self showHudInView:self.view hint:nil];
    [HttpAfManager postWithUrlString:BASE_URL parameters:dic success:^(id data) {
        NSLog(@"%@",data);
        [self hideHud];

        NSString * codeStr =[NSString stringWithFormat:@"%@",data[@"status"]];
        if ([codeStr isEqualToString:@"0"]) {
            _tableView.tableFooterView = nil;

            [self makedata];
         }
    } failure:^(NSError *error) {
        [self hideHud];
        
    }];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if(self.ReladBlock){
        self.ReladBlock(Detailmodel.lawyer_num);
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

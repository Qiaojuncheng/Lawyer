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
#import "IQKeyboardManager.h"


@interface LawSquarSrviceViewDetailController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate>{
    NSMutableArray * dataArrray ;
    UITableView * _tableView;
    
    
    
}


@end

@implementation LawSquarSrviceViewDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [IQKeyboardManager sharedManager].enable = NO;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    dataArrray =[[NSMutableArray alloc]initWithArray:@[@"s",@"s",@"s",@"s",@"s"]];
    [self addCenterLabelWithTitle:@"服务广场" titleColor:nil];
    self.view.backgroundColor = [UIColor whiteColor];
    [self makedata];
    [self addView ];
    [self addbottomView];
    
    // Do any additional setup after loading the view.
}
-(void)makedata{
    
    //    dataArrray   =[[NSMutableArray alloc]init];
    //    for (int i = 0 ; i<10; i++) {
    //        LawMessageModel * model =[[LawMessageModel alloc]init];
    //        model.showBtn = [NSString stringWithFormat:@"%d",rand()%2];
    //        model.showRed = [NSString stringWithFormat:@"%d",rand()%2];
    //
    //        [dataArrray addObject:model];
    //    }
    
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
        return 0;
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
    //    return ;//dataArrray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        LawSquarServiceCell  * cell  =[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell  =[[[NSBundle mainBundle ]loadNibNamed:@"LawSquarServiceCell" owner:self options:nil]lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell ;
        
    }else{
        LawSquarServiceDetailCell  * cell  =[tableView dequeueReusableCellWithIdentifier:@"cellss"];
        if (cell == nil) {
            cell  =[[[NSBundle mainBundle ]loadNibNamed:@"LawSquarServiceDetailCell" owner:self options:nil]lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell ;
        
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 0) {
        return 178;
    }else{
        return 103;
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
    
    
    
    
    UIView * bottom =[[UIView alloc]initWithFrame:CGRectMake(0, _tableView.bottom +1, SCREENWIDTH, 68)];
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
        _FootView.PriceStr = @"123";
    }
    
    return _FootView ;
}
-(void)amserBtnAction:(UIButton *)sureBtn{
    if([sureBtn.titleLabel.text  isEqualToString:@"参与竞标"]){
    [sureBtn setImage:nil forState:UIControlStateNormal];
    sureBtn.adjustsImageWhenHighlighted = NO;
    [sureBtn setTitle:@"确认竞标" forState:UIControlStateNormal];
        _tableView.tableFooterView =  self.FootView;
        [dataArrray removeAllObjects];
      
    }else{
        _tableView.tableFooterView = nil;
        [self makedata];
        NSLog(@"提交");
    }
    [_tableView reloadData];

  
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    
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

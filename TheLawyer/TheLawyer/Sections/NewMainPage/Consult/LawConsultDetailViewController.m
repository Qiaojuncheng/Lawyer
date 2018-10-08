//
//  LawConsultDetailViewController.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/16.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawConsultDetailViewController.h"
#import "LawMainConsultCell.h"
#import "LawConsultDetailTwoCell.h"
#import "QZTopTextView.h"
#import "IQKeyboardManager.h"
#import "LawConsultDetailReplayModel.h"
@interface LawConsultDetailViewController ()<UITableViewDelegate,UITableViewDataSource,QZTopTextViewDelegate>{
    NSMutableArray * dataArrray ;
    UITableView * _tableView;
    QZTopTextView * _textView;

}


@end

@implementation LawConsultDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [IQKeyboardManager sharedManager].enable = NO;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;

    [self addCenterLabelWithTitle:@"咨询详情" titleColor:nil];
    self.view.backgroundColor = [UIColor whiteColor];
    [self makedata];
    [self addbottomView];

    // Do any additional setup after loading the view.
}
-(void)makedata{
    
 
    dataArrray =[[NSMutableArray alloc]init];
    
    [self showHudInView:self.view hint:nil];
    NSMutableDictionary * dic =[[NSMutableDictionary alloc]init];
    NewConsultDetail
    NSDictionary * vadic ;
    if([self.type  isEqualToString:@"2"]){
        if(self.mid){
            vadic  = @{@"id":self.constultId,@"type":self.type,@"lawyer_id":UserId,@"mid":self.mid};
        }else{
        vadic  = @{@"id":self.constultId,@"type":self.type,@"lawyer_id":UserId};
        }
        
    }else{
        vadic  = @{@"id":self.constultId,@"type":self.type};

    }
 
    NSString * baseString = [NSString getBase64StringWithArray:vadic];
    [dic setValue:baseString forKey:@"value"];
    [HttpAfManager postWithUrlString:BASE_URL parameters:dic success:^(id data) {
        NSLog(@"%@",data);
        
        NSString * status = [NSString stringWithFormat:@"%@",data[@"status"]];
        if([status isEqualToString:@"0"]){
            self.model = [LawMainConsultCellMoldel yy_modelWithJSON:data[@"data"]];
            [self addView ];

             for (NSDictionary * dics in data[@"data"][@"reply_list"]) {
                LawConsultDetailReplayModel * model =  [LawConsultDetailReplayModel yy_modelWithDictionary:dics];
                  model.cellHeight  = [NSString GetHeightWithMaxSize:CGSizeMake(SCREENHEIGHT - 75, MAXFLOAT) AndFont:[UIFont systemFontOfSize:16] AndText:model.content].height;

                [dataArrray addObject:model];

            }
            
            [_tableView reloadData];
            
        }
        [self hideHud];
    } failure:^(NSError *error) {
        [self hideHud];
        
    }];
}
-(void)addView{
    
    CGFloat _tableVeiwheight ;
    if ([self.model.answered isEqualToString:@"0"]) {
//        未回复
        _tableVeiwheight =     SCREENHEIGHT -  NavStatusBarHeight- 68 ;

    }else{
        _tableVeiwheight =     SCREENHEIGHT -  NavStatusBarHeight;

    }
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0,  NavStatusBarHeight, SCREENWIDTH,_tableVeiwheight ) style:UITableViewStylePlain];
    
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
        LawMainConsultCell  * cell  =[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell  =[[[NSBundle mainBundle ]loadNibNamed:@"LawMainConsultCell" owner:self options:nil]lastObject];
        }
        cell.model = self.model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell ;
        
    }else{
        LawConsultDetailTwoCell  * cell  =[tableView dequeueReusableCellWithIdentifier:@"cellss"];
        if (cell == nil) {
            cell  =[[[NSBundle mainBundle ]loadNibNamed:@"LawConsultDetailTwoCell" owner:self options:nil]lastObject];
        }
        cell.model = dataArrray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell ;
        
    }
 }
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 0) {
      CGSize labelSize =  [NSString GetHeightWithMaxSize:CGSizeMake(SCREENWIDTH - 30, MAXFLOAT) AndFont:[UIFont systemFontOfSize:16] AndText:self.model.content];
        return  labelSize.height + 106;
    }else{
        LawConsultDetailReplayModel * model = dataArrray[indexPath.row];
        
        return  model.cellHeight +  71;
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
    [answerBtn setImage:[UIImage imageNamed:@"botton_answer"] forState:UIControlStateNormal];
    answerBtn.adjustsImageWhenHighlighted = NO;
    [answerBtn setTitle:@"我要回答" forState:UIControlStateNormal];
    [answerBtn addTarget:self action:@selector(amserBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [Utile makeCorner:answerBtn.height/2 view:answerBtn];
    [answerBtn setBackgroundColor:[UIColor colorWithHex:0x4483F6]];
    [bottom addSubview:answerBtn];
    
    _textView =[QZTopTextView topTextView];
    _textView.delegate = self;
    [self.view addSubview:_textView];
    

    
}
-(void)amserBtnAction{
    NSLog(@"评论");
    
    [_textView.countNumTextView becomeFirstResponder];

}

- (void)sendComment
{
    
    NSLog(@"%@",_textView.countNumTextView.text);
    if ([NSString changeNullString:_textView.countNumTextView.text].length != 0) {
        
    }else{
        [self showHint:@"请输入你的评论"];
        return;
    }
    

    [self showHudInView:self.view hint:nil];
    NSMutableDictionary * dic =[[NSMutableDictionary alloc]init];
    NewConsultReply

    NSDictionary * vadic   = @{@"id":self.model.id,@"content":_textView.countNumTextView.text,@"lawyer_id":UserId};
    
     NSString * baseString = [NSString getBase64StringWithArray:vadic];
    [dic setValue:baseString forKey:@"value"];
    [HttpAfManager postWithUrlString:BASE_URL parameters:dic success:^(id data) {
        NSLog(@"%@",data);
        [self hideHud];

        NSString * status = [NSString stringWithFormat:@"%@",data[@"status"]];
        if([status isEqualToString:@"0"]){
            self.model.answered = @"1";
            dispatch_async(dispatch_get_main_queue(), ^{
            _tableView.height =   SCREENHEIGHT -  NavStatusBarHeight;
                [_tableView bringToFront];
            });
            _textView.countNumTextView.text = @"";
            _textView.countNumTextView.placeholder = @"请输入你的评论";
            
            if(self.reloadBlock){
                self.reloadBlock();
            }
            
            [self makedata];
        }else{
 
        }
        [self showHint:data[@"msg"]];

    } failure:^(NSError *error) {
        [self hideHud];
        [self showHint:@"回复失败"];

        
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

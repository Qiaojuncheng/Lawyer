//
//  LawAppreSelectCaseTypeView.m
//  TheLawyer
//
//  Created by MYMAc on 2018/9/25.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawAppreSelectCaseTypeView.h"
#import "LawCaseTypeCell.h"

@implementation LawAppreSelectCaseTypeView


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor =[UIColor colorWithHex:0x000000 alpha:.4];
        [self makeSubView];
    }
    return self;
}

-(void)setDataArray:(NSMutableArray *)DataArray{
    _DataArray = DataArray;
    if (DataArray.count > 0) {
        LawConsultTypeModel * model = DataArray[0];
        rightDataArray = model.second_child;
    }
    
    _leftTv.frame  = CGRectMake(  0 ,0  , SCREENWIDTH/2, self.TableViewHeight );
    _rightTv.frame  = CGRectMake(  SCREENWIDTH/2 ,0  , SCREENWIDTH/2, self.TableViewHeight );
 
    
    [_leftTv reloadData];
    [_rightTv reloadData];
}
-(void)makeSubView{
    
    UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddaction:)];
    tap.delegate= self;
    [self addGestureRecognizer:tap];
    _leftTv = [self makeLeftOrRight:YES];
    _rightTv =[self makeLeftOrRight:NO];
    [self addSubview:_leftTv];
    [self addSubview:_rightTv];
}
-(void)hiddaction:(UITapGestureRecognizer *)tap{
    self.hidden = YES;
}
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if (touch.view == self) {
        return YES;
    }else{
        return NO;
    }
    
}


-(UITableView *)makeLeftOrRight:(BOOL) left{
    
    UITableView * tablev =[[UITableView alloc]initWithFrame:CGRectMake(  left? 0:SCREENWIDTH/2,0  , SCREENWIDTH/2, self.TableViewHeight ) style:UITableViewStylePlain];
    //    if (left){
    //        tablev.backgroundColor =[UIColor whiteColor];
    //    }else{
    tablev.backgroundColor =[UIColor colorWithHex:0xF7F7F7];
    //    }
    tablev.separatorColor = [UIColor colorWithHex:0xEBEBEB];
    
    
    tablev.delegate=  self;
    tablev.dataSource = self;
    tablev.separatorInset = UIEdgeInsetsMake(0,SCREENWIDTH, 0, 0);
    tablev.backgroundColor =[UIColor whiteColor];
    tablev.tableFooterView = [[UIView alloc]init];
    
    return tablev;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _leftTv) {
        return  self.DataArray.count;
    }else if(tableView == _rightTv){
        return  rightDataArray.count;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LawCaseTypeCell  * cell  =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell  =[[[NSBundle mainBundle ]loadNibNamed:@"LawCaseTypeCell" owner:self options:nil]lastObject];
    }
    //    cell.model = dataArrray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (tableView == _leftTv) {
        LawConsultTypeModel * model =  self.DataArray[indexPath.row];
        cell.CaseTypeLB.text = model.name;
        if ([model.id isEqualToString:self.LeftSelectID]) {
            cell.CaseTypeLB.backgroundColor= [UIColor colorWithHex:0x3181FE alpha:0.08];
         }else{
            cell.CaseTypeLB.backgroundColor =[UIColor whiteColor];
        }
    }else if(tableView == _rightTv){
        LawConsultTypeModel * model =  rightDataArray[indexPath.row];
        cell.CaseTypeLB.text = model.name ;
        if ([model.id isEqualToString:self.RightSelectID]) {
            cell.CaseTypeLB.backgroundColor= [UIColor colorWithHex:0x3181FE alpha:0.08];
            
        }else{
            cell.CaseTypeLB.backgroundColor =[UIColor colorWithHex:0xf7f7f7];
        }
    }
    return  cell ;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _leftTv) {
        leftselect = indexPath.row;
         LawConsultTypeModel * procemod =self.DataArray[indexPath.row];
        self.LeftSelectID = procemod.id;
        
        rightDataArray =procemod.second_child;
        LawConsultTypeModel * citymod = rightDataArray [0];
        self.RightSelectID = citymod.id;
       
        
         [_rightTv  reloadData];
        [_leftTv reloadData];
    }else if(tableView == _rightTv){
        rightselect = indexPath.row;
         LawConsultTypeModel * citymod = rightDataArray [indexPath.row];
        self.RightSelectID = citymod.id;
 
         [_rightTv  reloadData];
 
        if(self.seleAreaBlock){
            self.seleAreaBlock(citymod);
        }
        
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

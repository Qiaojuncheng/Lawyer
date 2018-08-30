//
//  LawSelectTypeofCaseView.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/23.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawSelectTypeofCaseView.h"
#import "LawSelectLeftCaseCell.h"
#import "LawzSekectRightCell.h"
@implementation LawSelectTypeofCaseView

-(void)setDataArray:(NSMutableArray *)dataArray{
    _dataArray = dataArray;
    rightselectIDArray = [[NSMutableArray alloc]init];
    leftDataArray = @[@"法律咨询",@"刑事案件",@"劳动纠纷",@"婚姻家庭",@"刑事案件",@"劳动纠纷",@"婚姻家庭",@"刑事案件",@"劳动纠纷",@"婚姻家庭",@"刑事案件",@"劳动纠纷",@"婚姻家庭"];
    rightDataArray  =  [leftDataArray copy];
    self.backgroundColor =  [UIColor colorWithHex:0x000000 alpha:0.5];
    
    [self addcenterView];
    [self makeSubView];
    
    
    
}
-(void)addcenterView{
    centerView =[[UIView alloc]initWithFrame:CGRectMake(44, 0, SCREENWIDTH - 88, self.height/2)];
    centerView.center = self.center;
    centerView.backgroundColor = [UIColor whiteColor];
    [Utile makeCorner:10 view:centerView ];
    
    UILabel * typeLB =[[UILabel alloc]initWithFrame:CGRectMake(64, 0, centerView.width - 64 *2 , 46)];
    typeLB.textColor = DEEPTintColor;
    typeLB.text = @"请选择类型";
    typeLB.textAlignment =  NSTextAlignmentCenter;
    [centerView addSubview:typeLB];
    
    UIView * linview = [[UIView alloc]initWithFrame:CGRectMake(typeLB.right, 0, 1, 64)];
    linview.backgroundColor  = BackViewColor;
    [centerView addSubview:linview];
    
  
    
    UIButton * sureBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame  = CGRectMake(typeLB.right +1, 0, 64, 46);
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor colorWithHex:0x3181FE] forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    sureBtn.adjustsImageWhenHighlighted = NO;
    
    [centerView addSubview:sureBtn ];
    UIView * linviews = [[UIView alloc]initWithFrame:CGRectMake(0, 45, centerView.width, 1)];
    linviews.backgroundColor  = BackViewColor;
    [centerView addSubview:linviews];
    
    
    
    [self addSubview:centerView];
}
-(void)makeSubView{
    leftselect = -1;
    UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddaction:)];
    tap.delegate= self;
    [self addGestureRecognizer:tap];
    _leftTv = [self makeLeftOrRight:YES];
    _rightTv =[self makeLeftOrRight:NO];
    
    [centerView addSubview:_leftTv];
    [centerView addSubview:_rightTv];
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
    UITableView * tablev =[[UITableView alloc]initWithFrame:CGRectMake(  left? 0:centerView.width/5*2,46  ,left?centerView.width/5*2:centerView.width/5*3, centerView.height - 46 ) style:UITableViewStylePlain];
    if (left){
        tablev.backgroundColor =[UIColor whiteColor];
    }else{
        tablev.backgroundColor =[UIColor colorWithHex:0xF7F7F7];
    }
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
        return  leftDataArray.count;
    }else{
        return  rightDataArray.count;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
    
    if (tableView == _leftTv) {
        
        LawSelectLeftCaseCell  * cell  =[tableView dequeueReusableCellWithIdentifier:@"cells"];
        if (cell == nil) {
            cell  =[[[NSBundle mainBundle ]loadNibNamed:@"LawSelectLeftCaseCell" owner:self options:nil]lastObject];
        }
        //    cell.model = dataArrray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.typeLabel.text = leftDataArray[indexPath.row];
        if (indexPath.row == leftselect) {
            cell.typeLabel.textColor= [UIColor colorWithHex:0x3181FE];
            cell.backgroundColor = BackViewColor;
        }else{
            cell.typeLabel.textColor = DEEPTintColor;
            cell.backgroundColor = [UIColor whiteColor];
        }
        return cell ;
    }else{
      
        
        
        LawzSekectRightCell  * cell  =[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell  =[[[NSBundle mainBundle ]loadNibNamed:@"LawzSekectRightCell" owner:self options:nil]lastObject];
        }
        //    cell.model = dataArrray[indexPath.row];
        cell.backgroundColor = BackViewColor;

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
 
        cell.CaseTypeLB.text = rightDataArray[indexPath.row];
        //        if ( [rightselectIDArray containsObject:indexPath.row]) {
        if ( [rightselectIDArray containsObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row]])  {
                cell.CaseTypeLB.textColor= [UIColor colorWithHex:0x3181FE];
                cell.SelectImage.image =[UIImage imageNamed:@"type_chose"];
            }else{
                cell.CaseTypeLB.textColor =DEEPTintColor;
                cell.SelectImage.image =[UIImage imageNamed:@"type_circle"];
                
            }
        return  cell ;

    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _leftTv) {
        leftselect = indexPath.row;
        //        刷新右侧 tv
        // 对数组乱序
        rightDataArray = [rightDataArray sortedArrayUsingComparator:^NSComparisonResult(NSString *str1, NSString *str2) {
            int seed = arc4random_uniform(2);
            
            if (seed) {
                return [str1 compare:str2];
            } else {
                return [str2 compare:str1];
            }
        }];
        [_rightTv  reloadData];
        [_leftTv reloadData];
    }else{

        [rightselectIDArray addObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
        [_rightTv  reloadData];
        
        NSLog(@"right -- %@",rightDataArray[indexPath.row]);
        
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

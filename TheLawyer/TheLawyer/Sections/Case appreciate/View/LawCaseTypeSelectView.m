//
//  LawCaseTypeSelectView.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/18.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawCaseTypeSelectView.h"
#import "LawCaseTypeCell.h"
@implementation LawCaseTypeSelectView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor =[UIColor colorWithHex:0x000000 alpha:.4];
        [self makeSubView];
     }
    return self;
}

-(void)setDataArray:(NSMutableArray *)DataArray{
    leftDataArray = @[@"法律咨询",@"刑事案件",@"劳动纠纷",@"婚姻家庭",@"刑事案件",@"劳动纠纷",@"婚姻家庭",@"刑事案件",@"劳动纠纷",@"婚姻家庭",@"刑事案件",@"劳动纠纷",@"婚姻家庭"];
    rightDataArray  =  [leftDataArray copy];
    
    
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
    leftselect = -1;
    rightselect = -1;
    UITableView * tablev =[[UITableView alloc]initWithFrame:CGRectMake(  left? 0:SCREENWIDTH/2,0  , SCREENWIDTH/2, self.TableViewHeight ) style:UITableViewStylePlain];
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
    
    LawCaseTypeCell  * cell  =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell  =[[[NSBundle mainBundle ]loadNibNamed:@"LawCaseTypeCell" owner:self options:nil]lastObject];
    }
    //    cell.model = dataArrray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
    if (tableView == _leftTv) {
        cell.CaseTypeLB.text = leftDataArray[indexPath.row];
        if (indexPath.row == leftselect) {
            cell.CaseTypeLB.backgroundColor= [UIColor colorWithHex:0x3181FE alpha:0.08];
        }else{
            cell.CaseTypeLB.backgroundColor =[UIColor whiteColor];
        }
    }else{
        cell.CaseTypeLB.text = rightDataArray[indexPath.row];
        if (indexPath.row == rightselect) {
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
        rightselect = indexPath.row;
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

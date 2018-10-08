//
//  LawCaseTypeSelectView.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/18.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawCaseTypeSelectView.h"
#import "LawCaseTypeCell.h"
#import "LawAddressModel.h"
@implementation LawCaseTypeSelectView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor =[UIColor colorWithHex:0x000000 alpha:.4];
     }
    return self;
}

-(void)setDataArray:(NSMutableArray *)DataArray{
    [self makeData ];
  
    
    _leftTv.frame  = CGRectMake(  0 ,0  , SCREENWIDTH/3, self.TableViewHeight );
    _rightTv.frame  = CGRectMake(  SCREENWIDTH/3 ,0  , SCREENWIDTH/3, self.TableViewHeight );
    _thredtTv.frame  = CGRectMake(  SCREENWIDTH/3 *2 ,0  , SCREENWIDTH/3, self.TableViewHeight );

    
    [_leftTv reloadData];
    [_rightTv reloadData];
    [_leftTv reloadData];
}
-(void)makeSubView{
  
    UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddaction:)];
    tap.delegate= self;
    [self addGestureRecognizer:tap];
    _leftTv = [self makeLeftOrRight:YES];
    _rightTv =[self makeLeftOrRight:NO];
    _thredtTv =[self makeLeftOrRight:NO];
    [self addSubview:_thredtTv];
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
        return  leftDataArray.count;
    }else if(tableView == _rightTv){
        return  rightDataArray.count;
    }else{
        return thridDataArray.count;
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
        LawAddressModel * model =  leftDataArray[indexPath.row];
         cell.CaseTypeLB.text = model.name;
        if ([model.name isEqualToString:self.ProviStr]) {
            cell.CaseTypeLB.backgroundColor= [UIColor colorWithHex:0x3181FE alpha:0.08];
            leftselect = indexPath.row;
        }else{
            cell.CaseTypeLB.backgroundColor =[UIColor whiteColor];
        }
    }else if(tableView == _rightTv){
        LawAddressModel * model =  rightDataArray[indexPath.row];
        cell.CaseTypeLB.text = model.name ;
        if ([model.name isEqualToString:self.CityStr]) {
            cell.CaseTypeLB.backgroundColor= [UIColor colorWithHex:0x3181FE alpha:0.08];
            rightselect = indexPath.row;

        }else{
            cell.CaseTypeLB.backgroundColor =[UIColor colorWithHex:0xf7f7f7];
        }
    }else{
        LawAddressModel * model =  thridDataArray[indexPath.row];
        cell.CaseTypeLB.text = model.name;
        if ([model.name isEqualToString:self.AreaStr]) {
            ThirdSelect = indexPath.row;
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
        rightselect =0;
        ThirdSelect = 0;
        LawAddressModel * procemod =leftDataArray[indexPath.row];
        self.ProviStr = procemod.name;
        
        rightDataArray =procemod.child;
        LawAddressModel * citymod = rightDataArray [0];
        self.CityStr = citymod.name;

        thridDataArray = citymod.child ;
        self.AreaStr = @"";

        [_thredtTv reloadData];
        [_rightTv  reloadData];
        [_leftTv reloadData];
    }else if(tableView == _rightTv){
        rightselect = indexPath.row;
        ThirdSelect = 0;
         LawAddressModel * citymod = rightDataArray [indexPath.row];
        self.CityStr = citymod.name;
        self.AreaStr = @"";

        thridDataArray = citymod.child ;
        [_thredtTv reloadData];
        [_rightTv  reloadData];
     }else{
        ThirdSelect = indexPath.row;
         [_thredtTv reloadData];
         LawAddressModel * leftmodel =  leftDataArray[leftselect ];
         LawAddressModel * rightmodel =  rightDataArray[rightselect];

         LawAddressModel * model =  thridDataArray[indexPath.row];
         self.AreaStr = model.name;

         if(self.seleAreaBlock){
     
            self.seleAreaBlock(leftmodel.id,rightmodel.id,model.id,[NSString stringWithFormat:@"%@ %@ %@",leftmodel.name,rightmodel.name,model.name]);
      }
    
     }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
    
}

-(void)makeData{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"AreaData" ofType:@"plist"];
    NSArray *   plistData = [NSMutableArray arrayWithContentsOfFile:path];
    leftDataArray =[[NSMutableArray alloc]init];
    for (NSDictionary * proDic in plistData) {
        //省
        LawAddressModel * proModel =[LawAddressModel yy_modelWithJSON:proDic];
       
//         显示的省份
        if([proModel.name  isEqualToString:self.ProviStr]){
            rightDataArray =[[NSMutableArray alloc]initWithArray:proModel.child];
//            显示的的市 ；
            for (LawAddressModel * cityModel in rightDataArray) {
                if([cityModel.name  isEqualToString:self.CityStr]){
                    thridDataArray = [[NSMutableArray alloc]initWithArray:cityModel.child];
            }
                
        }
    }
        [leftDataArray addObject:proModel];

    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

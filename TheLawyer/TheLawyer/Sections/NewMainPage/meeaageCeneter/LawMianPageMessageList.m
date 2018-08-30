//
//  LawMianPageMessageList.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/16.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawMianPageMessageList.h"
#import "LawMessageModel.h"
#import "LawMessageCenterCell.h"
@interface LawMianPageMessageList (){
    NSMutableArray * dataArrray ;
    UITableView * _tableView;
}

@end

@implementation LawMianPageMessageList


- (void)viewDidLoad {
    [super viewDidLoad];
    [self makedata];
      [self addView ];
    // Do any additional setup after loading the view.
}
-(void)makedata{
    
    dataArrray   =[[NSMutableArray alloc]init];
    for (int i = 0 ; i<10; i++) {
        LawMessageModel * model =[[LawMessageModel alloc]init];
        model.showBtn = [NSString stringWithFormat:@"%d",rand()%2];
        model.showRed = [NSString stringWithFormat:@"%d",rand()%2];
        
        [dataArrray addObject:model];
    }

}
-(void)addView{
    
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0,  10, SCREENWIDTH, SCREENHEIGHT -10 -  NavStatusBarHeight- 48) style:UITableViewStylePlain];
    _tableView.delegate=  self;
    _tableView.dataSource = self;
    _tableView.separatorInset =  UIEdgeInsetsMake(0, SCREENWIDTH, 0, 0);
    _tableView.backgroundColor =[UIColor whiteColor];
    _tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:_tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArrray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LawMessageCenterCell  * cell  =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell  =[[[NSBundle mainBundle ]loadNibNamed:@"LawMessageCenterCell" owner:self options:nil]lastObject];
    }
    cell.model = dataArrray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell ;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    LawMessageModel * modle =  dataArrray[indexPath.row];
    if ([modle.showBtn isEqualToString:@"1"]) {
        return 112;
    }else{
        return 80;
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

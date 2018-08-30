//
//  LawAnnouncementViewController.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/15.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawAnnouncementViewController.h"
#import "LawMainADCell.h"
@interface LawAnnouncementViewController (){
    NSMutableArray * _dataArray;
    
    UITableView *_tableView;
    
}

@end

@implementation LawAnnouncementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =BackViewColor;
    [self addCenterLabelWithTitle:@"公告" titleColor:nil];
    [self addView ];
    // Do any additional setup after loading the view.
}
-(void)addView{
    
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, NavStatusBarHeight +10, SCREENWIDTH, SCREENHEIGHT - NavStatusBarHeight -10) style:UITableViewStylePlain];
     _tableView.delegate=  self;
    _tableView.dataSource = self;
    _tableView.backgroundColor =[UIColor whiteColor];
    _tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:_tableView];
}
 -(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
         return 2; //dataArrray.count;
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        return 110 ;
 
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LawMainADCell  * cell  =[tableView dequeueReusableCellWithIdentifier:@"LawMainADCell"];
        if (cell == nil) {
            cell  =[[[NSBundle mainBundle ]loadNibNamed:@"LawMainADCell" owner:self options:nil]lastObject];
        }
    
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell;
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

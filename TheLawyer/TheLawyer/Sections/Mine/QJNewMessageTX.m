//
//  QJNewMessageTX.m
//  Lawyer
//
//  Created by MYMAc on 2017/10/20.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJNewMessageTX.h"
#import "QJNewMessageTSCell.h"
@interface QJNewMessageTX (){
    NSUserDefaults * UserDefaults;
    
}

@end

@implementation QJNewMessageTX

- (void)viewDidLoad {
    [super viewDidLoad];
    UserDefaults = [NSUserDefaults standardUserDefaults];
    self.title= @"新消息提示设置";
    // Do any additional setup after loading the view from its nib.
    
    _TV =[[UITableView alloc]initWithFrame:CGRectMake(0, NavStatusBarHeight, ConentViewWidth, ConentViewHeight) style:UITableViewStylePlain];
    _TV.tableFooterView =[[UIView alloc]init];
    _TV.delegate= self;
    _TV.dataSource= self;
    
    [self.view addSubview:_TV];
    dataArray =@[@"声音",@"震动"];
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    QJNewMessageTSCell  * cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell =[[[NSBundle mainBundle ]loadNibNamed:@"QJNewMessageTSCell" owner:self options:nil]lastObject];
    }
    cell.SwitchBlock = ^(BOOL IsOpen) {
        if (IsOpen) {// 打开
            if ( indexPath.row == 0) {// 声音
                
                [UserDefaults  setObject:@"YES" forKey:@"Sounds"];
             }else{
                 [UserDefaults  setObject:@"YES" forKey:@"vibration"];
 
            }
                
          }else{// 关闭
                    if ( indexPath.row == 0) {// 声音
                        [UserDefaults  setObject:@"NO" forKey:@"Sounds"];

                    }else{
                        [UserDefaults  setObject:@"NO" forKey:@"vibration"];
                    }
            
        }
        [UserDefaults synchronize];
    };
    
    if (indexPath.row == 0) {
        NSString * SoundsStr = [UserDefaults  objectForKey:@"Sounds"];
        if ([SoundsStr isEqualToString:@"YES"]) {
            cell.Switch.on = YES;
        }else{
            cell.Switch.on = NO;

          
        }
        cell.FirstLB.text = @"声音";
    }else if (indexPath.row == 1){
        cell.FirstLB.text = @"震动";

        NSString * Vibrate  =  [UserDefaults  objectForKey:@"vibration"];

        if ([Vibrate isEqualToString:@"YES"]) {
            cell.Switch.on = YES;
         }else{
            cell.Switch.on = NO;
        }
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
    return  dataArray.count;
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

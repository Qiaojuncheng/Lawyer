//
//  LawSeletAreaViewController.m
//  TheLawyer
//
//  Created by MYMAc on 2018/8/23.
//  Copyright © 2018年 shangyukeji. All rights reserved.
//

#import "LawSeletAreaViewController.h"
#import "LawCaseTypeSelectView.h"
@interface LawSeletAreaViewController (){
    UILabel *cityLb ;
}
@property (strong , nonatomic) LawCaseTypeSelectView * caseSelectView;
@end

@implementation LawSeletAreaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCenterLabelWithTitle:@"选择地域" titleColor:nil];
    [self addtopView];
    [self.view addSubview:self.caseSelectView];
    __strong typeof(self) StrongSelf  =  self;
    self.caseSelectView.ProviStr =self.ProviStr;
    self.caseSelectView.CityStr =self.CityStr;
    self.caseSelectView.AreaStr =self.AreaStr;
    [self.caseSelectView makeSubView];
    self.caseSelectView.seleAreaBlock = ^(NSString *Proid, NSString *Cityid, NSString *Areamid, NSString *areaStr) {
        if ( StrongSelf.SelectAreaBlock) {
            StrongSelf.SelectAreaBlock(Proid, Cityid, Areamid, areaStr);
            [StrongSelf.navigationController popViewControllerAnimated:YES];
        }
    };
     self.caseSelectView.hidden = NO ;
    self.caseSelectView.DataArray   =[[NSMutableArray alloc]init];
    // Do any additional setup after loading the view.
}
-(void)addtopView{
    self.view.backgroundColor = BackViewColor;
    UIView * topview =[[UIView alloc]initWithFrame:CGRectMake(0, NavStatusBarHeight+1, SCREENWIDTH, 58)];
    cityLb  =[[UILabel alloc]initWithFrame:CGRectMake(17, 17, SCREENWIDTH - 34  , 24)];
    cityLb.font = [UIFont systemFontOfSize:13];
    cityLb.text = @"请选择城市";
    cityLb.textColor =[UIColor colorWithHex:0x999999];
    [topview addSubview:cityLb];
    topview.backgroundColor =  [UIColor whiteColor];
    
    [self.view addSubview:topview];
    
    
}
-(LawCaseTypeSelectView *)caseSelectView{
    if (!_caseSelectView) {
        _caseSelectView = [[LawCaseTypeSelectView alloc]initWithFrame:CGRectMake(0, NavStatusBarHeight + 60, SCREENWIDTH, SCREENHEIGHT -  NavStatusBarHeight - 60  )];;
         _caseSelectView.TableViewHeight = _caseSelectView.height;
    }
    return _caseSelectView;
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

//
//  QJCSelectView.m
//  TheLawyer
//
//  Created by MYMAc on 2017/11/6.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import "QJCSelectView.h"

@implementation QJCSelectView{
    //   一级
    NSString * FirstStr;
    NSString * FirstID;
    
    //   二级
    NSString * seconderStr;
    NSString * seconderId;
    
    //   三级
    NSString * ThirdStr;
    NSString * ThirdId;

    
    
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)RemoveVIew:(UIButton *)sender{
    
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, 250);
    } completion:^(BOOL finished) {
        [sender removeFromSuperview];
        [self removeFromSuperview];
    }];
    
}

-(void)ShowPicker{
    
    
    UIButton * backBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
    backBtn.tag = 21;
    [backBtn addTarget:self action:@selector(RemoveVIew:) forControlEvents:UIControlEventTouchUpInside];
    [self.superview addSubview:backBtn];
    [self.superview bringSubviewToFront:self];
    
    self.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    // 创建 确定和取消按钮
    for (int i = 0; i< 2; i++) {
        UIButton * bu =[ UIButton buttonWithType:UIButtonTypeCustom];
        if (i== 0) {
            bu.frame =CGRectMake(10, 10, 50 , 35);
            [bu setTitle:@"取消" forState:UIControlStateNormal];
        }else{
            bu.frame =CGRectMake(self.frame.size.width - 60, 10, 50, 35);
            [bu setTitle:@"确定" forState:UIControlStateNormal];
        }
        [bu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [bu addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        bu.tag = 20+i;
        [self addSubview:bu];
    }
    //获取数据源
    
    [self makeData];
    
    
    //  创建pickView；
    self.selectAreaPick = [[ UIPickerView  alloc] initWithFrame:CGRectMake(0, 50, self.bounds.size.width, 200)];
    
    self.selectAreaPick.dataSource = self;
    self.selectAreaPick.delegate =self;
    [self addSubview:self.selectAreaPick];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = CGRectMake(0, SCREENHEIGHT - 250, SCREENWIDTH, 250);
    }];
    
    
}

#pragma mark  获取数据源

-(void)makeData{
    
    
    
    //    NSDictionary *dataDict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"lot" ofType:@"plist"]];
    
    FirstDataArray =[[NSMutableArray alloc]initWithArray:_dataArray];
    
    
    SecondDataArray  =[[NSArray alloc]initWithArray:[FirstDataArray[0] objectForKey:@"second_child"]];
    ThirdDataArray  =[[NSArray alloc]initWithArray:[SecondDataArray[0] objectForKey:@"third_child"]];
    
    
     FirstStr  =  [FirstDataArray[0] objectForKey:@"cat_name"];
    FirstID =[FirstDataArray[0] objectForKey:@"cat_id"] ;
    seconderStr =  [SecondDataArray[0] objectForKey:@"cat_name"];
    seconderId = [SecondDataArray[0] objectForKey:@"cat_id"];
    if (ThirdDataArray.count >  0) {
        ThirdStr = [ThirdDataArray[0] objectForKey:@"cat_name"];
        ThirdId = [ThirdDataArray[0] objectForKey:@"cat_id"];
        
    }else{
        ThirdStr = @"";
    }
    
    
}

#pragma mark   pickViewdelegate


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component ==0) {
        return  FirstDataArray.count;
    }else if (component == 1){
        return  SecondDataArray.count;
    }else{
        return  ThirdDataArray.count;
    }
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component ==0) {
        return  [FirstDataArray[row] objectForKey:@"cat_name"];
    }else if (component == 1){
        return  [SecondDataArray[row] objectForKey:@"cat_name"];
    }else{
        return  [ThirdDataArray[row] objectForKey:@"cat_name"];
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    
    if (component ==0) {
        
        
        
        
        // 获取 城市  区域 数据  刷新
        SecondDataArray  =[[NSArray alloc]initWithArray:[FirstDataArray[row] objectForKey:@"second_child"]];
        ThirdDataArray  =[[NSArray alloc]initWithArray:[SecondDataArray[0] objectForKey:@"third_child"]];
        
        
        FirstStr  =  [FirstDataArray[row] objectForKey:@"cat_name"];
        FirstID =[FirstDataArray[row] objectForKey:@"cat_id"] ;
        
        seconderStr =  [SecondDataArray[0] objectForKey:@"cat_name"];
        seconderId = [SecondDataArray[0] objectForKey:@"cat_id"];
        
        if (ThirdDataArray.count >  0) {
            ThirdStr = [ThirdDataArray[0] objectForKey:@"cat_name"];
            ThirdId = [ThirdDataArray[0] objectForKey:@"cat_id"];
            
        }else{
            ThirdStr = @"";
        }
        
        [self.selectAreaPick reloadComponent:1];
        [self.selectAreaPick reloadComponent:2];
        
    }else if (component == 1){
        // 获取 区域 数据  刷新
        ThirdDataArray  =[[NSArray alloc]initWithArray:[SecondDataArray[row] objectForKey:@"third_child"]];
        
        seconderStr =  [SecondDataArray[row] objectForKey:@"cat_name"];
        seconderId = [SecondDataArray[row] objectForKey:@"cat_id"];
        
        if (ThirdDataArray.count >  0) {
            ThirdStr = [ThirdDataArray[0] objectForKey:@"cat_name"];
            ThirdId = [ThirdDataArray[0] objectForKey:@"cat_id"];
            
            
        }else{
            ThirdStr = @"";
        }
        
        
        [self.selectAreaPick reloadComponent:2];
        
    }else{
        
        if (ThirdDataArray.count >  0) {
            ThirdStr = [ThirdDataArray[row] objectForKey:@"cat_name"];
            ThirdId = [ThirdDataArray[row] objectForKey:@"cat_id"];
            
            
        }else{
            ThirdStr = @"";
        }
        
        
    }
    
    
    
    
    
    
    
    
    
}


-(void)btnAction:(UIButton *)sender{
    
    
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, 250);
    } completion:^(BOOL finished) {
        
        UIButton * backBtn =[self.superview viewWithTag:21];
        [backBtn removeFromSuperview];
        [self removeFromSuperview];
        
    }];
    
    
    if (sender.tag == 20) {
        
        self.CertainBlock(NO, nil, nil, nil, nil);
    }else{
        // 返回选中的地区
        NSString * BactStr;
        if ([ThirdStr  isEqualToString: @""]) {
            BactStr = [NSString stringWithFormat:@"%@ %@", FirstStr,seconderStr ];
        }else{
            BactStr = [NSString stringWithFormat:@"%@ %@ %@", FirstStr,seconderStr,ThirdStr];
        }
        self.CertainBlock(YES, BactStr, FirstID, seconderId, ThirdId);
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

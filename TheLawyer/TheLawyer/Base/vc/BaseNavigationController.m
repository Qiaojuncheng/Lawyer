//
//  BaseNavigationController.m
//  TheLawyer
//
//  Created by yaoyao on 17/7/18.
//  Copyright © 2017年 shangyukeji. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)popViewController:(NSInteger)index{
    if (index <= 0) {
        return;
    }
    NSMutableArray *allVCArray = [[NSMutableArray alloc] initWithArray:self.viewControllers];
    NSMutableArray *newVCArray = [[NSMutableArray alloc] init];
    if (allVCArray.count > index) {
        for (int i =0; i<=allVCArray.count - index; i++) {
            [newVCArray addObject:[allVCArray objectAtIndex:i]];
        }
    }
    [self setViewControllers:newVCArray];
    [self popViewControllerAnimated:YES];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if (self.viewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
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

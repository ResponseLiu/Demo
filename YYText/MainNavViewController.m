//
//  MainNavViewController.m
//  YYText
//
//  Created by 1 on 2017/10/13.
//  Copyright © 2017年 com.wh1.guozhentang. All rights reserved.
//

#import "MainNavViewController.h"

@interface MainNavViewController ()

@end

@implementation MainNavViewController
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Demo";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    if (@available(iOS 11.0, *)) {
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//        self.navigationController.navigationBar.prefersLargeTitles = true;
        self.navigationController.navigationBar.largeTitleTextAttributes= @{NSForegroundColorAttributeName:[UIColor whiteColor]};
        self.navigationItem.largeTitleDisplayMode =  UINavigationItemLargeTitleDisplayModeAlways;
        self.navigationItem.hidesSearchBarWhenScrolling = NO;
        self.navigationItem.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    } else {
        // Fallback on earlier versions
    }
   
    // Do any additional setup after loading the view.
}
+(void)initialize{
    
   
    
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

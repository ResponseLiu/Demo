//
//  BannerScrollViewController.m
//  YYText
//
//  Created by 1 on 2017/10/21.
//  Copyright © 2017年 com.wh1.guozhentang. All rights reserved.
//

#import "BannerScrollViewController.h"
#import "BSYScrollView.h"
@interface BannerScrollViewController ()

@end

@implementation BannerScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    BSYScrollView *scroll = [[BSYScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 200)];
    scroll.imageArra=@[@"1.jpg",@"2.jpg"];
    
    [self.view addSubview:scroll];
    
    scroll.selectIndex = ^(NSInteger index) {
      
        NSLog(@"---%ld",index);
        
    };
    
    // Do any additional setup after loading the view.
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

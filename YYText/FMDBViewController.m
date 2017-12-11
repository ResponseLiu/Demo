//
//  FMDBViewController.m
//  YYText
//
//  Created by 1 on 2017/9/16.
//  Copyright © 2017年 com.wh1.guozhentang. All rights reserved.
//

#import "FMDBViewController.h"
#import "FMDBManager.h"
@interface FMDBViewController ()

@end

@implementation FMDBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[FMDBManager SharedManager] createFile:@"DB" with:@"/file.db"];
    [[FMDBManager SharedManager]threadFMDB:5];
    self.view.backgroundColor = [UIColor whiteColor];
    
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

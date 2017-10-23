//
//  DownLoadViewController.m
//  YYText
//
//  Created by 1 on 2017/10/14.
//  Copyright © 2017年 com.wh1.guozhentang. All rights reserved.
//

#import "DownLoadViewController.h"
#import "DownLoadManager.h"
@interface DownLoadViewController ()

@property(nonatomic,strong)UIProgressView *progress;

@property(nonatomic,strong)UIButton *starDownLoad;

@property(nonatomic,strong)UIButton *endDownLoad;


@end

@implementation DownLoadViewController
//
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"大文件下载";
    self.view.backgroundColor = [UIColor whiteColor];
    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = NO;
    } else {
        // Fallback on earlier versions
    }
    [self.view addSubview:self.progress];
    [self.view addSubview:self.starDownLoad];
    [self.view addSubview:self.endDownLoad];
    __weak typeof(self) weakself = self;
    [DownLoadManager Shared].progress = ^(float progress){
        
        weakself.progress.progress = progress;
        
    };
    [DownLoadManager Shared].finish = ^(NSString *path){
        
        NSLog(@"---完成");
    };
    // Do any additional setup after loading the view.
}
-(UIProgressView *)progress{
    
    if (!_progress) {
    
        _progress =[[UIProgressView alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
        _progress.backgroundColor = [UIColor redColor];
        _progress.tintColor = [UIColor blackColor];
        _progress.center = CGPointMake(self.view.center.x, 250);
    }
    return _progress;
}
-(UIButton *)starDownLoad{
    
    if (!_starDownLoad) {
        
        _starDownLoad = [UIButton buttonWithType:0];
        _starDownLoad.frame = CGRectMake(self.view.frame.size.width/2, CGRectGetMaxY(self.progress.frame)+50, 80, 40);
        [_starDownLoad setTitle:@"开始下载" forState:0];
        [_starDownLoad setTitleColor:[UIColor blackColor] forState:0];
        [_starDownLoad addTarget:self action:@selector(download) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _starDownLoad;
}

-(void)download{
    
    if (self.starDownLoad.isSelected) {

        [[DownLoadManager Shared]pause];
        [self.starDownLoad setTitle:@"开始下载" forState:0];

    }else{

        [self.starDownLoad setTitle:@"暂停" forState:0];
        [[DownLoadManager Shared]startDownLoad:[NSURL URLWithString:@"http://dlsw.baidu.com/sw-search-sp/soft/9d/25765/sogou_mac_32c_V3.2.0.1437101586.dmg"]];
    }
    
    self.starDownLoad.selected = !self.starDownLoad.selected;
  
 
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

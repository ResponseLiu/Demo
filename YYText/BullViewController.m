//
//  BullViewController.m
//  YYText
//
//  Created by 1 on 2017/9/5.
//  Copyright © 2017年 com.wh1.guozhentang. All rights reserved.
//

#import "BullViewController.h"
#import "BulletManager.h"
#import "BulletView.h"
@interface BullViewController ()
@property(nonatomic,strong)BulletManager *manager;
@end

@implementation BullViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame  = CGRectMake(100, 370, 100, 40);
    [btn setTitle:@"点击我" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"1111"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    

    self.navigationItem.title=@"弹幕";
    
    self.manager=[[BulletManager alloc]init];
    
  
    __weak typeof(self) weakself = self;
    
    self.manager.generateBulletBlock = ^(BulletView *view) {
        
        
  
        [weakself addBulletView:view];
        
    };

    // Do any additional setup after loading the view.
}
- (void)clickBtn {
      [self.manager start];
}

-(void)addBulletView:(BulletView *)view{

    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    view.frame = CGRectMake(width, view.trajectory*40+100, CGRectGetWidth(view.bounds), CGRectGetHeight(view.bounds));
    
    [self.view addSubview:view];
    [view startAnimation];


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

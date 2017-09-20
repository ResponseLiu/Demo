//
//  ViewController4.m
//  YYText
//
//  Created by 1 on 2017/9/20.
//  Copyright © 2017年 com.wh1.guozhentang. All rights reserved.
//

#import "ViewController4.h"
#import "TransitionModel.h"
@interface ViewController4 ()<UIViewControllerTransitioningDelegate>

@end

@implementation ViewController4

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    
    self.transitioningDelegate = self;
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    
    button.backgroundColor = [UIColor whiteColor];
    [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

    
    // Do any additional setup after loading the view.
}
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{

    return [TransitionModel PushWithTransition:XPresentWithPresent];


}
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{

    return [TransitionModel PushWithTransition:XPressentWithDismiss];

}
-(void)dismiss{

    [self dismissViewControllerAnimated:YES completion:nil];

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

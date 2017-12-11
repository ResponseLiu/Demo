//
//  ViewController4.m
//  YYText
//
//  Created by 1 on 2017/9/20.
//  Copyright © 2017年 com.wh1.guozhentang. All rights reserved.
//

#import "ViewController4.h"
#import "TransitionModel.h"
@interface ViewController4 ()<UIViewControllerTransitioningDelegate,UINavigationControllerDelegate>

@end

@implementation ViewController4

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = false;
    } else {
        // Fallback on earlier versions
    }
    self.view.backgroundColor = [UIColor blueColor];
    self.transitioningDelegate = self;
    self.navigationController.delegate = self;
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    
    button.backgroundColor = [UIColor whiteColor];
    [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

    
    // Do any additional setup after loading the view.
}
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    
    // If the animation operation now is push, return custom transition.
    // 判断如果当前执行的是Push操作，就返回我们自定义的push动画对象。
    
    if ( operation == UINavigationControllerOperationPush) {
        
        return [TransitionModel PushWithTransition:XPresentWithPresent];
    }else{
    
    
     return [TransitionModel PushWithTransition:XPressentWithDismiss];
    
    }
       
}


-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{

    return [TransitionModel PushWithTransition:XPresentWithPresent];


}
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{

    return [TransitionModel PushWithTransition:XPressentWithDismiss];

}
-(void)dismiss{

    [self.navigationController popViewControllerAnimated:YES];

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

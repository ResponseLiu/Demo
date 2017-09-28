//
//  ViewController3.m
//  YYText
//
//  Created by 1 on 2017/9/20.
//  Copyright © 2017年 com.wh1.guozhentang. All rights reserved.
//

#import "ViewController3.h"
#import "ViewController4.h"
#import "TransitionModel.h"
@interface ViewController3 ()<UINavigationControllerDelegate>

@end

@implementation ViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
      self.navigationController.delegate = self;
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    
    button.backgroundColor = [UIColor whiteColor];
    [button addTarget:self action:@selector(Click) forControlEvents:UIControlEventTouchUpInside];
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
-(void)Click{



    ViewController4 *four = [[ViewController4 alloc]init];
    
    [self.navigationController pushViewController:four animated:YES];

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

//
//  LayerViewController.m
//  YYText
//
//  Created by 1 on 2017/8/10.
//  Copyright © 2017年 com.wh1.guozhentang. All rights reserved.
//

#import "LayerViewController.h"

@interface LayerViewController ()

@end

@implementation LayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor whiteColor];
    //change
    [self circle];
    [self load];
    [self load2];

}
-(void)load{

    CAReplicatorLayer *replicalayer1 = [[CAReplicatorLayer alloc]init];
    
    replicalayer1.frame = CGRectMake(0, 0, 100, 100);
    
    replicalayer1.position = CGPointMake(self.view.center.x, self.view.center.y+150);
    replicalayer1.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.2].CGColor;
    
    replicalayer1.cornerRadius = 10;
    [self.view.layer addSublayer:replicalayer1];
    
    
    
    CALayer *dotLayer1        = [CALayer layer];
    dotLayer1.bounds          = CGRectMake(0, 0, 15, 15);
    dotLayer1.position        = CGPointMake(15, replicalayer1.frame.size.height/2 );
    dotLayer1.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.6].CGColor;
    dotLayer1.cornerRadius    = 7.5;
    [replicalayer1 addSublayer:dotLayer1];
    
    CGFloat count                     =  10.0;
    replicalayer1.instanceCount     = count;
    CGFloat angel                     = 2* M_PI/count;
    replicalayer1.instanceTransform = CATransform3DMakeRotation(angel, 0, 0, 1);
    replicalayer1.instanceDelay = 1.0/10;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration    = 1.0;
    animation.fromValue   = @1;
    animation.toValue     = @0;
    animation.repeatCount = MAXFLOAT;
    [dotLayer1 addAnimation:animation forKey:nil];




}
-(void)circle{

    //可以复制子类
    CAReplicatorLayer *replicalayer = [[CAReplicatorLayer alloc]init];
    replicalayer.instanceCount = 3;
    replicalayer.instanceDelay = 0.3;
    [self.view.layer addSublayer:replicalayer];
    
    
    
    CALayer *dotLayer        = [CALayer layer];
    dotLayer.bounds          = CGRectMake(0, 0, 20, 20);
    dotLayer.position        = self.view.center;
    dotLayer.backgroundColor = [UIColor redColor].CGColor;
    dotLayer.cornerRadius    = 10;
    [replicalayer addSublayer:dotLayer];
    
    
    
    
    CABasicAnimation *base = [CABasicAnimation animationWithKeyPath:@"transform"];
    base.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(10, 10, 1)];
    base.duration = 2;
    
    
    
    
    CABasicAnimation *alpha = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alpha.toValue = @0;
    alpha.duration = 2;
    
    
    
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[base,alpha];
    group.duration = 2;
    group.repeatCount = MAXFLOAT;
    group.removedOnCompletion = NO;
    [dotLayer addAnimation:group forKey:nil];

}
-(void)load2{
    
    CAReplicatorLayer *replicalayer1 = [[CAReplicatorLayer alloc]init];
    
    replicalayer1.frame = CGRectMake(0, 0, 100, 100);
    
    replicalayer1.position = CGPointMake(self.view.center.x, self.view.center.y-150);
    replicalayer1.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.2].CGColor;
    
    replicalayer1.cornerRadius = 10;
    [self.view.layer addSublayer:replicalayer1];
    
    
    
    CALayer *dotLayer1        = [CALayer layer];
    dotLayer1.bounds          = CGRectMake(0, 0, 15, 15);
    dotLayer1.position        = CGPointMake(15, replicalayer1.frame.size.height/2 );
    dotLayer1.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.6].CGColor;
    dotLayer1.cornerRadius    = 7.5;
    [replicalayer1 addSublayer:dotLayer1];
    
    replicalayer1.instanceCount = 3;
    replicalayer1.instanceTransform = CATransform3DMakeTranslation(replicalayer1.frame.size.width/3, 0, 0);
    replicalayer1.instanceDelay = 1.0/3;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration    = 1.0;
    animation.fromValue   = @1;
    animation.toValue     = @0;
    animation.repeatCount = MAXFLOAT;
    [dotLayer1 addAnimation:animation forKey:nil];
    
    
    
    
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

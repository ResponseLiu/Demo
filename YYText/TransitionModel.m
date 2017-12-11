//
//  TransitionModel.m
//  YYText
//
//  Created by 1 on 2017/9/20.
//  Copyright © 2017年 com.wh1.guozhentang. All rights reserved.
//

#import "TransitionModel.h"

@implementation TransitionModel

+(instancetype)PushWithTransition:(XPresentTransitionType)type
{

    return [[self alloc]initWithTransition:type];

}
-(instancetype)initWithTransition:(XPresentTransitionType)type
{
    if (self = [super init]) {
        
        _type = type;
    }
    
    return self;
}
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{

    return .6;
}
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{

    if (self.type == XPresentWithPresent) {
        
        [self presentWith:transitionContext];
        
    }else{
    
        [self presentWith:transitionContext];
    }
}
-(void)presentWith:(id<UIViewControllerContextTransitioning>)transitionContext{

    UIViewController *fromVC=[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIViewController *toVC=[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *contain = [transitionContext containerView];
    
    UIView * tempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    tempView.frame = fromVC.view.frame;
    
    fromVC.view.hidden = YES;
    
    [contain addSubview:toVC.view];
    [contain addSubview:tempView];
   
    [UIView animateWithDuration:.6 animations:^{
        
        tempView.alpha = 0;
       
    } completion:^(BOOL finished) {
        
         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        
        [tempView removeFromSuperview];
        fromVC.view.hidden = NO;
        
    }];
}
-(void)dismissWith:(id<UIViewControllerContextTransitioning>)transitionContext{



}
@end

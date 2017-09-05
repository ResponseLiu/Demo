//
//  AnimationView.m
//  YYText
//
//  Created by 1 on 2017/8/10.
//  Copyright © 2017年 com.wh1.guozhentang. All rights reserved.
//

#import "AnimationView.h"

@implementation AnimationView
-(instancetype)initWithFrame:(CGRect)frame{

    if (self =[super initWithFrame:frame]) {
        
        self.btnArra = [NSMutableArray array];
        NSArray *image = @[@"tabbar_compose_friend@2x",@"tabbar_compose_friend@2x",@"tabbar_compose_friend@2x",@"tabbar_compose_friend@2x",@"tabbar_compose_friend@2x",@"tabbar_compose_friend@2x"];
        
        
        for (int i = 0; i < 6; i ++) {
            
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",image[i]]] forState:0];
            CGFloat x = (i % 3) * 375 / 3.0;
            CGFloat y = (i / 3) * 240/2;
            
            CGFloat width = self.frame.size.width / 3.0;
            CGFloat height =  self.frame.size.width / 3.0;
            [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            
            btn.frame = CGRectMake(x, y, width, height);
            NSLog(@"%f",x);
            [self.btnArra addObject:btn];
            NSLog(@"originY：%f",y);
       
        }
         [self animate];
        
    }

    return self;

}
-(void)click{


    [self.btnArra enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIButton * btn = obj;
        CGFloat x = btn.frame.origin.x;
        CGFloat y = btn.frame.origin.y;
        CGFloat width = btn.frame.size.width;
        CGFloat height = btn.frame.size.height;
       
   
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((self.btnArra.count-idx) * 0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
             
                 btn.frame = CGRectMake(x, [UIScreen mainScreen].bounds.size.height + y-self.frame.origin.y, width, height);
            } completion:^(BOOL finished) {
                
            }];
        });
        
    }];

}
-(void)animate{

    NSLog(@"---%f",self.frame.origin.y);
    [self.btnArra enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIButton * btn = obj;
        CGFloat x = btn.frame.origin.x;
        CGFloat y = btn.frame.origin.y;
        CGFloat width = btn.frame.size.width;
        CGFloat height = btn.frame.size.height;
        //这里的话，需要自己计算出一个合适的y值
        btn.frame = CGRectMake(x, [UIScreen mainScreen].bounds.size.height + y-self.frame.origin.y, width, height);
        btn.alpha = 0.0;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(idx * 0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:.8 initialSpringVelocity:35 options:UIViewAnimationOptionCurveEaseIn animations:^{
                btn.alpha = 1;
                btn.frame = CGRectMake(x, y, width, height);
            } completion:^(BOOL finished) {

            }];
        });
        
    }];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

//
//  BulletView.m
//  YYText
//
//  Created by 1 on 2017/9/5.
//  Copyright © 2017年 com.wh1.guozhentang. All rights reserved.
//
#import "BulletView.h"
@implementation BulletView


-(instancetype)initWithComment:(NSString *)comment{
  
    if (self=[super init]) {
        
        NSLog(@"---%@",comment);
        self.backgroundColor=[UIColor redColor];
        
        NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
        
        CGFloat width = [comment sizeWithAttributes:dic].width;
        self.bounds = CGRectMake(0, 0, width+2*10, 30);
        
        self.lbComment.text = comment;;
        self.lbComment.frame=CGRectMake(10, 0, width, 30);
    }
    return self;
}

-(UILabel *)lbComment{
   
    if (!_lbComment) {
        
        _lbComment = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbComment.font = [UIFont systemFontOfSize:14];
        _lbComment.textColor=[UIColor whiteColor];
        _lbComment.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_lbComment];
        
        
    }
    return _lbComment;
}

-(void)startAnimation{

    CGFloat screenwidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat duration = 4.0;
    CGFloat wholeWidth = screenwidth+CGRectGetWidth(self.bounds);
    
    __block CGRect frame = self.frame;
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        frame.origin.x-=wholeWidth;
        
        self.frame=frame;
        
    } completion:^(BOOL finished) {
        
        if (self.moveStatusBlock) {
            
            self.moveStatusBlock();
        }
    }];
}

-(void)stopAnimation{

    [self removeFromSuperview];
    [self.layer removeAllAnimations];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

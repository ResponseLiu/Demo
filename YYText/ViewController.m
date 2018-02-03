//
//  ViewController.m
//  YYText
//
//  Created by 1 on 2017/8/9.
//  Copyright © 2017年 com.wh1.guozhentang. All rights reserved.
//

#import "ViewController.h"
#import <YYText.h>
#import "YYTextManager.h"

@interface ViewController ()
@property (strong, nonatomic) CABasicAnimation *translate;
@property(nonatomic,strong)CAGradientLayer *gradientLayer;
@property (assign, nonatomic) CATransform3D startT, endT;

@property(nonatomic,strong)UIImageView *image;

@property(nonatomic,strong)CAShapeLayer *layer;

@property(nonatomic,strong)CAShapeLayer *masklayer;

@property(nonatomic,strong)UIBezierPath *maskpatch;
@end

@implementation ViewController
- (CABasicAnimation *)translate {
    if (_translate == nil) {
        _translate = [CABasicAnimation animationWithKeyPath:@"transform"];
        _translate.duration = 2;
        _translate.repeatCount = MAXFLOAT;
        //        _translate.autoreverses = self.shimmerType == ST_AutoReverse ? true : false;
    }
    
    return _translate;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = false;
    } else {
        // Fallback on earlier versions
    }
     self.view.backgroundColor = [UIColor whiteColor];
    CGSize size = CGSizeMake(self.view.frame.size.width-20, CGFLOAT_MAX);
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:size text: [[YYTextManager SharedManager]regionAt_manager]];
    NSLog(@"---%f",layout.textBoundingSize.height);
    YYLabel *label2 = [YYLabel new];
    label2.highlightTapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
        NSString *click = [text.string substringWithRange:range];
        NSLog(@"---%@",click);
        YYTextHighlight *height = [text yy_attribute:YYTextHighlightAttributeName atIndex:range.location];
        
        
    };
    label2.frame = CGRectMake(10, 64, self.view.frame.size.width-20, layout.textBoundingSize.height);
    label2.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    label2.numberOfLines = 0;
    label2.backgroundColor = [UIColor whiteColor];
    label2.attributedText = [[YYTextManager SharedManager]regionAt_manager];
    label2.textLayout = layout;
    [self.view addSubview:label2];
    
    
    YYLabel *label1 = [YYLabel new];
    label1.frame = CGRectMake(10, CGRectGetMaxY(label2.frame), self.view.frame.size.width-20, 100);
    label1.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    label1.numberOfLines = 0;
    label1.backgroundColor = [UIColor whiteColor];
    label1.textParser = [[YYTextManager SharedManager]emotionActPic];
    label1.attributedText = [[YYTextManager SharedManager]emotionAct];
    [self.view addSubview:label1];

    //刮奖效果
    
    _image = [[UIImageView alloc]initWithFrame:self.view.frame];

    _image.image = [UIImage imageNamed:@"1"];

    [self.view addSubview:_image];
    
  
    
    // Do any additional setup after loading the view, typically from a nib.
}

// 随机颜色方法
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch * touch =  touches.anyObject;

    CGPoint point  =[touch locationInView:self.image];

    CGRect rect =CGRectMake(point.x, point.y, 30, 30);

    UIGraphicsBeginImageContext(self.image.frame.size);

    CGContextRef ref =  UIGraphicsGetCurrentContext();
    
    [self.image.layer renderInContext:ref];

    CGContextClearRect(ref, rect);

    UIImage *new = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    self.image.image = new;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

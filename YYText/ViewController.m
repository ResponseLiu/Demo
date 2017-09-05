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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor whiteColor];
    CGSize size = CGSizeMake(self.view.frame.size.width-20, CGFLOAT_MAX);
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:size text: [[YYTextManager SharedManager]regionAt_manager]];
    NSLog(@"---%f",layout.textBoundingSize.height);
    YYLabel *label = [YYLabel new];
    label.highlightTapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
        
        YYTextHighlight *height = [text yy_attribute:YYTextHighlightAttributeName atIndex:range.location];
        NSLog(@"---%@",height.userInfo);
        
    };
    label.frame = CGRectMake(10, 64, self.view.frame.size.width-20, layout.textBoundingSize.height);
    label.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor whiteColor];
    label.attributedText = [[YYTextManager SharedManager]regionAt_manager];
    label.textLayout = layout;
    [self.view addSubview:label];
    
    
    YYLabel *label1 = [YYLabel new];
    label1.frame = CGRectMake(10, CGRectGetMaxY(label.frame), self.view.frame.size.width-20, 100);
    label1.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    label1.numberOfLines = 0;
    label1.backgroundColor = [UIColor whiteColor];
    label1.textParser = [[YYTextManager SharedManager]emotionActPic];
    label1.attributedText = [[YYTextManager SharedManager]emotionAct];
    [self.view addSubview:label1];
    
    

    // Do any additional setup after loading the view, typically from a nib.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

//
//  ViewController1.m
//  YYText
//
//  Created by 1 on 2017/8/10.
//  Copyright © 2017年 com.wh1.guozhentang. All rights reserved.
//

#import "ViewController1.h"
#import "AnimationView.h"
@interface ViewController1 ()
@property(nonatomic,strong)UIWebView *webview;
@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    
//   UIWebView * webView = [[UIWebView alloc] initWithFrame:self.view.frame];
//    webView.backgroundColor = [UIColor clearColor];
//    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
//    [self.view addSubview: webView];
//    [webView loadRequest:request];
    

    
    AnimationView *animate = [[AnimationView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-250, self.view.frame.size.width, 250)];
    animate.backgroundColor =[UIColor whiteColor];
    
    [self.view addSubview:animate];
    // Do any additional setup after loading the view.
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

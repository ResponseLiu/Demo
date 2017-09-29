//
//  MovieParseViewController.m
//  YYText
//
//  Created by 1 on 2017/9/28.
//  Copyright © 2017年 com.wh1.guozhentang. All rights reserved.
//

#import "MovieParseViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "FMLPlayLayerView.h"
#import "FMLClipView.h"
#import "MovieFileOutPut.h"
@interface MovieParseViewController ()
@property (nonatomic, strong) FMLPlayLayerView *playerView;
@end

@implementation MovieParseViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"导出" style:0 target:self action:@selector(click)];
    self.title = @"视频裁剪";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.playerView ];

    [self initClicpView];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(get:) name:@"success" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(export:) name:@"export" object:nil];
    

    // Do any additional setup after loading the view.
}
-(void)initClicpView{
    
    FMLClipView *clipFrameView = [[FMLClipView alloc] initWithAsset:self.playerView.player.currentItem.asset];
    clipFrameView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-150, [UIScreen mainScreen].bounds.size.width, 150);
    [self.view insertSubview:clipFrameView aboveSubview:self.playerView];
    
}
-(void)export:(NSNotification *)user{
    
    
    MovieFileOutPut *videoCommand = [[MovieFileOutPut alloc] initWithCompotion:[user.object mutableComposition]];
    
    [videoCommand exportUrl];
    
}
-(void)get:(NSNotification *)user{
    
    
    if(![user.object assetURL]){
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"导出视频失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            
        });
    }else{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"导出视频成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            
        });
    }
}
-(void)click{
    
    MovieFileOutPut *videoCommand = [[MovieFileOutPut alloc] init];
    [videoCommand TrimWith:self.playerView.player.currentItem.asset with:4 with:13];

}
-(FMLPlayLayerView *)playerView{
    
    if (!_playerView) {
        
        _playerView= [FMLPlayLayerView new];
        _playerView.player = [AVPlayer playerWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"Test" ofType:@"mp4"]]];
       _playerView.frame = self.view.frame;
       
    }
    return _playerView;
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (self.playerView.player.rate>0) {
         [self.playerView.player pause];
    }else{
        
          [self.playerView.player play];
    }
}
-(void)dealloc {
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
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

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
@interface MovieParseViewController ()
@property (nonatomic, strong) FMLPlayLayerView *playerView;
@end

@implementation MovieParseViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"视频裁剪";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.playerView ];
    
    CMTime duration = self.playerView.player.currentItem.asset.duration;
    float seconds = CMTimeGetSeconds(duration);
    NSLog(@"duration: %.2f", seconds);
    
    NSLog(@"---%f", seconds);
    FMLClipView *clipFrameView = [[FMLClipView alloc] initWithAsset:self.playerView.player.currentItem.asset];
    clipFrameView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-150, [UIScreen mainScreen].bounds.size.width, 150);
    [self.view insertSubview:clipFrameView aboveSubview:self.playerView];
    // Do any additional setup after loading the view.
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

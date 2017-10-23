//
//  MovieFileOutPut.m
//  YYText
//
//  Created by 1 on 2017/9/29.
//  Copyright © 2017年 com.wh1.guozhentang. All rights reserved.
//

#import "MovieFileOutPut.h"
#import "AVAsset+FMLVideo.h"
@implementation MovieFileOutPut
-(instancetype)initWithCompotion:(AVMutableComposition *)Compostion{
    
    if (self = [super init]) {
        
        _mutableComposition = Compostion;
    }
    return self;
}
-(void)TrimWith:(AVAsset *)asset with:(Float64)start with:(Float64)end{

    AVAssetTrack *audio = nil;
    AVAssetTrack *video = nil;
    
    if ([[asset tracksWithMediaType:AVMediaTypeAudio] count] != 0){
        
        audio = [asset tracksWithMediaType:AVMediaTypeAudio][0];
    }
    if ([[asset tracksWithMediaType:AVMediaTypeVideo] count] != 0){
        
         video = [asset tracksWithMediaType:AVMediaTypeVideo][0];
    }
    _mutableComposition = [AVMutableComposition composition];
    CMTime insertionPoint = kCMTimeZero;
    CMTime startDuration = CMTimeMakeWithSeconds(start, asset.fml_getFPS);
    CMTime duration = CMTimeMakeWithSeconds(end - start, asset.fml_getFPS);
    NSError *error = nil;
    if (audio !=nil) {
        
        AVMutableCompositionTrack *compositionAudioTrack = [_mutableComposition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
        
        [compositionAudioTrack insertTimeRange:CMTimeRangeMake(startDuration, duration) ofTrack:audio atTime:insertionPoint error:&error];
        
        compositionAudioTrack.preferredTransform = audio.preferredTransform;
        
    }
    if (video!=nil) {
        
        AVMutableCompositionTrack *compositionAudioTrack = [_mutableComposition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
        
        [compositionAudioTrack insertTimeRange:CMTimeRangeMake(startDuration, duration) ofTrack:video atTime:insertionPoint error:&error];
        
        compositionAudioTrack.preferredTransform = video.preferredTransform;
    }
     [[NSNotificationCenter defaultCenter] postNotificationName:@"export" object:self];
}
-(void)exportUrl{
    
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, true);
    
    NSString *outputURL = array[0];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    [manager createDirectoryAtPath:outputURL withIntermediateDirectories:YES attributes:nil error:nil];
    outputURL = [outputURL stringByAppendingPathComponent:@"output.mp4"];
    [manager removeItemAtPath:outputURL error:nil];
    
    AVAssetExportSession *export = [[AVAssetExportSession alloc]initWithAsset:[self.mutableComposition copy] presetName:AVAssetExportPresetMediumQuality];
    export.shouldOptimizeForNetworkUse = true;
    export.outputURL = [NSURL fileURLWithPath:outputURL];
    export.outputFileType = AVFileTypeQuickTimeMovie;
    [export exportAsynchronouslyWithCompletionHandler:^{
        
        switch (export.status) {
            case AVAssetExportSessionStatusCompleted:
            {
                  _assetURL = export.outputURL;
                NSLog(@"---%@",outputURL);
                  [[NSNotificationCenter defaultCenter]postNotificationName:@"success" object:self];
            }
                break;
                
            default:
                break;
        }
    }];
}
@end

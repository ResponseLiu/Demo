//
//  DownLoadManager.m
//  YYText
//
//  Created by 1 on 2017/10/14.
//  Copyright © 2017年 com.wh1.guozhentang. All rights reserved.
//

#import "DownLoadManager.h"

@interface DownLoadManager()<NSURLSessionDownloadDelegate>

@property(nonatomic,strong)NSURLSessionDownloadTask *task;

@property (nonatomic, strong) NSURLSession* session;

@property (nonatomic, strong) NSData* resumeData;

@end

@implementation DownLoadManager

+(instancetype)Shared{
    
    static DownLoadManager *mananger = nil;
    
    @synchronized(self) {
        
        if (mananger == nil) {
            
            mananger = [[DownLoadManager alloc]init];
        }
    }
    return mananger;
    
}
-(void)startDownLoad:(NSURL *)url {
    
    if (self.resumeData==nil) {
        
        self.task = [self.session downloadTaskWithURL:url];
        
        [self.task resume];
        
    }else{
        
        self.task = [self.session downloadTaskWithResumeData:self.resumeData];
        
        [self.task resume];
        
        self.resumeData = nil;
        
    }
    
}
-(void)pause{
    
    __weak typeof(self) weakself = self;
    
    [self.task cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
        
        weakself.resumeData = resumeData;
        weakself.task = nil;
        
    }];
}
-(void)restart{
    
   

}
-(NSURLSession *)session {
    
    if (_session == nil) {
        
        NSURLSessionConfiguration * Configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        _session = [NSURLSession sessionWithConfiguration:Configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
        
    }
    
    return _session;
    
}
- (void)URLSession:(nonnull NSURLSession *)session downloadTask:(nonnull NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(nonnull NSURL *)location {
    
    self.finish(location.path);
    
}
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
 totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    
    self.progress((float)totalBytesWritten/totalBytesExpectedToWrite);
}
@end

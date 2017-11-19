//
//  DownLoadManager.m
//  YYText
//
//  Created by 1 on 2017/10/14.
//  Copyright © 2017年 com.wh1.guozhentang. All rights reserved.
//

#import "DownLoadManager.h"

@interface DownLoadManager()<NSURLSessionDownloadDelegate>

{
    
    /// 进度回调缓存池
    NSMutableDictionary *_progressBlockDict;
    /// 完成回调缓存池
    NSMutableDictionary *_completionBlockDict;
    /// 下载任务缓存池
    NSMutableDictionary *_downlaodTaskDict;
    
    /// 下载状态池
    NSMutableDictionary *_downLoadState;
    
    
}
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
- (instancetype)init
{
    if (self = [super init])
    {
        // 实例化进度回调缓存池 / 完成回调缓存池 / 下载任务缓存池
        _progressBlockDict = [[NSMutableDictionary alloc] init];
        _completionBlockDict = [[NSMutableDictionary alloc] init];
        _downlaodTaskDict = [[NSMutableDictionary alloc] init];
    }
    return self;
}
-(BOOL)checkisDownLoad:(NSString *)path{
    
    NSLog(@"--%@",path);
    
    if ([_downlaodTaskDict objectForKey:[NSURL URLWithString:path]] != nil)
    {
        return YES;
    }
    return NO;
}

-(void)startDownLoad:(NSURL *)url with:(NSInteger)identifier withProgress:(void(^)(Float32,int64_t,NSURLSessionDownloadTask *task))block withCompletion:(void(^)(NSString *templePath,NSURLSessionDownloadTask *task))success {

    if (self.resumeData==nil) {
        
        self.task = [self.session downloadTaskWithURL:url];
        [self.task resume];
        [self.task setValue:@(identifier) forKey:@"taskIdentifier"];

    }else{
        
        self.task = [self.session downloadTaskWithResumeData:self.resumeData];

        [self.task resume];

        self.resumeData = nil;

    }
    
    [_progressBlockDict setObject:block   forKey:self.task ];
    [_completionBlockDict setObject:success forKey:self.task ];
    [_downlaodTaskDict setObject:self.task  forKey:url];
    NSLog(@"--%@", [_downlaodTaskDict objectForKey:url]);
}
-(NSURLSession *)session {
    
    if (_session == nil) {
        
        NSURLSessionConfiguration * Configuration = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"download"];
        
        _session = [NSURLSession sessionWithConfiguration:Configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
        
    }
    return _session;
    
}
- (void)URLSession:(nonnull NSURLSession *)session downloadTask:(nonnull NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(nonnull NSURL *)location {
    
    
    void(^completionBlock)(NSString *templePath,NSURLSessionDownloadTask *task) = [_completionBlockDict objectForKey:downloadTask];
     completionBlock(location.path,downloadTask);
}
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
 totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    
    NSLog(@"%lu",(unsigned long)downloadTask.taskIdentifier);
    void (^block)(Float32,int64_t,NSURLSessionDownloadTask *task) = [_progressBlockDict objectForKey:downloadTask];
    block((float)totalBytesWritten/totalBytesExpectedToWrite,(int64_t)bytesWritten,downloadTask);
}
- (void)URLSession:(NSURLSession *)session
              task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error{
    
    
    NSString *URLString = task.currentRequest.URL.absoluteString;
    [_progressBlockDict removeObjectForKey:task];
    [_completionBlockDict removeObjectForKey:task];
    [_downlaodTaskDict removeObjectForKey:[NSURL URLWithString:URLString]];

}
@end

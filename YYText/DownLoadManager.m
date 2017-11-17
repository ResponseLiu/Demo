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
-(void)startDownLoad:(NSURL *)url withProgress:(void(^)(Float32 progress))block withCompletion:(void(^)(NSString *templePath))success {

    if (self.resumeData==nil) {

        self.task = [self.session downloadTaskWithURL:url];

        [self.task resume];

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
        
        NSURLSessionConfiguration * Configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        _session = [NSURLSession sessionWithConfiguration:Configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
        
    }
    return _session;
    
}
- (void)URLSession:(nonnull NSURLSession *)session downloadTask:(nonnull NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(nonnull NSURL *)location {
    
     NSString *URLString = downloadTask.currentRequest.URL.absoluteString;
     void(^completionBlock)(NSString *templePath) = [_completionBlockDict objectForKey:downloadTask];
     completionBlock(location.path);
    
    [_progressBlockDict removeObjectForKey:downloadTask];
    [_completionBlockDict removeObjectForKey:downloadTask];
    [_downlaodTaskDict removeObjectForKey:URLString];
    
}
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
 totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    
    void (^block)(Float32 progress) = [_progressBlockDict objectForKey:downloadTask];
    
    block((float)totalBytesWritten/totalBytesExpectedToWrite);
}
@end

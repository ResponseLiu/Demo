//
//  DownLoadManager.h
//  YYText
//
//  Created by 1 on 2017/10/14.
//  Copyright © 2017年 com.wh1.guozhentang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,DownLoadType){
    DownLoadBegin = 0,
    DownLoading,
    DownLoadEnd
};
@interface DownLoadManager : NSObject

@property(nonatomic,assign)DownLoadType type;

+(instancetype)Shared;

-(void)startDownLoad:(NSURL *)url with:(NSInteger)identifier withProgress:(void(^)(Float32,int64_t,NSURLSessionDownloadTask *task))block withCompletion:(void(^)(NSString * templePath,NSURLSessionDownloadTask *task))success;

-(BOOL)checkisDownLoad:(NSString *)path;

@end

//
//  DownLoadManager.h
//  YYText
//
//  Created by 1 on 2017/10/14.
//  Copyright © 2017年 com.wh1.guozhentang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DownLoadManager : NSObject



+(instancetype)Shared;

-(void)startDownLoad:(NSURL *)url withProgress:(void(^)(Float32 progress))block withCompletion:(void(^)(NSString * templePath))success;

-(BOOL)checkisDownLoad:(NSString *)path;

@end

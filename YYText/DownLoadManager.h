//
//  DownLoadManager.h
//  YYText
//
//  Created by 1 on 2017/10/14.
//  Copyright © 2017年 com.wh1.guozhentang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef  void(^ProgressBlock)(float progress);
typedef  void(^Finished)(NSString *templePath);
@interface DownLoadManager : NSObject

@property(nonatomic,copy)ProgressBlock progress;

@property(nonatomic,copy)Finished finish;

+(instancetype)Shared;

-(void)startDownLoad:(NSURL *)url;

-(void)pause;

-(void)restart;

@end

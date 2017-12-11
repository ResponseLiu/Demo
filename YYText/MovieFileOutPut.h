//
//  MovieFileOutPut.h
//  YYText
//
//  Created by 1 on 2017/9/29.
//  Copyright © 2017年 com.wh1.guozhentang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@interface MovieFileOutPut : NSObject
@property(nonatomic,strong,readonly)AVMutableComposition *mutableComposition;
@property(nonatomic,strong,readonly)NSURL *assetURL;

-(instancetype)initWithCompotion:(AVMutableComposition *)Compostion;

-(void)TrimWith:(AVAsset *)asset with:(Float64)start with:(Float64)end;

-(void)exportUrl;

@end

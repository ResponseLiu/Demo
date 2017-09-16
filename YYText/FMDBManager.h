//
//  FMDBManager.h
//  YYText
//
//  Created by 1 on 2017/9/16.
//  Copyright © 2017年 com.wh1.guozhentang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMDBManager : NSObject
+(instancetype)SharedManager;

/**
 创建DB文件

 @param directory DB文件目录
 @param dbFile DN文件名称
 */
-(void)createFile:(NSString *)directory with:(NSString *)dbFile;


-(void)threadFMDB:(NSInteger)key;
@end

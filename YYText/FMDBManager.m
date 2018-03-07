//
//  FMDBManager.m
//  YYText
//
//  Created by 1 on 2017/9/16.
//  Copyright © 2017年 com.wh1.guozhentang. All rights reserved.
//

#import "FMDBManager.h"
#import <FMDatabase.h>
#import <FMDatabaseQueue.h>

static FMDatabase *_db;
static FMDatabaseQueue *_QUEUE;

@implementation FMDBManager

+(instancetype)SharedManager {

    static FMDBManager *manager = nil;
    
    
    @synchronized (self) {
        
        if (manager == nil) {
            
            manager = [[FMDBManager alloc]init];
        }
        
    }
    return manager;
}

-(void)createFile:(NSString *)directory with:(NSString *)dbFile{

    if (directory.length==0||dbFile.length==0) {
        
        return;
    }
    NSFileManager *manager = [NSFileManager defaultManager];
    
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@",directory]];
    NSLog(@"%@",NSHomeDirectory());
    if (![manager fileExistsAtPath:path]) {
        
        [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        
    }
    NSString *dbPath = [path stringByAppendingString:dbFile];
    
    _db = [FMDatabase databaseWithPath:dbPath];
    _QUEUE = [FMDatabaseQueue databaseQueueWithPath:dbPath];
    if ([_db open]) {
        BOOL result=[_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_student (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, age text NOT NULL);"];
        if (!result) {
            NSLog(@"error when creating db table ");
        }else
        {
            NSLog(@"success when creating db table");
        }
    }
    [_db close];
}
-(void)threadFMDB:(NSInteger)key{

    //多线程的同步操作
//    dispatch_queue_t queue = dispatch_queue_create(0, DISPATCH_TARGET_QUEUE_DEFAULT);
    
    //多线程的异步操作
    dispatch_queue_t queue = dispatch_queue_create(0, DISPATCH_QUEUE_CONCURRENT);
    
//    dispatch_sync(queue, ^{
//        
//        [_QUEUE inDatabase:^(FMDatabase * _Nonnull db) {
//            
//            NSString *sql = [NSString stringWithFormat:@"update t_student set age = '1' where id = '%ld'",(long)key];
//            [db executeUpdate:sql];
//            
//        }];
//        
//        [NSThread sleepForTimeInterval:10];
//        
//    });
//    dispatch_sync(queue, ^{
//        
//        [_QUEUE inDatabase:^(FMDatabase * _Nonnull db) {
//            
//            [db executeUpdate:@"INSERT INTO t_student (name, age) VALUES (?, ?);", @"买卖皮", @"10"];
//            NSLog(@"---数据插入完毕");
//        }];
//        
//    });
    
    dispatch_async(queue, ^{
        
        [_QUEUE inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
            NSString *sql = [NSString stringWithFormat:@"update t_student set age = '1' where id = '%ld'",(long)key];
            [db executeUpdate:sql];

        }];
        
        [NSThread sleepForTimeInterval:10];
        
    });
    dispatch_async(queue, ^{
        
        [_QUEUE  inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
            
            [db executeUpdate:@"INSERT INTO t_student (name, age) VALUES (?, ?);", @"买卖皮", @"10"];
            NSLog(@"---数据插入完毕");
        }];
        
    });
}
@end

//
//  AppDelegate.h
//  YYText
//
//  Created by 1 on 2017/8/9.
//  Copyright © 2017年 com.wh1.guozhentang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownLoadManager.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSMutableDictionary *completionHandlerDictionary;
@property (strong, nonatomic) UILocalNotification *localNotification;

-(void)startDownloadWith:(NSInteger)identifer with:(NSString *)url;

@end


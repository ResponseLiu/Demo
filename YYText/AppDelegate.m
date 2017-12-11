//
//  AppDelegate.m
//  YYText
//
//  Created by 1 on 2017/8/9.
//  Copyright © 2017年 com.wh1.guozhentang. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "MainNavViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
     self.completionHandlerDictionary = @{}.mutableCopy;
    self.window = [[UIWindow alloc]initWithFrame:self.window.bounds];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    MainViewController *main = [[MainViewController alloc]init];
    self.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:main];
    
    [self.window makeKeyAndVisible];
    
    [self registNotification:launchOptions with:application];
    // Override point for customization after application launch.
    return YES;
}
-(void)registNotification:(NSDictionary *)launchOptions with:(UIApplication *)application{
    
    
    // ios8后，需要添加这个注册，才能得到授权
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationType type =  UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type
                                                                                 categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        // 通知重复提示的单位，可以是天、周、月
        self.localNotification.repeatInterval = 0;
    } else {
        // 通知重复提示的单位，可以是天、周、月
        self.localNotification.repeatInterval = 0;
    }
    
    UILocalNotification *localNotification = [launchOptions valueForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if (localNotification) {
        [self application:application didReceiveLocalNotification:localNotification];
    }
    
}
#pragma mark - Local Notification
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"下载通知"
                                                    message:notification.alertBody
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
    
    // 图标上的数字减1
    application.applicationIconBadgeNumber -= 1;
}
- (void)initLocalNotification {
    
    self.localNotification = [[UILocalNotification alloc] init];
    self.localNotification.fireDate = [[NSDate date] dateByAddingTimeInterval:5];
    self.localNotification.alertAction = nil;
    self.localNotification.soundName = UILocalNotificationDefaultSoundName;
    self.localNotification.alertBody = @"下载完成了！";
    self.localNotification.applicationIconBadgeNumber = 1;
    self.localNotification.repeatInterval = 0;
     [[UIApplication sharedApplication] scheduleLocalNotification:self.localNotification];
    
}
-(void)startDownloadWith:(NSInteger)identifer with:(NSString *)url{
    
    
    if ([[DownLoadManager Shared]checkisDownLoad:url]==YES) {
        
        NSLog(@"--正在下载");
        
    } else{
        
        [[DownLoadManager Shared] startDownLoad:[NSURL URLWithString:url] with:identifer   withProgress:^(Float32 progress,int64_t speed,NSURLSessionDownloadTask *task) {
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                
                
                [[NSNotificationCenter defaultCenter]postNotificationName:@"progress" object:@{@"identifier":@(task.taskIdentifier),@"progress":@(progress)}];
                
            }];
        } withCompletion:^(NSString *templePath,NSURLSessionDownloadTask *task) {
            
            NSFileManager *defultManager = [NSFileManager defaultManager];

            NSString *destationPath = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%lu",(unsigned long)task.taskIdentifier]];
            if (![defultManager fileExistsAtPath:destationPath]) {
                
                 [defultManager moveItemAtPath:templePath toPath:destationPath error:nil];
            }
            [[NSNotificationCenter defaultCenter]postNotificationName:@"complete" object:[NSString stringWithFormat:@"%lu",(unsigned long)task.taskIdentifier]];
            [self initLocalNotification];
        }];
    }
    
}
- (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)())completionHandler {
    
    
     [self.completionHandlerDictionary setObject:completionHandler forKey:identifier];
    
}
- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session {
    
    void(^completionHandler)()= [self.completionHandlerDictionary objectForKey:[NSString stringWithFormat:@"%@",session.configuration.identifier]];
    if (completionHandler) {
        
        completionHandler();
    }
     [self.completionHandlerDictionary removeObjectForKey: session.configuration.identifier];
   
}
- (void)applicationWillResignActive:(UIApplication *)application {
    
        application.applicationIconBadgeNumber -= 1;
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end

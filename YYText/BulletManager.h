//
//  BulletManager.h
//  YYText
//
//  Created by 1 on 2017/9/5.
//  Copyright © 2017年 com.wh1.guozhentang. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
@class BulletView;
@interface BulletManager : NSObject
@property (nonatomic, copy) void(^generateBulletBlock)(BulletView *view);
-(void)start;
-(void)stop;
@end

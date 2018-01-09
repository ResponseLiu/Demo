//
//  TimerModel.h
//  倒计时
//
//  Created by 1 on 2018/1/8.
//  Copyright © 2018年 com.wh1.guozhentang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimerModel : NSObject

@property(nonatomic,strong)NSString *name;

@property(nonatomic,assign)int second;

-(void)update;

-(NSString *)currentTime;

+(instancetype)getData:(NSString *)name with:(int)secondTime;

@end

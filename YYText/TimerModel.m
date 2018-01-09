//
//  TimerModel.m
//  倒计时
//
//  Created by 1 on 2018/1/8.
//  Copyright © 2018年 com.wh1.guozhentang. All rights reserved.
//

#import "TimerModel.h"

@implementation TimerModel


+(instancetype)getData:(NSString *)name with:(int)time {
    
    TimerModel *model = [[TimerModel alloc]init];
    
    model.name = name;
    
    model.second = time;
    
    return model;
    
    
}

-(void)update {
    
    self.second-=1;
    
}

-(NSString *)currentTime{
    

    
    if (self.second<=0) {
        
        return @"00:00:00";
        
    }
    
    
    return [NSString stringWithFormat:@"%02d:%02d:%02d",self.second/3600,self.second%3600/60,self.second%60];
}
@end

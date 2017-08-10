//
//  YYTextManager.h
//  YYText
//
//  Created by 1 on 2017/8/9.
//  Copyright © 2017年 com.wh1.guozhentang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYText.h>
#import <YYImage.h>
@interface YYTextManager : NSObject
+(instancetype)SharedManager;
-(NSMutableAttributedString *)regionAt_manager;

-(NSMutableAttributedString *)emotionAct;
-(YYTextSimpleEmoticonParser *)emotionActPic;
@end

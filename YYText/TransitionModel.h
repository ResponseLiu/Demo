//
//  TransitionModel.h
//  YYText
//
//  Created by 1 on 2017/9/20.
//  Copyright © 2017年 com.wh1.guozhentang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger,XPresentTransitionType) {

   XPresentWithPresent,
   XPressentWithDismiss
    

};

@interface TransitionModel : NSObject<UIViewControllerAnimatedTransitioning>


@property(nonatomic,assign)XPresentTransitionType type;


+(instancetype)PushWithTransition:(XPresentTransitionType)type;
-(instancetype)initWithTransition:(XPresentTransitionType)type;
@end

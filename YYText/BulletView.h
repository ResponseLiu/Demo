//
//  BulletView.h
//  YYText
//
//  Created by 1 on 2017/9/5.
//  Copyright © 2017年 com.wh1.guozhentang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BulletView : UIView

@property(nonatomic,strong)UILabel *lbComment;
@property(nonatomic,copy)void(^moveStatusBlock)();
@property(nonatomic,assign)int trajectory;
-(instancetype)initWithComment:(NSString *)comment;

-(void)startAnimation;

-(void)stopAnimation;
@end

//
//  WeChatHeader.m
//  YYText
//
//  Created by 1 on 2017/9/13.
//  Copyright © 2017年 com.wh1.guozhentang. All rights reserved.
//

#import "WeChatHeader.h"

@interface WeChatHeader ()

@property(nonatomic,strong)UIImageView *BG_IMAG;
@property(nonatomic,strong)UIImageView *avaerator;
@property(nonatomic,strong)UILabel *name;
@end

@implementation WeChatHeader
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame{

    if (self=[super initWithFrame:frame]) {
        
        
           [self addSubview:self.BG_IMAG];
           [self addSubview:self.avaerator];
           [self addSubview:self.name];
        
    }
    return self;

}
-(UIImageView *)BG_IMAG{

    if (!_BG_IMAG) {
        
        _BG_IMAG = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 280)];
        _BG_IMAG.image = [UIImage imageNamed:@"WechatIMG77.jpeg"];
        
    }

    return _BG_IMAG;
}
-(UIImageView *)avaerator{
    
    if (!_avaerator) {
        
        _avaerator = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-95, 225, 80, 80)];
        _avaerator.image = [UIImage imageNamed:@"WechatIMG80.jpeg"];
        _avaerator.layer.borderWidth = 2;
        _avaerator.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    return _avaerator;
}
-(UILabel *)name{

    if (!_name) {
        
        _name = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.avaerator.frame)-90, CGRectGetMinY(self.avaerator.frame)+10, 70, 30)];
        _name.text = @"Summer";
        _name.font = [UIFont systemFontOfSize:18];
        _name.textColor = [UIColor whiteColor];
        
    }

    return _name;
}
@end

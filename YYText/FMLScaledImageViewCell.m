//
//  FMLScaledImageViewCell.m
//  VideoClip
//
//  Created by samo on 16/9/2.
//  Copyright © 2016年 Collion. All rights reserved.
//

#import "FMLScaledImageViewCell.h"

@interface FMLScaledImageViewCell ()

@end

@implementation FMLScaledImageViewCell
-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {

        [self addSubview:self.scaledIamgeView];
    }
    return self;
}
-(UIImageView *)scaledIamgeView{

    if (!_scaledIamgeView) {
        
        _scaledIamgeView = [[UIImageView alloc]initWithFrame:self.frame];

    }
    return _scaledIamgeView;
}
- (void)setImageData:(UIImage *)imageData
{
    _imageData = imageData;
    
    self.scaledIamgeView.image = _imageData;
    
}

@end

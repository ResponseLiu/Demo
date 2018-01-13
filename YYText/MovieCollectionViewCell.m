//
//  MovieCollectionViewCell.m
//  YYText
//
//  Created by 1 on 2018/1/13.
//  Copyright © 2018年 com.wh1.guozhentang. All rights reserved.
//

#import "MovieCollectionViewCell.h"
@implementation MovieCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.bgImage];
        
    }
    
    return self;
    
}

-(UIImageView *)bgImage{
    
    if (!_bgImage) {
        
        _bgImage = [[UIImageView alloc]initWithFrame:self.bounds];
    }
    
    return _bgImage;
}
@end

//
//  CollectionViewCell.m
//  YYText
//
//  Created by 1 on 2017/11/17.
//  Copyright © 2017年 com.wh1.guozhentang. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self =[super initWithFrame:frame]) {
        
        [self.contentView addSubview:self.contentImage];
    }
    
    return self;
    
}
-(UIImageView *)contentImage{
    
    if (!_contentImage) {
        
        _contentImage =[[UIImageView alloc]initWithFrame:self.bounds];
    }
    
    return _contentImage;
}
@end

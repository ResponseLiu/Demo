//
//  DownLoadCell.m
//  YYText
//
//  Created by 1 on 2017/11/11.
//  Copyright © 2017年 com.wh1.guozhentang. All rights reserved.
//

#import "DownLoadCell.h"

@implementation DownLoadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self addSubview:self.HeaderImage];
        [self addSubview:self.progress];
        [self addSubview:self.starDownLoad];
        
    }
    
    return self;
}
-(UIImageView *)HeaderImage{
    
    if (!_HeaderImage) {
        
        _HeaderImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
        _HeaderImage.backgroundColor = [UIColor redColor];
    }
    
    return _HeaderImage;
}
-(UIProgressView *)progress{
    
    if (!_progress) {
        
        _progress =[[UIProgressView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.HeaderImage.frame)+20, 32, 200, 50)];
        _progress.backgroundColor = [UIColor redColor];
        _progress.tintColor = [UIColor blackColor];
        
    }
    return _progress;
}
-(UIButton *)starDownLoad{
    
    if (!_starDownLoad) {
        
        _starDownLoad = [UIButton buttonWithType:0];
        _starDownLoad.frame = CGRectMake(self.frame.size.width-40, 10, 100, 50);
        [_starDownLoad setTitle:@"开始下载" forState:0];
        [_starDownLoad setTitleColor:[UIColor blackColor] forState:0];
        [_starDownLoad addTarget:self action:@selector(download:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _starDownLoad;
}
-(void)download:(UIButton *)button{
    
    [self.delegate download:self];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

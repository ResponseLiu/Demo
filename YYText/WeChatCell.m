//
//  WeChatCell.m
//  YYText
//
//  Created by 1 on 2017/9/13.
//  Copyright © 2017年 com.wh1.guozhentang. All rights reserved.
//

#import "WeChatCell.h"
#import "MoreImageView.h"
@interface WeChatCell()
@property(nonatomic,strong)UIImageView *avaerator;
@property(nonatomic,strong)UILabel *name;
@property(nonatomic,strong)UILabel *detail;
@end

@implementation WeChatCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self addSubview:self.avaerator];
        [self addSubview:self.name];
        [self addSubview:self.detail];
    }

    return self;

}
-(UIImageView *)avaerator{
    
    if (!_avaerator) {
        
        _avaerator = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
        _avaerator.image = [UIImage imageNamed:@"WechatIMG80.jpeg"];
        _avaerator.layer.borderWidth = 2;
        _avaerator.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    return _avaerator;
}
-(UILabel *)name{
    
    if (!_name) {
        
        _name = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.avaerator.frame)+10, CGRectGetMinY(self.avaerator.frame)+2, 70, 15)];
        _name.text = @"Summer";
      
        _name.font = [UIFont systemFontOfSize:16];
        _name.textColor = [UIColor blueColor];
        
    }
    
    return _name;
}
-(UILabel *)detail{
    
    if (!_detail) {
        
        _detail = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.name.frame), CGRectGetMaxY(self.name.frame)+4, [UIScreen mainScreen].bounds.size.width-CGRectGetMaxX(self.avaerator.frame)-30, 0)];
       
        _detail.font = [UIFont systemFontOfSize:15];
        _detail.textColor = [UIColor blackColor];
       
        
    }
    
    return _detail;
}
-(void)setDic:(NSDictionary *)dic{

    _dic = dic;
    
    self.detail.text = [dic objectForKey:@"detail"];
    self.detail.numberOfLines = 0;
    [self.detail sizeToFit];


}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

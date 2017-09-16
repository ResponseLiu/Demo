//
//  WeChatCell.m
//  YYText
//
//  Created by 1 on 2017/9/13.
//  Copyright © 2017年 com.wh1.guozhentang. All rights reserved.
//

#import "WeChatCell.h"
#import "MoreImageView.h"
#import <YYLabel.h>
#import <YYImage.h>
@interface WeChatCell()
@property(nonatomic,strong)UIImageView *avaerator;
@property(nonatomic,strong)UILabel *name;
@property(nonatomic,strong)YYLabel *detail;
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
-(YYLabel *)detail{
    
    if (!_detail) {
        
        _detail = [[YYLabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.name.frame), CGRectGetMaxY(self.name.frame)+4, [UIScreen mainScreen].bounds.size.width-CGRectGetMaxX(self.avaerator.frame)-30, 0)];
        _detail.textParser = [self emotionActPic];
        _detail.font = [UIFont systemFontOfSize:15];
        _detail.textColor = [UIColor colorWithRed:150/255 green:150/255 blue:150/255 alpha:1.0];
    }
    
    return _detail;
}
-(void)setDic:(NSDictionary *)dic{

    _dic = dic;
    self.detail.attributedText = [self emotionAct:[dic objectForKey:@"detail"]];
    self.detail.numberOfLines = 0;
}
-(void)layoutSubviews{

    [super layoutSubviews];
    
    self.detail.frame = CGRectMake(CGRectGetMinX(self.name.frame), CGRectGetMaxY(self.name.frame)+4, [UIScreen mainScreen].bounds.size.width-CGRectGetMaxX(self.avaerator.frame)-30, [self contentHeight:[self emotionAct:[self.dic objectForKey:@"detail"]]]);

}
-(NSMutableAttributedString *)emotionAct:(NSString *)str{
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:str];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5; // 调整行间距
    NSRange range = NSMakeRange(0, [str length]);
    [text addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    [text setYy_color:[UIColor blackColor]];
    [text setYy_font:[UIFont systemFontOfSize:15]];
    return text;
}
-(YYTextSimpleEmoticonParser *)emotionActPic{
    
    NSMutableDictionary *mapper = [NSMutableDictionary new];
    mapper[@":smile:"] = [self imageWithName:@"001@2x"];
    mapper[@":cry:"] = [self imageWithName:@"003@2x"];
    mapper[@":hehe:"] = [self imageWithName:@"004@2x"];
    
    YYTextSimpleEmoticonParser *parser = [YYTextSimpleEmoticonParser new];
    parser.emoticonMapper = mapper;
    return parser;
}
-(CGFloat)contentHeight:(NSMutableAttributedString *)attribute{

    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:CGSizeMake(self.detail.frame.size.width, MAXFLOAT) text:attribute];
    
    return  layout.textBoundingSize.height;
}
- (UIImage *)imageWithName:(NSString *)name {
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"EmoticonQQ" ofType:@"bundle"]];
    NSString *path = [bundle pathForResource:name ofType:@"gif"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    YYImage *image = [YYImage imageWithData:data scale:2];
    return image;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  YYTextManager.m
//  YYText
//
//  Created by 1 on 2017/8/9.
//  Copyright © 2017年 com.wh1.guozhentang. All rights reserved.
//

#import "YYTextManager.h"

@implementation YYTextManager
+(instancetype)SharedManager
{
    
    static YYTextManager *manager=nil;
    @synchronized (self)
    {
        if (manager == nil)
        {
            manager = [[self alloc] init];
        }
    }
    return  manager;
}
-(NSMutableAttributedString *)regionAt_manager{

    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:@"测试测试测试@新浪微博 @腾讯微博 新闻话题#九寨沟地震#网络连接http://www.baidu.com"];
    [text yy_setFont:[UIFont systemFontOfSize:18] range:text.yy_rangeOfAll];
    
    NSArray *resultArra = [[self regexAt] matchesInString:text.string options:kNilOptions range:text.yy_rangeOfAll];
    YYTextBorder *border = [[YYTextBorder alloc]init];
    border.insets = UIEdgeInsetsMake(-2, 0, -2, 0);
    border.cornerRadius = 3;
    border.fillColor = [UIColor clearColor];
    for (NSTextCheckingResult *at in resultArra) {
        
        if (at.range.length<=1) {
            
            continue;
            
        }
        if ([text yy_attribute:YYTextHighlightAttributeName atIndex:at.range.location] == nil) {
            
            [text yy_setColor:[UIColor redColor] range:at.range];
            YYTextHighlight *highLight = [YYTextHighlight new];
            highLight.userInfo = @{@"type":@1};
            [highLight setBorder:border];
            [text yy_setTextHighlight:highLight range:at.range];
            
        }
    }
    
    NSArray *resultTopic = [[self regexTopic] matchesInString:text.string options:kNilOptions range:text.yy_rangeOfAll];
    
    for (NSTextCheckingResult *at in resultTopic)
    {
        if (at.range.location == NSNotFound && at.range.length <= 1)
        {
            continue;
        }
        
        if ([text yy_attribute:YYTextHighlightAttributeName atIndex:at.range.location] == nil)
        {
            [text yy_setColor:[UIColor blueColor] range:at.range];
           
            YYTextHighlight *highlight = [YYTextHighlight new];
            highlight.userInfo = @{@"type":@2};
            [highlight setBackgroundBorder:border];
            
           
            [text yy_setTextHighlight:highlight range:at.range];
        }
    }
    NSArray *resultLink = [[self regexUrl] matchesInString:text.string options:kNilOptions range:text.yy_rangeOfAll];
    
    for (NSTextCheckingResult *at in resultLink)
    {
        if (at.range.location == NSNotFound && at.range.length <= 1)
        {
            continue;
        }
        
        if ([text yy_attribute:YYTextHighlightAttributeName atIndex:at.range.location] == nil)
        {
            [text yy_setColor:[UIColor blueColor] range:at.range];
           
            YYTextHighlight *highlight = [YYTextHighlight new];
            [highlight setBackgroundBorder:border];
             highlight.userInfo = @{@"type":@3};
            [text yy_setTextHighlight:highlight range:at.range];
        }
    }

    return text;

}
-(NSMutableAttributedString *)emotionAct{

    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:@"星期天很高兴:smile::cry::hehe:有一个星期天:smile::cry::hehe:"];
    [text setYy_color:[UIColor blackColor]];
    [text setYy_font:[UIFont systemFontOfSize:30]];
    
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
- (UIImage *)imageWithName:(NSString *)name {
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"EmoticonQQ" ofType:@"bundle"]];
    NSString *path = [bundle pathForResource:name ofType:@"gif"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    YYImage *image = [YYImage imageWithData:data scale:2];
    return image;
}
-(NSRegularExpression *)regexAt
{
    static NSRegularExpression *regex;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        regex = [NSRegularExpression regularExpressionWithPattern:@"@[-_a-zA-Z0-9\u4E00-\u9FA5]+" options:kNilOptions error:NULL];
    });
    return regex;
}
- (NSRegularExpression *)regexTopic
{
    static NSRegularExpression *regex;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        regex = [NSRegularExpression regularExpressionWithPattern:@"#[^@#]+?#" options:kNilOptions error:NULL];
    });
    return regex;
}
- (NSRegularExpression *)regexUrl
{
    static NSRegularExpression *regex;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        regex = [NSRegularExpression regularExpressionWithPattern:@"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)" options:kNilOptions error:NULL];
    });
    return regex;
}
- (NSRegularExpression *)regexPhone
{
    static NSRegularExpression *regex;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        regex = [NSRegularExpression regularExpressionWithPattern:@"^[1]([3][0-9]{1}|59|58|77|70|88|89|86|53|80|85|47|50|51|52|57|59|82|87|55|81|83|84|54|56|45)[0-9]{8}$" options:kNilOptions error:NULL];
    });
    return regex;
}

@end

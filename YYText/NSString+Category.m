//
//  NSString+Category.m
//  YYText
//
//  Created by 1 on 2017/9/6.
//  Copyright © 2017年 com.wh1.guozhentang. All rights reserved.
//

#import "NSString+Category.h"
#import <objc/runtime.h>


static char *str = "UNDERFEKDSLFJDSKFJ";

@implementation NSString (Category)
@dynamic name;



-(NSString *)name{


    return objc_getAssociatedObject(self, str);
    
}
-(void)setName:(NSString *)name{

    
    
    objc_setAssociatedObject(self, str, name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);


}


@end

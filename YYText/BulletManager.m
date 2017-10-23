//
//  BulletManager.m
//  YYText
//
//  Created by 1 on 2017/9/5.
//  Copyright © 2017年 com.wh1.guozhentang. All rights reserved.
//

#import "BulletManager.h"
#import "BulletView.h"
@interface BulletManager()
@property(nonatomic,strong)NSMutableArray *datasource;
@property(nonatomic,strong)NSMutableArray *bulletComments;
@property(nonatomic,strong)NSMutableArray *bulletViews;
@end

@implementation BulletManager

-(NSMutableArray *)datasource{

    if (!_datasource) {
        
        _datasource=[NSMutableArray arrayWithArray:@[@"弹幕11111",@"弹幕222224444444444",@"弹幕222224444444444"]];
    }
    return _datasource;
}
-(NSMutableArray *)bulletViews{
    
    if (!_bulletViews) {
        
        _bulletViews=[NSMutableArray array];
    }
    return _bulletViews;
}
-(NSMutableArray *)bulletComments{
    
    if (!_bulletComments) {
        
        _bulletComments=[NSMutableArray array];
    }
    return _bulletComments;
}
-(void)start{

    [self.bulletComments removeAllObjects];
    [self.bulletComments addObjectsFromArray:self.datasource];
    [self initBulletComment];

}
-(void)initBulletComment{

    NSMutableArray *trajectorys=[NSMutableArray arrayWithArray:@[@0,@1,@2]];

    for (int i=0;i<3; i++) {
        
        if (self.bulletComments.count>0) {
            NSInteger index=arc4random()%trajectorys.count;
            
            int trajectory=[[trajectorys objectAtIndex:index]intValue];
            NSLog(@"---%ld",(long)index);
            [trajectorys removeObjectAtIndex:index];
            
            NSString *comment = [self.bulletComments firstObject];
            
            [self.bulletComments removeObjectAtIndex:0];;
            [self createBulletView:comment tracory:trajectory];
            NSLog(@"---%lu",(unsigned long)trajectorys.count);
        }
    }
}
-(void)createBulletView:(NSString *)comment tracory:(int)trajectorys{

    BulletView *view = [[BulletView alloc]initWithComment:comment];
    
    view.trajectory=trajectorys;
    [self.bulletViews addObject:view];
    
    __weak typeof(view) weakself = view;
    __weak typeof(self) myself = self;

    view.moveStatusBlock = ^{
      
        [weakself stopAnimation];
        [myself.bulletViews removeObject:weakself];
        
    };
    if (self.generateBulletBlock) {
        
        self.generateBulletBlock(view);
    }
}
@end

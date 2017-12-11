//
//  XLFlayout.m
//  YYText
//
//  Created by 1 on 2017/11/17.
//  Copyright © 2017年 com.wh1.guozhentang. All rights reserved.
//

#import "XLFlayout.h"

@implementation XLFlayout

-(void)prepareLayout {
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20);
    self.minimumLineSpacing = 40;
    self.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width-40, 150);
}
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    
    return YES;
    
}
//cell缩放的设置
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    //取出父类算出的布局属性
    //不能直接修改需要copy
    NSArray * original = [super layoutAttributesForElementsInRect:rect];
    NSArray * attsArray = [[NSArray alloc] initWithArray:original copyItems:YES];
    //    NSArray *attsArray = [super layoutAttributesForElementsInRect:rect];
    
    //collectionView中心点的值
    //屏幕中心点对应于collectionView中content位置
    CGFloat centerX = self.collectionView.frame.size.width / 2 + self.collectionView.contentOffset.x;
    //cell中的item一个个取出来进行更改
    for (UICollectionViewLayoutAttributes *atts in attsArray) {
        // cell的中心点x 和 屏幕中心点 的距离
        CGFloat space = ABS(atts.center.x - centerX);
        CGFloat scale = 1 - (space/self.collectionView.frame.size.width/2);
        atts.transform = CGAffineTransformMakeScale(scale, scale);
    }
    return attsArray;
}
@end

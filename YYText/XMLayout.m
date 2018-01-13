//
//  XMLayout.m
//  YYText
//
//  Created by 1 on 2018/1/12.
//  Copyright © 2018年 com.wh1.guozhentang. All rights reserved.
//

#import "XMLayout.h"

@implementation XMLayout

-(instancetype)init {
    
    if (self =[super init]) {
        
        self.itemSpace = 10;
        
        self.columnSpace = 10;
        
        self.Inset = UIEdgeInsetsZero;
        
        self.column = 2;
    
    }
    
    return self;
    
}

-(void)prepareLayout {
    
    self.columnHeight  = [NSMutableArray array];
    
    for (int i= 0; i<self.column; i++) {
        
        self.columnHeight[i] = @(0);
        
    }
    NSLog(@"%@",self.columnHeight);
    self.attribute = [NSMutableArray array];
    
    NSInteger sections  =[self.collectionView numberOfSections];
    
    for (int i= 0; i<sections;i++) {
        
        NSInteger items = [self.collectionView numberOfItemsInSection:i];
        
        for (int j=0; j<items; j++) {
            
            
            UICollectionViewLayoutAttributes *cell_att = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:j inSection:i]];
            
            [self.attribute addObject:cell_att];
        }
        
    }
    
}
//-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
//
//
//    return YES;
//
//}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {


    return self.attribute;

}
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *att_cell = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    
     NSInteger minIndex = [self columnOfLessHeight];
    
     CGFloat minFloat = [self.columnHeight[minIndex] floatValue];
  
    
    CGFloat y = minFloat == 0 ? self. Inset.top:minFloat+self.columnSpace;
    
    CGFloat width = (self.collectionView.frame.size.width - (self.Inset.left+self.Inset.right) - self.itemSpace *(self.column - 1))/ self.column;
    
    CGFloat x = self.Inset.left + (width + _itemSpace) *minIndex;
    
    CGFloat height = [self.delegate collectionViewitemheight:indexPath with:self];
    
    att_cell.frame = CGRectMake(x, y, width, height);
    
    self.columnHeight[minIndex] = @(y+height);
    
    return att_cell;
    
}
- (NSInteger)columnOfLessHeight
{
    if(self.columnHeight.count == 0 || self.columnHeight.count == 1){
        return 0;
    }
    
    __block NSInteger leastIndex = 0;
    [self.columnHeight enumerateObjectsUsingBlock:^(NSNumber *number, NSUInteger idx, BOOL *stop) {
        
        if([number floatValue] < [self.columnHeight[leastIndex] floatValue]){
            leastIndex = idx;
        }
    }];
    
    return leastIndex;
}
- (CGSize)collectionViewContentSize
{

   
    NSInteger mostColumn  = [self columnOfMostHeight] ;

    //所有列当中最大的高度
    CGFloat mostHeight = [self.columnHeight[mostColumn] floatValue];
    return CGSizeMake(self.collectionView.bounds.size.width, mostHeight+_Inset.top+_Inset.bottom);
}

- (NSInteger)columnOfMostHeight
{
    if(self.columnHeight.count == 0 || self.columnHeight.count == 1){
        return 0;
    }
    
    __block NSInteger mostIndex = 0;
    [self.columnHeight enumerateObjectsUsingBlock:^(NSNumber *number, NSUInteger idx, BOOL *stop) {
        
        if([number floatValue] > [self.columnHeight[mostIndex] floatValue]){
            mostIndex = idx;
        }
    }];
    
    return mostIndex;
}

@end

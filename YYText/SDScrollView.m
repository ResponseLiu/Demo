//
//  SDScrollView.m
//  YYText
//
//  Created by 1 on 2017/11/17.
//  Copyright © 2017年 com.wh1.guozhentang. All rights reserved.
//

#import "SDScrollView.h"

@implementation SDScrollView

-(instancetype)initWithFrame:(CGRect)frame {
    
    if (self =[super initWithFrame:frame]) {
        
        [self addSubview:self.collectionView];
        [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
    }
    return self;
}
-(UICollectionView *)collectionView {
    
    if (!_collectionView) {
        
        XLFlayout *layout = [[XLFlayout alloc]init];
        
        _collectionView =[[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.pagingEnabled = YES;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        
    }
    return _collectionView;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    return _dataArra.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.contentImage.image = [UIImage imageNamed:_dataArra[indexPath.row]];
    
    return cell;
    
}
-(void)setDataArra:(NSMutableArray *)dataArra{
    
    _dataArra = dataArra;
    
    [self.collectionView reloadData];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

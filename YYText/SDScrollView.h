//
//  SDScrollView.h
//  YYText
//
//  Created by 1 on 2017/11/17.
//  Copyright © 2017年 com.wh1.guozhentang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLFlayout.h"
#import "CollectionViewCell.h"
@interface SDScrollView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)NSArray *dataArra;


@end

//
//  XMLayout.h
//  YYText
//
//  Created by 1 on 2018/1/12.
//  Copyright © 2018年 com.wh1.guozhentang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LayoutDelegate;

@interface XMLayout : UICollectionViewLayout

@property(nonatomic,weak)id <LayoutDelegate> delegate;

@property(nonatomic,assign)NSInteger column;  //列数

@property(nonatomic,assign)CGFloat itemSpace;  //行间距

@property(nonatomic,assign)CGFloat columnSpace;  //列间距

@property(nonatomic,assign)UIEdgeInsets Inset;   //上下左右间距

@property(nonatomic,strong)NSMutableArray *columnHeight; //保存高度

@property(nonatomic,strong)NSMutableArray *attribute;  //保存每个cell

@end

@protocol LayoutDelegate

@required
//设置每行的高度
-(CGFloat)collectionViewitemheight:(NSIndexPath *)indexpath with:(XMLayout *)layout;

@end


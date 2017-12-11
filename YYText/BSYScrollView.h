//
//  BSYScrollView.h
//  YYText
//
//  Created by 1 on 2017/10/21.
//  Copyright © 2017年 com.wh1.guozhentang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  void(^SelectIndex)(NSInteger index);

@interface BSYScrollView : UIView

/**
   选择的索引
 */
@property(nonatomic,copy)SelectIndex selectIndex;
/**
   视图集合
 */
@property(nonatomic,strong)NSArray *imageArra;
/**
   滚动视图
 */
@property(nonatomic,strong)UIScrollView *mainScroll;

/**
   左视图
 */
@property(nonatomic,strong)UIImageView *leftImage;

/**
   中间视图
*/
@property(nonatomic,strong)UIImageView *middleImage;

/**
   右视图
 */
@property(nonatomic,strong)UIImageView *rightImage;


/**
   当前索引
 */
@property(nonatomic,assign)NSInteger currentIndex;
@end

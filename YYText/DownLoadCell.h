//
//  DownLoadCell.h
//  YYText
//
//  Created by 1 on 2017/11/11.
//  Copyright © 2017年 com.wh1.guozhentang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DownLoadCell;

@protocol DownloadDelegate // 代理传值方法

- (void)download:(DownLoadCell *)cell;

@end

@interface DownLoadCell : UITableViewCell

@property(nonatomic,strong)UIImageView *HeaderImage;

@property(nonatomic,strong)UILabel *speed;

@property(nonatomic,strong)UIProgressView *progress;

@property(nonatomic,strong)UIButton *starDownLoad;

@property(nonatomic,weak)id<DownloadDelegate>delegate;

@end


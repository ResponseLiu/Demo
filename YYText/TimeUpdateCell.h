//
//  TimeUpdateCell.h
//  倒计时
//
//  Created by 1 on 2018/1/8.
//  Copyright © 2018年 com.wh1.guozhentang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimerModel.h"
// 宽度
#define  Width                             [UIScreen mainScreen].bounds.size.width

// 高度
#define  Height                            [UIScreen mainScreen].bounds.size.height

@interface TimeUpdateCell : UITableViewCell

@property (nonatomic, strong) UIView      *m_backgroundView;
@property (nonatomic, strong) UILabel     *m_titleLabel;
@property (nonatomic, strong) UILabel     *m_timeLabel;
@property (nonatomic, weak)   id           m_data;
@property (nonatomic, weak)   NSIndexPath *m_tmpIndexPath;

-(void)getData:(NSMutableArray *)array with:(NSIndexPath *)indexpath;

@end

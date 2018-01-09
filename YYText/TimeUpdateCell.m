//
//  TimeUpdateCell.m
//  倒计时
//
//  Created by 1 on 2018/1/8.
//  Copyright © 2018年 com.wh1.guozhentang. All rights reserved.
//

#import "TimeUpdateCell.h"

@implementation TimeUpdateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self buildViews];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateTime:) name:@"update" object:nil];
        
    }
    
    return self;
    
}
- (void)buildViews {
    
    self.m_backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Width, 99.5)];
    [self addSubview:_m_backgroundView];
    
    _m_backgroundView.backgroundColor = [UIColor whiteColor];
    
    // 标题
    self.m_titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, Width-20, 30)];
    [_m_backgroundView addSubview:_m_titleLabel];
    
    _m_titleLabel.textColor = [UIColor blackColor];
    _m_titleLabel.font      = [UIFont fontWithName:@"Avenir-Light" size:20];
    
    // 倒计时
    self.m_timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, Width-20, 40)];
    [_m_backgroundView addSubview:_m_timeLabel];
    
    _m_timeLabel.textColor     = [UIColor blackColor];
    _m_timeLabel.textAlignment = NSTextAlignmentRight;
    _m_timeLabel.font          = [UIFont fontWithName:@"AvenirNext-UltraLight" size:30];
    
    
}
-(void)getData:(NSMutableArray *)array with:(NSIndexPath *)indexpath {
    
    
    
    [self changeTime:array with:indexpath];
    TimerModel *model = self.m_data[indexpath.row];
    self.m_titleLabel.text = model.name;
    self.m_timeLabel.text = [model currentTime];
    
}

-(void)changeTime:(NSMutableArray *)array with:(NSIndexPath *)indexpath{
    
    self.m_data = array;
    self.m_tmpIndexPath = indexpath;
    
}

-(void)updateTime:(NSNotification *)info {
    
    [self getData:self.m_data with:self.m_tmpIndexPath];
    
    
}

-(void)dealloc {
    
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

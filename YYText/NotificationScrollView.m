//
//  BSYScrollView.m
//  YYText
//
//  Created by 1 on 2017/10/21.
//  Copyright © 2017年 com.wh1.guozhentang. All rights reserved.
//

#import "NotificationScrollView.h"

#define WIDTH  [UIScreen mainScreen].bounds.size.width

@interface NotificationScrollView()

@end

@implementation NotificationScrollView

-(instancetype)initWithFrame:(CGRect)frame {
    
    if (self =[super initWithFrame:frame]) {
        
        //load subviews
        
        [self initSubView];
        
        // set Observer
        
        [self addObser];
        
    }
    return self;
}
-(void)addObser{
    
    [self.mainScroll addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}
-(void)setImageArra:(NSArray *)imageArra{
    
    _imageArra = imageArra;
    
    self.currentIndex = 0;
}
-(void)mainScrollSetOffset{
    
    self.mainScroll.contentOffset = CGPointMake(0, 200);
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"contentOffset"]) {
        
        if (self.imageArra&&self.imageArra.count>0) {
            
            CGFloat pointY = self.mainScroll.contentOffset.y;
            
            CGFloat criticalValue = .02f;
            
            if (pointY > 2 * 200 - criticalValue) {
                
                //set right drag
                
                self.currentIndex = (self.currentIndex + 1)%self.imageArra.count;
                
            }else if(pointY<criticalValue){
                
                //set left drag
                self.currentIndex = (self.currentIndex +self.imageArra.count- 1)%self.imageArra.count;
                
            }
            
        }
        
    }
}
-(void)initSubView{
    
    //create scrollview
    
    [self addSubview:self.mainScroll];
    
    //create leftImage
    
    [self.mainScroll addSubview:self.leftLabel];
    
    //create middleImage
    [self.mainScroll addSubview:self.middleLabel];
    
    //create rightImage
    [self.mainScroll addSubview:self.rightLabel];
    
}
-(void)setCurrentIndex:(NSInteger)currentIndex {
    
    
    _currentIndex = currentIndex;
    
    NSInteger leftIndex = (currentIndex + self.imageArra.count-1)%self.imageArra.count;
    
    NSInteger rightIndex = (currentIndex + 1)%self.imageArra.count;
    
    self.leftLabel.text =self.imageArra[leftIndex];
    
    self.middleLabel.text = self.imageArra[currentIndex];
    
    self.rightLabel.text =self.imageArra[rightIndex];
    
    //set contentoffset
    [self mainScrollSetOffset];
}
-(UIScrollView *)mainScroll{
    
    if (!_mainScroll) {
        
        _mainScroll = [[UIScrollView alloc]init];
        _mainScroll.showsVerticalScrollIndicator = NO;
        _mainScroll.showsHorizontalScrollIndicator = NO;
        _mainScroll.contentSize = CGSizeMake(WIDTH, 600);
        _mainScroll.backgroundColor = [UIColor redColor];
        _mainScroll.pagingEnabled = YES;
        
    }
    return _mainScroll;
}
-(UILabel *)leftLabel{
    
    if (!_leftLabel) {
        
        _leftLabel =[[UILabel alloc]init];
        _leftLabel.backgroundColor = [UIColor whiteColor];
        _leftLabel.textColor = [UIColor blackColor];
        _leftLabel.textAlignment = 1;
    
    }
    return _leftLabel;
    
}
-(UILabel *)middleLabel{
    
    if (!_middleLabel) {
        
        _middleLabel =[[UILabel alloc]init];
        _middleLabel.userInteractionEnabled = YES;
        _middleLabel.textColor = [UIColor blackColor];
        _middleLabel.textAlignment = 1;
        _middleLabel.backgroundColor = [UIColor whiteColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
        [_middleLabel addGestureRecognizer:tap];
        
    }
    return _middleLabel;
}
-(UILabel *)rightLabel{
    
    if (!_rightLabel) {
        
        _rightLabel =[[UILabel alloc]init];
        _rightLabel.textColor = [UIColor blackColor];
        _rightLabel.textAlignment = 1;
        _rightLabel.backgroundColor = [UIColor whiteColor];
    }
    
    return _rightLabel;
    
}
-(void)tap {
    
  //  self.selectIndex(self.currentIndex);
}
-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.mainScroll.frame = CGRectMake(0, 0, WIDTH, 200);
    
    self.leftLabel.frame = CGRectMake(0, 0, WIDTH, 200);
    
    self.middleLabel.frame = CGRectMake(0, 200, WIDTH, 200);
    
    self.rightLabel.frame = CGRectMake(0, 400, WIDTH, 200);
}
-(void)dealloc {
    
    //remove Observer
    
    [self.mainScroll removeObserver:self forKeyPath:@"contentOffset"];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end


//
//  BSYScrollView.m
//  YYText
//
//  Created by 1 on 2017/10/21.
//  Copyright © 2017年 com.wh1.guozhentang. All rights reserved.
//

#import "BSYScrollView.h"

#define WIDTH  [UIScreen mainScreen].bounds.size.width

@interface BSYScrollView()

@end

@implementation BSYScrollView

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
    
    self.mainScroll.contentOffset = CGPointMake(WIDTH, 0);
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"contentOffset"]) {
        
        if (self.imageArra&&self.imageArra.count>0) {
            
            CGFloat pointX = self.mainScroll.contentOffset.x;
            
            CGFloat criticalValue = .02f;
          
            if (pointX > 2 * WIDTH - criticalValue) {
                
                //set right drag
                
              self.currentIndex = (self.currentIndex + 1)%self.imageArra.count;
                
            }else if(pointX<criticalValue){
                
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
    
    [self.mainScroll addSubview:self.leftImage];
    
    //create middleImage
    [self.mainScroll addSubview:self.middleImage];
    
    //create rightImage
    [self.mainScroll addSubview:self.rightImage];
    
}
-(void)setCurrentIndex:(NSInteger)currentIndex {
    
    
    _currentIndex = currentIndex;
    
    NSInteger leftIndex = (currentIndex + self.imageArra.count-1)%self.imageArra.count;
    
    NSInteger rightIndex = (currentIndex + 1)%self.imageArra.count;
    
    // if you want to load url,you can import SDWebimage FrameWork
    
    self.leftImage.image = [UIImage imageNamed:self.imageArra[leftIndex]];
    
    self.middleImage.image = [UIImage imageNamed:self.imageArra[currentIndex]];
    
    self.rightImage.image = [UIImage imageNamed:self.imageArra[rightIndex]];
    
    //set contentoffset
    [self mainScrollSetOffset];
}
-(UIScrollView *)mainScroll{
    
    if (!_mainScroll) {
        
        _mainScroll = [[UIScrollView alloc]init];
        _mainScroll.showsVerticalScrollIndicator = NO;
        _mainScroll.showsHorizontalScrollIndicator = NO;
        _mainScroll.contentSize = CGSizeMake(3*WIDTH, 0);
        _mainScroll.backgroundColor = [UIColor redColor];
        _mainScroll.pagingEnabled = YES;
        
    }
    return _mainScroll;
}
-(UIImageView *)leftImage{
    
    if (!_leftImage) {
        
        _leftImage =[[UIImageView alloc]init];
        
    }
    
    return _leftImage;

}
-(UIImageView *)middleImage{
    
    if (!_middleImage) {
        
        _middleImage =[[UIImageView alloc]init];
        _middleImage.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
        [_middleImage addGestureRecognizer:tap];
        
    }
    
    return _middleImage;
}
-(UIImageView *)rightImage{
    
    if (!_rightImage) {
        
        _rightImage =[[UIImageView alloc]init];
        
    }
    
    return _rightImage;

}
-(void)tap {
    
    self.selectIndex(self.currentIndex);
}
-(void)layoutSubviews{
    
    [super layoutSubviews];
    
     self.mainScroll.frame = CGRectMake(0, 0, WIDTH, 200);
    
     self.leftImage.frame = CGRectMake(0, 0, WIDTH, 200);
    
     self.middleImage.frame = CGRectMake(WIDTH, 0, WIDTH, 200);
    
     self.rightImage.frame = CGRectMake(2*WIDTH, 0, WIDTH, 200);
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

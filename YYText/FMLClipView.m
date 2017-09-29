//
//  FMLClipView.m
//  YYText
//
//  Created by 1 on 2017/9/28.
//  Copyright © 2017年 com.wh1.guozhentang. All rights reserved.
//

#import "FMLClipView.h"
#import "FMLScaledImageViewCell.h"
#import "AVAsset+FMLVideo.h"
#import "UIImage+FMLClipRect.h"
#define FMLLineW 4                // 线宽
#define FMLMinImageCount 8     // 显示的图片个数
#define FMLRecordViewSDKMaxTime 180.0 ///< 最长时间限制
#define FMLImagesViewH 60  // 预览图高度
#define FMLImagesVIewW (kScreenWidth / FMLMinImageCount) // 图片宽度
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
static NSString * const FMLScaledImageId = @"FMLScaledImageId";
@interface FMLClipView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) AVAsset *asset;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *collectionImages;
@property (nonatomic, assign) Float64 totalSeconds;         ///< 总秒数
@end


@implementation FMLClipView
- (instancetype)initWithAsset:(AVAsset *)asset
{
    if (self = [super init]) {
        _asset = asset;
        
          [self initView];
          [self initData];
    }
    return self;
}
-(void)initData{
    
    self.totalSeconds = [self.asset fml_getSeconds];//视频的总秒数
      NSLog(@"---%f",self.totalSeconds);
    NSUInteger imageCount = 0;
    if (self.totalSeconds <= FMLRecordViewSDKMaxTime) {
        imageCount = FMLMinImageCount;
    
    } else {
        imageCount = ceil(self.totalSeconds * FMLMinImageCount / FMLRecordViewSDKMaxTime);
    }
    __weak typeof(self) weakSelf = self;

    [self.asset fml_getImagesCount:imageCount imageBackBlock:^(UIImage *image) {
        if (image) {
            UIImage *scaledImg = [UIImage fml_scaleImage:image maxDataSize:1024 * 20]; // 将图片压缩到最大20k进行显示
            
             [weakSelf.collectionImages addObject:scaledImg];
           
           
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.collectionView reloadData];
            });
        }
    }];
}
-(void)initView{
    
     [self addSubview:self.collectionView];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.collectionImages.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FMLScaledImageViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.imageData = self.collectionImages[indexPath.row];
    return cell;
}
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(60, 60);
        layout.minimumLineSpacing = 0;
        
        CGRect collectionRect = CGRectMake(0, 0, kScreenWidth, FMLImagesViewH);
        _collectionView = [[UICollectionView alloc] initWithFrame:collectionRect collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        [_collectionView registerNib:[UINib nibWithNibName:@"FMLScaledImageViewCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];

        _collectionView.showsHorizontalScrollIndicator = NO;
    }
    return _collectionView;
}
- (NSMutableArray *)collectionImages
{
    if (!_collectionImages) {
        _collectionImages = [NSMutableArray array];
    }
    
    return _collectionImages;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

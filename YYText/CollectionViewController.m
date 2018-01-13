//
//  CollectionViewController.m
//  YYText
//
//  Created by 1 on 2018/1/12.
//  Copyright © 2018年 com.wh1.guozhentang. All rights reserved.
//

#import "CollectionViewController.h"
#import "XMLayout.h"
#import "MovieCollectionViewCell.h"
#import <UIImageView+WebCache.h>
#define ScreenWidth ([[UIScreen mainScreen] bounds].size.width)
#define ScreenHeight ([[UIScreen mainScreen] bounds].size.height)
@interface CollectionViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,LayoutDelegate>

@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)XMLayout * waterfallLayout;

@property(nonatomic,strong)NSMutableArray *data;

@property(nonatomic,strong)NSMutableArray *height;

@property(nonatomic,strong)NSMutableDictionary *imageCache;

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     //纯属娱乐，写着玩的，代码没有封装
     //纯属娱乐，写着玩的，代码没有封装
     //纯属娱乐，写着玩的，代码没有封装
     //纯属娱乐，写着玩的，代码没有封装
    
     //纯属娱乐，写着玩的，代码没有封装
     //纯属娱乐，写着玩的，代码没有封装
     //纯属娱乐，写着玩的，代码没有封装
     //纯属娱乐，写着玩的，代码没有封装
     //纯属娱乐，写着玩的，代码没有封装
    self.title = @"自定义瀑布流";
    self.height = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    [self setupDataList];
    self.imageCache = [NSMutableDictionary dictionary];
    // Do any additional setup after loading the view.
}
- (void)setupDataList
{
    NSLog(@"--%@",self.height);
    [self.data addObject:@"http://p1.pstatp.com/large/57aa0000a50b2f81e4a5.jpg"];
     [self.data addObject:@"http://p1.pstatp.com/large/57650012d4801ec769cf.jpg"];
     [self.data addObject:@"http://p1.pstatp.com/large/4f3b000394ac92f2b4e8.jpg"];
     [self.data addObject:@"http://p3.pstatp.com/live/1080x1080/4d39000141dcd9fe95e5.jpg"];
    
     [self.data addObject:@"http://p3.pstatp.com/medium/4cd60011a1d9e42205d2.jpg"];
     [self.data addObject:@"http://p3.pstatp.com/live/100x100/551d0005c072a6c7944f.jpg"];
     [self.data addObject:@"http://p3.pstatp.com/live/720x720/551d0005c072a6c7944f.jpg"];
     [self.data addObject:@"http://p3.pstatp.com/live/1080x1080/50f10007ff3959801bf3.jpg"];
     [self.data addObject:@"http://p9.pstatp.com/live/720x720/42ab000582bab7ed4c2d.jpg"];

   
    dispatch_group_t group =  dispatch_group_create();

    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    for (int i = 0; i<self.data.count; i++) {
        
        dispatch_group_async(group, queue, ^{
            
            dispatch_group_enter(group);
            
            [[SDWebImageDownloader sharedDownloader]downloadImageWithURL:[NSURL URLWithString:self.data[i]] options:0 progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
                
                [self.imageCache setObject:image forKey:[NSString stringWithFormat:@"%d",i]];
               
                dispatch_group_leave(group);
                
            }];
            
        });
    }
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        
        for (int i = 0; i<self.imageCache.allKeys.count; i++) {
            
            UIImage *image = [self.imageCache objectForKey:[NSString stringWithFormat:@"%d",i]];
            
            [self.height addObject:image];
        }
        
        [self.collectionView reloadData];
        
    });
}
- (UICollectionView *)collectionView
{
    if(!_collectionView){
        _waterfallLayout = [[XMLayout alloc] init];
        _waterfallLayout.delegate = self;
        _waterfallLayout.column = 2;
        _waterfallLayout.columnSpace = 2;
        _waterfallLayout.itemSpace = 2;
        _waterfallLayout.Inset = UIEdgeInsetsMake(2, 2, 2, 2);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) collectionViewLayout:_waterfallLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        
        [_collectionView registerClass:[MovieCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
     
    }
    return _collectionView;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.height.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MovieCollectionViewCell *cell = (MovieCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    cell.bgImage.image = self.height[indexPath.row];

    return cell;
    
}
-(CGFloat)collectionViewitemheight:(NSIndexPath *)indexpath with:(XMLayout *)layout {

    UIImage *image =  self.height[indexpath.row];

    return image.size.height*( (self.view.frame.size.width-30)/2/image.size.width);
}
-(NSMutableArray *)data{
    
    if (!_data) {
        
        _data = [NSMutableArray array];
        
    }
    
    return _data;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

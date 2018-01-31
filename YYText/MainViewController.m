//
//  MainViewController.m
//  YYText
//
//  Created by 1 on 2017/8/10.
//  Copyright © 2017年 com.wh1.guozhentang. All rights reserved.
//

#import "MainViewController.h"
#import "SearchResultViewController.h"
@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSArray *array;
@property(nonatomic,strong)NSArray *kind;
@property (nonatomic, strong) NSString *target;

@end

@implementation MainViewController

__weak NSString *string_weak_ = nil;
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"string1: %@", string_weak_);
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"string2: %@", string_weak_);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *str = @"ewrewr";
    

    //完全的深拷贝
//    NSMutableArray *arrayTT = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4", nil];
//
//    NSMutableArray *array1 = [NSMutableArray arrayWithObjects:@"A",@"B",@"C",arrayTT, nil];
//
//    NSMutableArray *mutable = [array1 mutableCopy];
//
//    array1[1] = @"ddddd";
//
//    NSMutableArray *array2 = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:mutable] ];
//
//    NSLog(@"---%@",array1);
//
//
//    NSLog(@"---2%@",array2);
    
    

//    void (*action)(id, SEL) = (void (*)(id, SEL)) objc_msgSend;
//    action(self.target,self.action);
//    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
//
//    dispatch_async(queue, ^{
//        NSLog(@"---1");
//    });
//    dispatch_async(queue, ^{
//         NSLog(@"---2");
//    });
//    dispatch_async(queue, ^{
//         NSLog(@"---3");
//    });
//
//
//    dispatch_barrier_async(queue, ^{
//        NSLog(@"---4");
//    });
//      NSLog(@"---5");
//
//
//    dispatch_async(queue, ^{
//        NSLog(@"---6");
//    });
//    dispatch_async(queue, ^{
//        NSLog(@"---7");
//    });
//    dispatch_async(queue, ^{
//        NSLog(@"---8");
//    });

//    dispatch_group_t group = dispatch_group_create();
//
//    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_PRIORITY_DEFAULT);
//    NSMutableArray *array1 = [NSMutableArray array];
//
//    for (int i=0; i<10; i++) {
//
//        [array1 addObject:[NSNull class]];
//
//    }
//
//    for (int i=0; i<10; i++) {
//
//        dispatch_group_async(group, queue, ^{
//
//            dispatch_group_enter(group);
//            NSLog(@"---%d",i);
//            [NSThread sleepForTimeInterval:arc4random()%3];
//
//            @synchronized (self){
//
//                array1[i] = @(i);
//
//            }
//            dispatch_group_leave(group);
//
//        });
//
//
//    }
//
//    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
//
//        NSLog(@"--111-%@",array1);
//
//    });
    
   //二分法查找
    NSArray *array = @[@1,@4,@10,@20,@25,@30,@40,@50,@55,@60];
    NSInteger target = 30,min,max,mid;
    min = 0;
    max = array.count - 1;
    mid = (min+max)/2;
    
    for (int i = 0; i<array.count; i++) {
        
        if([array[i]integerValue] == target) {
            
//            NSLog(@"--找到了");
            
        }else if ([array[i]integerValue]<target){
            
            min = mid + 1;
            mid = (min + max) / 2;
            
            
        }else if ([array[i] integerValue]>target){
            
            max = mid - 1;
            mid = (min + max) / 2;
            
        }
        
        
    }
    NSObject *obj1 = nil;
    
    NSObject *obj2 =  [obj1 copy];
    
//    NSLog(@"-%@",obj2);
    
    [self performSelectorInBackground:@selector(connectToServer) withObject:nil];
    
//    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_TARGET_QUEUE_DEFAULT);
//    
//    dispatch_async(queue, ^{
//       
//        [NSThread sleepForTimeInterval:3];
//        NSLog(@"------1");
//        
//    });
//    dispatch_async(queue, ^{
//        
//        [NSThread sleepForTimeInterval:2];
//        NSLog(@"------2");
//        
//    });
//    dispatch_async(queue, ^{
//        
//        [NSThread sleepForTimeInterval:1];
//        NSLog(@"------3");
//        
//    });
    
   
    self.view.backgroundColor = [UIColor whiteColor];
    self.array = @[@"ViewController",@"ViewController1",@"LayerViewController",@"BullViewController",@"NewsDetailViewController",@"WeChatSearchViewController",@"WeChatFrindCircle",@"FMDBViewController",@"ViewController3",@"MovieParseViewController",@"DownLoadViewController",@"BannerScrollViewController",@"UpdateViewController",@"CollectionViewController"];
    self.kind = @[@"图文混排",@"微博动画",@"layer动画",@"视频弹幕",@"新闻详情",@"高仿微信搜索",@"高仿微信朋友圈",@"FMDB多线程执行",@"转场动画",@"视频裁剪",@"大文件下载",@"无限轮播",@"倒计时",@"自定义瀑布流"];
    [self initTab];
    
    // Do any additional setup after loading the view.
}
-(void)connectToServer{

//    NSLog(@"CONNECT_SEVER");
}
-(void)initTab {
    
    UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, 116, self.view.frame.size.width, self.view.frame.size.height-116)];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.kind.count;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
    
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        
    }
    cell.textLabel.text=self.kind[indexPath.row];
    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    Class class = NSClassFromString(self.array[indexPath.row]);

    [self.navigationController pushViewController:[[class alloc]init]    animated:YES];

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

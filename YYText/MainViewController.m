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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self performSelectorInBackground:@selector(connectToServer) withObject:nil];
    
    // 创建队列组
    dispatch_group_t group = dispatch_group_create();
    // 创建信号量，并且设置值为10
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(20);
    dispatch_queue_t queue = dispatch_queue_create(0, DISPATCH_QUEUE_CONCURRENT);
    for (int i = 0; i < 20; i++)
    {   // 由于是异步执行的，所以每次循环Block里面的dispatch_semaphore_signal根本还没有执行就会执行dispatch_semaphore_wait，从而semaphore-1.当循环10此后，semaphore等于0，则会阻塞线程，直到执行了Block的dispatch_semaphore_signal 才会继续执行
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_group_async(group, queue, ^{
            NSLog(@"%i",i);
            sleep(2);
            // 每次发送信号则semaphore会+1，
            dispatch_semaphore_signal(semaphore);
        });
    }
    
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
    self.array = @[@"ViewController",@"ViewController1",@"LayerViewController",@"BullViewController",@"NewsDetailViewController",@"WeChatSearchViewController",@"WeChatFrindCircle",@"FMDBViewController",@"ViewController3"];
    self.kind = @[@"图文混排",@"微博动画",@"layer动画",@"视频弹幕",@"新闻详情",@"高仿微信搜索",@"高仿微信朋友圈",@"FMDB多线程执行",@"转场动画"];
    [self initTab];
    
    // Do any additional setup after loading the view.
}
-(void)connectToServer{

    NSLog(@"CONNECT_SEVER");

}
-(void)initTab {
    
       
    UITableView *table = [[UITableView alloc]initWithFrame:self.view.frame];
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
    
    [self.navigationController pushViewController:[[class alloc]init] animated:YES];

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

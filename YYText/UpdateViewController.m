//
//  UpdateViewController.m
//  YYText
//
//  Created by 1 on 2018/1/9.
//  Copyright © 2018年 com.wh1.guozhentang. All rights reserved.
//

#import "UpdateViewController.h"
#import "TimerModel.h"
#import "TimeUpdateCell.h"
// 宽度
#define  Width                             [UIScreen mainScreen].bounds.size.width

// 高度
#define  Height                            [UIScreen mainScreen].bounds.size.height
@interface UpdateViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *table;

@property(nonatomic,strong)NSMutableArray <TimerModel *>*timeArray;

@end



@implementation UpdateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initTableView];
    [self initTime];
    
    // Do any additional setup after loading the view.
}
-(void)initData {
    
    self.timeArray = [NSMutableArray array];
    
    [self.timeArray addObject:[TimerModel getData:@"1111" with:800]];
    [self.timeArray addObject:[TimerModel getData:@"2222" with:823]];
    [self.timeArray addObject:[TimerModel getData:@"3333" with:845]];
    [self.timeArray addObject:[TimerModel getData:@"44444" with:809]];
    [self.timeArray addObject:[TimerModel getData:@"5555" with:86]];
    [self.timeArray addObject:[TimerModel getData:@"6666" with:854]];
    [self.timeArray addObject:[TimerModel getData:@"77777" with:800]];
    [self.timeArray addObject:[TimerModel getData:@"8888" with:823]]; [self.timeArray addObject:[TimerModel getData:@"99999" with:800]];
    
}
- (void)initTableView {
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,Width, Height) style:UITableViewStylePlain];
    [self.view addSubview:self.table];
    
    self.table.delegate       = self;
    self.table.dataSource     = self;
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.table registerClass:[TimeUpdateCell class] forCellReuseIdentifier:@"cell"];
    
}
-(void)initTime{
    
    NSTimer *timer =  [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerEvent) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
}
-(void)timerEvent {
    
    for (int i= 0; i<self.timeArray.count; i++) {
        
        TimerModel *model = self.timeArray[i];
        
        [model update];
        
    }
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"update" object:nil];
        
    }];
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.timeArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TimeUpdateCell * cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    [cell getData:self.timeArray with:indexPath];
    
    //    [cell loadData:model indexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TimeUpdateCell *tmpCell = (TimeUpdateCell *)cell;
    
    [tmpCell getData:self.timeArray with:indexPath];
    //    [tmpCell loadData:_m_dataArray[indexPath.row] indexPath:indexPath];
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

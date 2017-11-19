//
//  DownLoadViewController.m
//  YYText
//
//  Created by 1 on 2017/10/14.
//  Copyright © 2017年 com.wh1.guozhentang. All rights reserved.
//

#import "DownLoadViewController.h"
#import "DownLoadManager.h"
#import "DownLoadCell.h"
#import "NewViewController.h"
#import "AppDelegate.h"
@interface DownLoadViewController ()<UITableViewDelegate,UITableViewDataSource,DownloadDelegate>



@property(nonatomic,strong)UIButton *starDownLoad;

@property(nonatomic,strong)UIButton *endDownLoad;

@property(nonatomic,strong)UITableView *listTab;

@property(nonatomic,strong)NSArray *pathArra;

@end

@implementation DownLoadViewController
-(UITableView *)listTab{
    
    if (!_listTab) {
        
        _listTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _listTab.delegate = self;
        _listTab.dataSource = self;
    }
    return _listTab;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"大文件下载";
    _pathArra = @[@"http://kting.info/asdb/fiction/chuanyue/hdgddsy/2nswwz3o.mp3",@"http://kting.info/asdb/fiction/chuanyue/hdgddsy/qkioaayu.mp3",@"http://kting.info/asdb/fiction/chuanyue/hdgddsy/lbk8icio.mp3",@"http://kting.info/asdb/fiction/chuanyue/hdgddsy/1s0ox6gg.mp3"];
    self.view.backgroundColor = [UIColor whiteColor];
    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = NO;
    } else {
        // Fallback on earlier versions
    }
    [self.view addSubview:self.listTab];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(progress:) name:@"progress" object:nil];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(complete:) name:@"complete" object:nil];
    
    // Do any additional setup after loading the view.
}
-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
-(void)complete:(NSNotification *)user{
    
    NSString *row = user.object;
    NSIndexPath *index= [NSIndexPath indexPathForRow:row.integerValue inSection:0];
    [self.listTab reloadRowsAtIndexPaths:@[index] withRowAnimation:0];
    
}
-(void)progress:(NSNotification *)user{
    
    
    NSLog(@"---%@",user.object);
    
    NSDictionary *dict = user.object;
    
    NSUInteger identifier = [[dict objectForKey:@"identifier"]integerValue];
    
    Float32 progress =  [[dict objectForKey:@"progress"] floatValue];
    
     DownLoadCell *updatecell = [self.listTab cellForRowAtIndexPath:[NSIndexPath indexPathForRow:identifier inSection:0]];
    
     updatecell.progress.progress = progress;
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _pathArra.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DownLoadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        
        cell = [[DownLoadCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    if ([self isexit:indexPath.row]) {
        
        cell.progress.progress = 1;
        cell.starDownLoad.enabled = NO;
        [cell.starDownLoad setTitle:@"已完成" forState:0];
        
    }else{
        
        cell.starDownLoad.enabled = YES;
        [cell.starDownLoad setTitle:@"开始下载" forState:0];
    }
    cell.selectionStyle = 0;
    cell.delegate = self;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewViewController *new = [[NewViewController alloc]init];
    [self.navigationController pushViewController:new animated:YES];
    
}
-(void)download:(DownLoadCell *)cell {
    
     AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSIndexPath *indexpath = [self.listTab indexPathForCell:cell];
    
    NSString *path = _pathArra[indexpath.row];

    NSLog(@"---%ld",(long)indexpath.row);
    [delegate startDownloadWith:indexpath.row with:path];
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70;

}
-(BOOL)isexit:(NSInteger)indexpath{
    
    NSFileManager *defultManager = [NSFileManager defaultManager];
    
    NSString *destationPath = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%lu",(unsigned long)indexpath]];
    if (![defultManager fileExistsAtPath:destationPath]) {
        
        return NO;
    }
    
    return YES;
    
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

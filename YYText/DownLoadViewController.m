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

   
    // Do any additional setup after loading the view.
}
-(void)download:(DownLoadCell *)cell {
    

    NSIndexPath *indexpath = [self.listTab indexPathForCell:cell];
    
    DownLoadCell *updatecell = [self.listTab cellForRowAtIndexPath:indexpath];
    
    NSString *path = _pathArra[indexpath.row];
    NSLog(@"-%ld-%d",(long)indexpath.row,[[DownLoadManager Shared]checkisDownLoad:path]);
    if ([[DownLoadManager Shared]checkisDownLoad:path]==YES) {
        
        NSLog(@"--isload");
        
    } else{
        
        [[DownLoadManager Shared] startDownLoad:[NSURL URLWithString:path] withProgress:^(Float32 progress) {
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                
                updatecell.progress.progress = progress;
                
            }];
            
        } withCompletion:^(NSString *templePath) {
            
            [updatecell.starDownLoad setTitle:@"已完成" forState:UIControlStateNormal];
            
        }];
        
        
    }
    
   
    
}

-(void)download{
    
    if (self.starDownLoad.isSelected) {

        [self.starDownLoad setTitle:@"开始下载" forState:0];

    }else{
//https://api.huoshan.com/hotsoon/item/video/_playback/?video_id=1aca17a610d74a7dbaca6e97da87829b&line=0&app_id=1112&vquality=normal
//https://api.huoshan.com/hotsoon/item/video/_playback/?video_id=5556cf117e144330a24970d59fc87f86&line=0&app_id=1112&vquality=normal
        
        [self.starDownLoad setTitle:@"暂停" forState:0];
        [[DownLoadManager Shared] startDownLoad:[NSURL URLWithString:@"https://api.huoshan.com/hotsoon/item/video/_playback/?video_id=1aca17a610d74a7dbaca6e97da87829b&line=0&app_id=1112&vquality=normal"] withProgress:^(Float32 progress) {
            
            
            NSLog(@"---%f",progress);
            
        } withCompletion:^(NSString *templePath) {
            
            NSLog(@"---%@",templePath);
        }];
    }
    
//    self.starDownLoad.selected = !self.starDownLoad.selected;
  
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _pathArra.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DownLoadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[DownLoadCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }

    cell.delegate = self;
    
    cell.selectionStyle = 0;
    
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70;

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

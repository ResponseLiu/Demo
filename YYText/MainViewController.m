//
//  MainViewController.m
//  YYText
//
//  Created by 1 on 2017/8/10.
//  Copyright © 2017年 com.wh1.guozhentang. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSArray *array;
@property(nonatomic,strong)NSArray *kind;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Demo";
     self.array = @[@"ViewController",@"ViewController1",@"LayerViewController"];
     self.kind = @[@"图文混排",@"微博动画",@"layer动画"];
    [self initTab];
    // Do any additional setup after loading the view.
}
-(void)initTab{
    
    
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

//
//  WeChatSearchViewController.m
//  YYText
//
//  Created by 1 on 2017/9/9.
//  Copyright © 2017年 com.wh1.guozhentang. All rights reserved.
//
#import "WeChatSearchViewController.h"
#import "SearchResultViewController.h"
@interface WeChatSearchViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchResultsUpdating,UISearchControllerDelegate>
@property (nonatomic,retain) UISearchController *searchController;
@end

@implementation WeChatSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"通讯录";
    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = false;
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = YES;
        
    }
    [self initTab];
    
    // Do any additional setup after loading the view.
}
-(void)initTab {
    

    UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    table.tableHeaderView = self.searchController.searchBar;
    self.definesPresentationContext=YES;
    
}
-(UISearchController *)searchController{

    if (!_searchController) {
        
        SearchResultViewController *result = [[SearchResultViewController alloc]init];
        result.view.backgroundColor = [UIColor redColor];
        
        _searchController = [[UISearchController alloc]initWithSearchResultsController:result];
        
        _searchController.dimsBackgroundDuringPresentation = NO;
        
        _searchController.delegate= self;
        _searchController.searchResultsUpdater = self;
        
        _searchController.searchBar.barTintColor = [UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1.0];
        _searchController.searchBar.layer.borderWidth=1;
        _searchController.searchBar.layer.borderColor=[UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1.0].CGColor;
        [_searchController.searchBar setValue:@"取消" forKey:@"_cancelButtonText"];
        _searchController.searchBar.placeholder= @"请输入关键字搜索";
        _searchController.searchBar.showsBookmarkButton = YES;
        [_searchController.searchBar setImage:[UIImage imageNamed:@"语音"] forSearchBarIcon:UISearchBarIconBookmark state:UIControlStateNormal];
        self.definesPresentationContext=YES;
    }

    return _searchController;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    return cell;
    
}
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
    
}
- (void)willPresentSearchController:(UISearchController *)searchController
{
    NSLog(@"willPresentSearchController");
}

- (void)didPresentSearchController:(UISearchController *)searchController
{
    NSLog(@"didPresentSearchController");
    
    //    [self.view addSubview:self.searchController.searchBar];
}
- (void)willDismissSearchController:(UISearchController *)searchController
{
    NSLog(@"willDismissSearchController");
}

- (void)didDismissSearchController:(UISearchController *)searchController
{
    NSLog(@"didDismissSearchController");
}

- (void)presentSearchController:(UISearchController *)searchController
{
    NSLog(@"presentSearchController");
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

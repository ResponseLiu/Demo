//
//  WeChatFrindCircle.m
//  YYText
//
//  Created by 1 on 2017/9/9.
//  Copyright © 2017年 com.wh1.guozhentang. All rights reserved.
//

#import "WeChatFrindCircle.h"
#import "WeChatHeader.h"
#import "WeChatCell.h"
@interface WeChatFrindCircle ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *circleTab;
@property(nonatomic,strong)WeChatHeader *WeChatHeader;
@property(nonatomic,strong)NSArray *data;
@end

@implementation WeChatFrindCircle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"朋友圈";
    [self.view addSubview:self.circleTab];
    
    self.data = @[@{
        @"name":@"Summer",
        @"detail":@"心安若水，轻盈回眸，岁月的流光里流淌着千年的情愫:smile:，蓄半笺墨痕，生命的小舟在书海里迤逦而行，缬一朵梨花素雪的容颜，绽一眉芳心暗许的思念，弦一曲，荡涤纤尘的天籁，织一绵古韵幽香的梦境……:smile::cry::hehe:"

        },@{
                      @"name":@"Summer",
                      @"detail":@"流云过，蒹葭苍苍，携半卷清词，漫入红尘，用一方古砚，轻轻碾磨着尘世的烟云。墨花飞扬，紫陌生烟，在庄生的蝴蝶梦里款款起舞，把搁浅的往事在宣纸下铺展"
                      
                      },@{
                      @"name":@"Summer",
                      @"detail":@"流水潺潺，心韵悠悠，落花满庭，暗香盈袖。掬一捧湖水，拈一缕秋香。婉约明媚的律动在旖旎中绾结成洁白无瑕的心莲，任一曲水调轻轻的流泻，静静的蔓延，在薄如婵翼的素笺上浸透，再浸透……:smile::smile::smile::smile::smile:"
                      
                      },@{
                      @"name":@"Summer",
                      @"detail":@"你就是那，杳踏唐风宋雨，穿起魏晋风骨而来的女子，在潋滟轻波里低徊、漫溯，却在蛩音梵唱花落幽径时，向那缕缕清芳氤氲的方向凝望。一抹酡红的笑靥犹似一弯婉约的惆怅，那是为谁洒落的点点忧伤？"
                      
                      },@{
                      @"name":@"Summer",
                      @"detail":@"捧一本诗集:cry::cry::cry:，在唐风宋雨的古韵里:smile:，寻你，一枝出淤泥而不染的莲，濯濯迎风而魅，莲步轻移，向我靠近，看你紫色的裙袂在风中轻舞飞扬，而绚烂的紫色，熏染了层层幻梦，抖落一地的相思。"
                      
                      }];
    
    // Do any additional setup after loading the view.
}

-(UITableView *)circleTab{

    if (!_circleTab) {
        
        _circleTab = [[UITableView alloc]initWithFrame:CGRectMake(0, -90, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height+90) style:UITableViewStylePlain];
        _circleTab.showsVerticalScrollIndicator = NO;
        _circleTab.showsHorizontalScrollIndicator = NO;
        _circleTab.delegate = self;
        _circleTab.dataSource = self;
        _circleTab.backgroundColor = [UIColor whiteColor];
        _circleTab.tableHeaderView = [self WeChatHeader];
        
    }
    return _circleTab;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.data.count;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    Class class = NSClassFromString(@"WeChatCell");
    
    WeChatCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(class)];
    
    if (!cell) {
        
        cell = [[class alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WeChatCell"];
    }
    cell.dic = self.data[indexPath.row];
    cell.selectionStyle = 0;
    return cell;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    return [self getHeight:indexPath]+60;

}
-(WeChatHeader *)WeChatHeader{
 
    if (!_WeChatHeader) {
        
        _WeChatHeader = [[WeChatHeader alloc]initWithFrame:CGRectMake(0, -30, [UIScreen mainScreen].bounds.size.width, 300)];
        _WeChatHeader.backgroundColor = [UIColor whiteColor];
    
    }
    
    
    return _WeChatHeader;
    
    
}
-(CGFloat)getHeight:(NSIndexPath *)index{

    NSString *detail = self.data[index.row][@"detail"];
    CGFloat height = [detail boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-100, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.height;
    NSLog(@"%f",height);

    return height;
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
